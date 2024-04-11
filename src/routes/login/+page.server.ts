import serverConfig from '$lib/config';
import { redirect, type Actions } from '@sveltejs/kit';

export const actions: Actions = {
	default: async ({ request, cookies }) => {
		const data = await request.formData();
		const password = data.get('password') as string;
		if (!password || password !== serverConfig.passwords.admin) {
			return { success: false };
		}
		cookies.set('password', password, { path: '/' });
		return redirect(302, '/');
	}
};
