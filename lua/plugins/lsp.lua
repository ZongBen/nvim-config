return {
	{
		"Hoffs/omnisharp-extended-lsp.nvim",
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"omnisharp",
					"tailwindcss",
					"docker_compose_language_service",
					"gopls",
					"html",
					"jsonls",
					"lua_ls",
					"cssls",
					"rust_analyzer",
					"ts_ls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			local packagePath
			local slash
			if os.getenv("OS") == "Windows_NT" then
				packagePath = os.getenv("LOCALAPPDATA") .. "\\nvim-data\\mason\\packages"
				slash = "\\"
			else
				packagePath = os.getenv("HOME") .. "/.local/share/nvim/mason/packages"
				slash = "/"
			end

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			lspconfig.omnisharp.setup({
				capabilities = capabilities,
				cmd = {
					"dotnet",
					packagePath .. slash .. "omnisharp" .. slash .. "libexec" .. slash .. "OmniSharp.dll",
				},
				settings = {
					FormattingOptions = {
						-- Enables support for reading code style, naming convention and analyzer
						-- settings from .editorconfig.
						EnableEditorConfigSupport = true,
						-- Specifies whether 'using' directives should be grouped and sorted during
						-- document formatting.
						OrganizeImports = nil,
					},
					MsBuild = {
						-- If true, MSBuild project system will only load projects for files that
						-- were opened in the editor. This setting is useful for big C# codebases
						-- and allows for faster initialization of code navigation features only
						-- for projects that are relevant to code that is being edited. With this
						-- setting enabled OmniSharp may load fewer projects and may thus display
						-- incomplete reference lists for symbols.
						LoadProjectsOnDemand = nil,
					},
					RoslynExtensionsOptions = {
						-- Enables support for roslyn analyzers, code fixes and rulesets.
						EnableAnalyzersSupport = nil,
						-- Enables support for showing unimported types and unimported extension
						-- methods in completion lists. When committed, the appropriate using
						-- directive will be added at the top of the current file. This option can
						-- have a negative impact on initial completion responsiveness,
						-- particularly for the first few completion sessions after opening a
						-- solution.
						EnableImportCompletion = nil,
						-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
						-- true
						AnalyzeOpenDocumentsOnly = nil,
					},
					Sdk = {
						-- Specifies whether to include preview versions of the .NET SDK when
						-- determining which version to use for project loading.
						IncludePrereleases = true,
					},
				},
				handlers = {
					["textDocument/definition"] = require("omnisharp_extended").definition_handler,
					["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
					["textDocument/references"] = require("omnisharp_extended").references_handler,
					["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
				},
			})
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})
			lspconfig.docker_compose_language_service.setup({
				capabilities = capabilities,
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.eslint.setup({
				capabilities = capabilities,
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
		end,
	},
}
