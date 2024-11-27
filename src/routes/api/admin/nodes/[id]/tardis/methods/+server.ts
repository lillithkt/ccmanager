import { ClientPacketType } from "$lib/packets/client";
import { ServerPacketType } from "$lib/packets/server";
import { error, json, type RequestHandler } from "@sveltejs/kit";
export const GET: RequestHandler = async ({ locals }) => {
    if (!locals.node) {
        return error(404, "Node not found");
    }
    return await new Promise((resolve) => {
        const id = locals.node!.on(ServerPacketType.GetTardisMethods, (methods) => {
            locals.node!.off(ServerPacketType.GetTardisMethods, id);
            resolve(json(methods));
        })
        locals.node!.send(ClientPacketType.GetTardisMethods, {});
    });
}