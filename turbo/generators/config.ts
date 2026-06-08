import type { PlopTypes } from "@turbo/gen";

export default function generator(plop: PlopTypes.NodePlopAPI): void {
	plop.setGenerator("package", {
		description: "Crée un nouveau package @noikos/*",
		prompts: [
			{
				type: "input",
				name: "name",
				message: "Nom du package (sans @noikos/) :",
				validate: (input: string) => {
					if (!input) return "Le nom est requis";
					if (!/^[a-z-]+$/.test(input))
						return "Uniquement des lettres minuscules et tirets";
					return true;
				},
			},
			{
				type: "input",
				name: "description",
				message: "Description du package :",
			},
		],
		actions: [
			{
				type: "addMany",
				destination: "{{ turbo.paths.root }}/packages/{{name}}",
				templateFiles: "templates/package/**/*",
				base: "templates/package",
				globOptions: { dot: true },
			},
		],
	});
}
