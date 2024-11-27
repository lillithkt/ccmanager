import { ClientPacketType } from "$lib/packets/client";
import { ServerPacketType } from "$lib/packets/server";
import { error, json, type RequestHandler } from "@sveltejs/kit";
export const POST: RequestHandler = async ({ request, locals }) => {
    const body = await request.json();
    if (!locals.node) {
        return error(404, "Node not found");
    }
    const nonce = Math.random().toString(36).substring(7);
    return new Promise((res) => {
        const id = locals.node!.on(ServerPacketType.ExecuteTardisMethod, (response) => {
            if (response.nonce === nonce) {
                locals.node!.off(ServerPacketType.ExecuteTardisMethod, id);
                res(json(response));
            }
        });
        locals.node!.send(ClientPacketType.ExecuteTardisMethod, {
            method: body.method,
            args: body.args,
            nonce
        });
    })
}