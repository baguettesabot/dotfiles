local project_name = vim.fn.fnamemodify(require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}), ':p:h:t')
local workspace_dir = "/home/baguette/jdtls-data/" .. project_name

local config = {
	cmd = {
		"/usr/lib/jvm/java-17-openjdk/bin/java",

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens", "java.base/java.util=ALL-UNNAMED",
		"--add-opens", "java.base/java.lang=ALL-UNNAMED",

		"-jar", "/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar",

		"-configuration", "/usr/share/java/jdtls/config_linux",

		"-data", workspace_dir,
	},

	root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

	on_attach = require("config.on-attach"),

	settings = {
		java = {

		},
		eclipse = {
			downloadSources = true,
		},
		maven = {
			downloadSources = true,
		},
		implementationsCodeLens = {
			enabled = true,
		},
		referencesCodeLens = {
			enabled = true,
		},
		references = {
			includeDecompilesSources = true;
		}
	},

	init_options = {
		bundles = {}
	},
}

require("jdtls").start_or_attach(config)
