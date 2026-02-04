local M = {}

function M.setup()
	local web_devicons = require('nvim-web-devicons')

	-- Color palette
	local colors = {
		green = '#87af87',
		darkGreen = '#5f875f',
		brightGreen = '#98c379',
		yellow = '#e5c07b',
		darkYellow = '#d1bd74',
		orange = '#d19a66',
		darkOrange = '#D67D3E',
		orangeYellow = '#F0A500',
		red = '#e06c75',
		darkRed = '#cb3837',
		pink = '#cc6699',
		brightPink = '#ff79c6',
		purple = '#c678dd',
		darkPurple = '#7A4988',
		blue = '#61afef',
		darkBlue = '#41535b',
		lightBlue = '#84a9ac',
		cyan = '#56b6c2',
		white = '#abb2bf',
		gray = '#5c6370',
		skin = '#FFEACA',
	}

	web_devicons.set_icon({
		-- Shell & Terminal
		zsh = { icon = '󱆃', color = colors.green, name = 'Zsh' },
		sh = { icon = '', color = colors.green, name = 'Shell' },
		bash = { icon = '', color = colors.green, name = 'Bash' },
		fish = { icon = '󰈺', color = colors.green, name = 'Fish' },

		-- Web Languages
		html = { icon = '󰌝', color = colors.red, name = 'Html' },
		htm = { icon = '󰌝', color = colors.red, name = 'Htm' },
		css = { icon = '󰌜', color = colors.blue, name = 'Css' },
		scss = { icon = '', color = colors.pink, name = 'Scss' },
		sass = { icon = '', color = colors.pink, name = 'Sass' },
		less = { icon = '󰌜', color = colors.darkBlue, name = 'Less' },

		-- JavaScript/TypeScript
		js = { icon = '󰄱', color = colors.yellow, name = 'Javascript' },
		jsx = { icon = '', color = colors.cyan, name = 'JavascriptReact' },
		ts = { icon = '󰛦', color = colors.blue, name = 'Typescript' },
		tsx = { icon = '', color = colors.cyan, name = 'TypescriptReact' },
		mjs = { icon = '󰄱', color = colors.yellow, name = 'Mjs' },
		cjs = { icon = '󰄱', color = colors.yellow, name = 'Cjs' },

		-- Frameworks
		vue = { icon = '󰡄', color = colors.brightGreen, name = 'Vue' },
		svelte = { icon = '', color = colors.red, name = 'Svelte' },
		astro = { icon = '', color = colors.orange, name = 'Astro' },

		-- Python
		py = { icon = '', color = colors.blue, name = 'Python' },
		pyc = { icon = '', color = colors.darkBlue, name = 'PythonCompiled' },
		pyd = { icon = '', color = colors.blue, name = 'PythonModule' },
		pyo = { icon = '', color = colors.darkBlue, name = 'PythonOptimized' },

		-- Ruby
		rb = { icon = '', color = colors.red, name = 'Ruby' },
		erb = { icon = '', color = colors.red, name = 'Erb' },
		rake = { icon = '', color = colors.red, name = 'Rake' },
		gemspec = { icon = '', color = colors.red, name = 'Gemspec' },

		-- Go
		go = { icon = '', color = colors.cyan, name = 'Go' },

		-- Rust
		rs = { icon = '', color = colors.orange, name = 'Rust' },

		-- C/C++
		c = { icon = '', color = colors.blue, name = 'C' },
		cpp = { icon = '', color = colors.pink, name = 'Cpp' },
		cc = { icon = '', color = colors.pink, name = 'Cpp' },
		cxx = { icon = '', color = colors.pink, name = 'Cpp' },
		h = { icon = '', color = colors.purple, name = 'Header' },
		hpp = { icon = '', color = colors.purple, name = 'Hpp' },

		-- Java/JVM
		java = { icon = '', color = colors.red, name = 'Java' },
		class = { icon = '', color = colors.darkRed, name = 'JavaClass' },
		jar = { icon = '', color = colors.red, name = 'Jar' },
		kt = { icon = '', color = colors.purple, name = 'Kotlin' },
		scala = { icon = '', color = colors.red, name = 'Scala' },

		-- PHP
		php = { icon = '', color = colors.purple, name = 'Php' },

		-- Data formats
		json = { icon = '', color = colors.yellow, name = 'Json' },
		jsonc = { icon = '', color = colors.yellow, name = 'Jsonc' },
		json5 = { icon = '', color = colors.yellow, name = 'Json5' },
		yaml = { icon = '', color = colors.purple, name = 'Yaml' },
		yml = { icon = '', color = colors.purple, name = 'Yml' },
		toml = { icon = '', color = colors.gray, name = 'Toml' },
		xml = { icon = '󰗀', color = colors.orange, name = 'Xml' },
		csv = { icon = '󰈲', color = colors.green, name = 'Csv' },

		-- Markdown & Text
		md = { icon = '󰍔', color = colors.blue, name = 'Markdown' },
		mdx = { icon = '󰍔', color = colors.blue, name = 'Mdx' },
		txt = { icon = '󰈙', color = colors.lightBlue, name = 'Text' },
		log = { icon = '󰈙', color = colors.gray, name = 'Log' },

		-- Templates
		handlebars = { icon = '󰛖', color = colors.darkOrange, name = 'Handlebars' },
		hbs = { icon = '󰛖', color = colors.darkOrange, name = 'Hbs' },
		mustache = { icon = '󰛖', color = colors.darkOrange, name = 'Mustache' },
		ejs = { icon = '', color = colors.yellow, name = 'Ejs' },

		-- Docker
		dockerfile = { icon = '󰡨', color = colors.blue, name = 'Dockerfile' },
		Dockerfile = { icon = '󰡨', color = colors.blue, name = 'Dockerfile' },

		-- Database
		sql = { icon = '', color = colors.orange, name = 'Sql' },
		db = { icon = '', color = colors.gray, name = 'Database' },

		-- Images
		png = { icon = '󰋩', color = colors.purple, name = 'Png' },
		jpg = { icon = '󰋩', color = colors.purple, name = 'Jpg' },
		jpeg = { icon = '󰋩', color = colors.purple, name = 'Jpeg' },
		gif = { icon = '󰋩', color = colors.purple, name = 'Gif' },
		svg = { icon = '󰜡', color = colors.yellow, name = 'Svg' },
		ico = { icon = '󰋩', color = colors.yellow, name = 'Ico' },
		webp = { icon = '󰋩', color = colors.purple, name = 'Webp' },

		-- Fonts
		ttf = { icon = '󰛖', color = colors.white, name = 'TrueTypeFont' },
		otf = { icon = '󰛖', color = colors.white, name = 'OpenTypeFont' },
		woff = { icon = '󰛖', color = colors.white, name = 'Woff' },
		woff2 = { icon = '󰛖', color = colors.white, name = 'Woff2' },

		-- Archives
		zip = { icon = '󰗄', color = colors.gray, name = 'Zip' },
		rar = { icon = '󰗄', color = colors.gray, name = 'Rar' },
		['7z'] = { icon = '󰗄', color = colors.gray, name = 'SevenZip' },
		tar = { icon = '󰗄', color = colors.gray, name = 'Tar' },
		gz = { icon = '󰗄', color = colors.gray, name = 'Gzip' },

		-- Git
		['.gitignore'] = { icon = '', color = colors.red, name = 'GitIgnore' },
		['.gitattributes'] = { icon = '', color = colors.red, name = 'GitAttributes' },
		['.gitmodules'] = { icon = '', color = colors.red, name = 'GitModules' },

		-- Config files
		['.env'] = { icon = '', color = colors.yellow, name = 'Env' },
		['.env.local'] = { icon = '', color = colors.yellow, name = 'EnvLocal' },
		['.env.development'] = { icon = '', color = colors.yellow, name = 'EnvDevelopment' },
		['.env.production'] = { icon = '', color = colors.green, name = 'EnvProduction' },
		['.env.test'] = { icon = '', color = colors.red, name = 'EnvTest' },
		['.test.env'] = { icon = '', color = colors.red, name = 'EnvTest' },

		['.dockerignore'] = { icon = '󰡨', color = colors.darkBlue, name = 'DockerIgnore' },
		['.editorconfig'] = { icon = '', color = colors.white, name = 'EditorConfig' },
		['.eslintrc'] = { icon = '', color = colors.purple, name = 'EslintConfig' },
		['.eslintrc.js'] = { icon = '', color = colors.purple, name = 'EslintConfig' },
		['.eslintrc.json'] = { icon = '', color = colors.purple, name = 'EslintConfig' },
		['.prettierrc'] = { icon = '', color = colors.cyan, name = 'PrettierConfig' },
		['.prettierrc.js'] = { icon = '', color = colors.cyan, name = 'PrettierConfig' },
		['.prettierrc.json'] = { icon = '', color = colors.cyan, name = 'PrettierConfig' },

		-- Package managers
		['package.json'] = { icon = '', color = colors.green, name = 'PackageJson' },
		['package-lock.json'] = { icon = '', color = colors.darkRed, name = 'PackageLockJson' },
		['yarn.lock'] = { icon = '', color = colors.blue, name = 'YarnLock' },
		['pnpm-lock.yaml'] = { icon = '', color = colors.orange, name = 'PnpmLock' },
		['bun.lockb'] = { icon = '', color = colors.pink, name = 'BunLock' },
		['Gemfile'] = { icon = '', color = colors.red, name = 'Gemfile' },
		['Gemfile.lock'] = { icon = '', color = colors.darkRed, name = 'GemfileLock' },
		['Cargo.toml'] = { icon = '', color = colors.orange, name = 'CargoToml' },
		['Cargo.lock'] = { icon = '', color = colors.darkOrange, name = 'CargoLock' },
		['requirements.txt'] = { icon = '', color = colors.blue, name = 'Requirements' },
		['Pipfile'] = { icon = '', color = colors.blue, name = 'Pipfile' },
		['poetry.lock'] = { icon = '', color = colors.blue, name = 'PoetryLock' },
		['go.mod'] = { icon = '', color = colors.cyan, name = 'GoMod' },
		['go.sum'] = { icon = '', color = colors.cyan, name = 'GoSum' },

		-- Build & Task runners
		['webpack.config.js'] = { icon = '󰜫', color = colors.lightBlue, name = 'Webpack' },
		['vite.config.js'] = { icon = '', color = colors.purple, name = 'Vite' },
		['vite.config.ts'] = { icon = '', color = colors.purple, name = 'Vite' },
		['rollup.config.js'] = { icon = '', color = colors.red, name = 'Rollup' },
		['gulpfile.js'] = { icon = '', color = colors.red, name = 'Gulpfile' },
		['gruntfile.js'] = { icon = '', color = colors.orange, name = 'Gruntfile' },
		['Makefile'] = { icon = '', color = colors.gray, name = 'Makefile' },

		-- Testing
		['jest.config.js'] = { icon = '', color = colors.red, name = 'JestConfig' },
		['jest.config.ts'] = { icon = '', color = colors.red, name = 'JestConfig' },
		['vitest.config.js'] = { icon = '', color = colors.green, name = 'VitestConfig' },
		['vitest.config.ts'] = { icon = '', color = colors.green, name = 'VitestConfig' },
		['cypress.config.js'] = { icon = '', color = colors.green, name = 'CypressConfig' },
		['playwright.config.js'] = { icon = '', color = colors.red, name = 'PlaywrightConfig' },

		-- TypeScript config
		['tsconfig.json'] = { icon = '', color = colors.blue, name = 'TsConfig' },
		['tsconfig.build.json'] = { icon = '', color = colors.blue, name = 'TsConfigBuild' },

		-- Docker compose
		['docker-compose.yml'] = { icon = '󰡨', color = colors.blue, name = 'DockerCompose' },
		['docker-compose.yaml'] = { icon = '󰡨', color = colors.blue, name = 'DockerCompose' },

		-- CI/CD
		['.gitlab-ci.yml'] = { icon = '', color = colors.orange, name = 'GitlabCi' },
		['.travis.yml'] = { icon = '', color = colors.red, name = 'Travis' },
		['appveyor.yml'] = { icon = '', color = colors.blue, name = 'AppVeyor' },

		-- Framework configs
		['next.config.js'] = { icon = '󰰗', color = colors.white, name = 'NextConfig' },
		['nuxt.config.js'] = { icon = '󱄆', color = colors.green, name = 'NuxtConfig' },
		['svelte.config.js'] = { icon = '', color = colors.red, name = 'SvelteConfig' },
		['astro.config.mjs'] = { icon = '', color = colors.orange, name = 'AstroConfig' },
		['remix.config.js'] = { icon = '', color = colors.blue, name = 'RemixConfig' },

		-- License & Readme
		LICENSE = { icon = '󰗀', color = colors.yellow, name = 'License' },
		['LICENSE.md'] = { icon = '󰗀', color = colors.yellow, name = 'License' },
		['README.md'] = { icon = '󰍔', color = colors.blue, name = 'Readme' },
		['CHANGELOG.md'] = { icon = '󰍔', color = colors.green, name = 'Changelog' },

		-- Common naming patterns
		['config.js'] = { icon = '', color = colors.gray, name = 'ConfigJs' },
		['config.ts'] = { icon = '', color = colors.gray, name = 'ConfigTs' },
		['index.js'] = { icon = '󰄱', color = colors.yellow, name = 'IndexJs' },
		['index.ts'] = { icon = '󰛦', color = colors.blue, name = 'IndexTs' },

		-- Testing files
		['test.js'] = { icon = '󰙨', color = colors.red, name = 'TestJs' },
		['test.ts'] = { icon = '󰙨', color = colors.blue, name = 'TestTs' },
		['spec.js'] = { icon = '󰙨', color = colors.red, name = 'SpecJs' },
		['spec.ts'] = { icon = '󰙨', color = colors.blue, name = 'SpecTs' },

		-- Architecture patterns
		['controller.js'] = { icon = '󱂚', color = colors.yellow, name = 'Controller' },
		['controller.ts'] = { icon = '󱂚', color = colors.blue, name = 'Controller' },
		['service.js'] = { icon = '󰐪', color = colors.yellow, name = 'Service' },
		['service.ts'] = { icon = '󰐪', color = colors.blue, name = 'Service' },
		['usecase.js'] = { icon = '󰗟', color = colors.yellow, name = 'UseCase' },
		['usecase.ts'] = { icon = '󰗟', color = colors.blue, name = 'UseCase' },
		['repository.js'] = { icon = '󰗀', color = colors.yellow, name = 'Repository' },
		['repository.ts'] = { icon = '󰗀', color = colors.blue, name = 'Repository' },
		['model.js'] = { icon = '󰅪', color = colors.yellow, name = 'Model' },
		['model.ts'] = { icon = '󰅪', color = colors.blue, name = 'Model' },
		['entity.js'] = { icon = '󰙅', color = colors.blue, name = 'Entity' },
		['entity.ts'] = { icon = '󰙅', color = colors.blue, name = 'Entity' },
		['router.js'] = { icon = '󰒍', color = colors.yellow, name = 'Router' },
		['router.ts'] = { icon = '󰒍', color = colors.blue, name = 'Router' },
		['route.js'] = { icon = '󰒍', color = colors.yellow, name = 'Route' },
		['route.ts'] = { icon = '󰒍', color = colors.blue, name = 'Route' },
		['handler.js'] = { icon = '󰓔', color = colors.yellow, name = 'Handler' },
		['handler.ts'] = { icon = '󰓔', color = colors.blue, name = 'Handler' },
		['middleware.js'] = { icon = '󰴀', color = colors.yellow, name = 'Middleware' },
		['middleware.ts'] = { icon = '󰴀', color = colors.blue, name = 'Middleware' },
		['validator.js'] = { icon = '󰗠', color = colors.yellow, name = 'Validator' },
		['validator.ts'] = { icon = '󰗠', color = colors.blue, name = 'Validator' },
		['api.js'] = { icon = '󰖟', color = colors.yellow, name = 'Api' },
		['api.ts'] = { icon = '󰖟', color = colors.blue, name = 'Api' },
		['utils.js'] = { icon = '󰗀', color = colors.yellow, name = 'Utils' },
		['utils.ts'] = { icon = '󰗀', color = colors.blue, name = 'Utils' },
		['helper.js'] = { icon = '󰗀', color = colors.yellow, name = 'Helper' },
		['helper.ts'] = { icon = '󰗀', color = colors.blue, name = 'Helper' },
		['constant.js'] = { icon = '󰏿', color = colors.yellow, name = 'Constant' },
		['constant.ts'] = { icon = '󰏿', color = colors.blue, name = 'Constant' },
		['constants.js'] = { icon = '󰏿', color = colors.yellow, name = 'Constant' },
		['constants.ts'] = { icon = '󰏿', color = colors.blue, name = 'Constant' },
		['enum.js'] = { icon = '󰱲', color = colors.yellow, name = 'Enum' },
		['enum.ts'] = { icon = '󰱲', color = colors.blue, name = 'Enum' },
		['type.ts'] = { icon = '󰱲', color = colors.blue, name = 'Type' },
		['types.ts'] = { icon = '󰱲', color = colors.blue, name = 'Types' },
		['interface.ts'] = { icon = '󰱲', color = colors.blue, name = 'Interface' },
		['schema.js'] = { icon = '󰆼', color = colors.green, name = 'Schema' },
		['schema.ts'] = { icon = '󰆼', color = colors.green, name = 'Schema' },
		['command.ts'] = { icon = '󱐋', color = colors.orange, name = 'command' },
		['command.js'] = { icon = '󱐋', color = colors.orange, name = 'command' },
		['ro.ts'] = { icon = '󰈔', color = colors.green, name = 'ResponseObject' },
		['ro.js'] = { icon = '󰈔', color = colors.green, name = 'ResponseObject' },

		-- React specific
		['hook.js'] = { icon = '󱗆', color = colors.cyan, name = 'Hook' },
		['hook.ts'] = { icon = '󱗆', color = colors.cyan, name = 'Hook' },
		['context.js'] = { icon = '󱗆', color = colors.cyan, name = 'Context' },
		['context.ts'] = { icon = '󱗆', color = colors.cyan, name = 'Context' },
		['component.jsx'] = { icon = '', color = colors.cyan, name = 'Component' },
		['component.tsx'] = { icon = '', color = colors.cyan, name = 'Component' },
		['store.js'] = { icon = '󱂬', color = colors.purple, name = 'Store' },
		['store.ts'] = { icon = '󱂬', color = colors.purple, name = 'Store' },
		['reducer.js'] = { icon = '󱂬', color = colors.purple, name = 'Reducer' },
		['reducer.ts'] = { icon = '󱂬', color = colors.purple, name = 'Reducer' },
		['action.js'] = { icon = '󱂬', color = colors.purple, name = 'Action' },
		['action.ts'] = { icon = '󱂬', color = colors.purple, name = 'Action' },
		['styles.js'] = { icon = '󰌜', color = colors.pink, name = 'StyledComponent' },
		['styles.ts'] = { icon = '󰌜', color = colors.pink, name = 'StyledComponent' },

		-- Backend specific
		['server.js'] = { icon = '󰒋', color = colors.green, name = 'Server' },
		['server.ts'] = { icon = '󰒋', color = colors.green, name = 'Server' },
		['app.js'] = { icon = '󰀚', color = colors.green, name = 'App' },
		['app.ts'] = { icon = '󰀚', color = colors.green, name = 'App' },
		['main.js'] = { icon = '󰆧', color = colors.yellow, name = 'Main' },
		['main.ts'] = { icon = '󰆧', color = colors.blue, name = 'Main' },

		-- Database specific
		['mongo.js'] = { icon = '', color = colors.green, name = 'Mongo' },
		['mongo.ts'] = { icon = '', color = colors.green, name = 'Mongo' },
		['migration.js'] = { icon = '󰒍', color = colors.orange, name = 'Migration' },
		['migration.ts'] = { icon = '󰒍', color = colors.orange, name = 'Migration' },
		['seed.js'] = { icon = '󰒍', color = colors.green, name = 'Seed' },
		['seed.ts'] = { icon = '󰒍', color = colors.green, name = 'Seed' },

		-- Firebase
		['firebase.js'] = { icon = '', color = colors.yellow, name = 'Firebase' },
		['firebase.ts'] = { icon = '', color = colors.yellow, name = 'Firebase' },
		['firestore.js'] = { icon = '', color = colors.yellow, name = 'Firestore' },
		['firestore.ts'] = { icon = '', color = colors.yellow, name = 'Firestore' },
	})
end

return M
