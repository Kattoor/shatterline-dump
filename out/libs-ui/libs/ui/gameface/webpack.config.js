const RemovePlugin = require('remove-files-webpack-plugin');

module.exports = (env, options) => {
    const mode = options.mode ? options.mode : production
	const devtool = options.devtool ? options.devtool : 'inline-source-map';

	console.log(`Running build: mode=${mode} devtool=${devtool}`);

    return {
        mode: mode,

        devtool: devtool,

        entry: __dirname + "/src/ui.ts",

        output:
        {
            filename: "build.js",
            path: __dirname + "/build"
        },

        resolve:
        {
            extensions: [".ts", ".js"]
        },

        module:
        {
            rules:
                [
                    {
                        enforce: "pre",
                        test: /\.js/,
                        exclude: /node_modules/,
                        loader: "source-map-loader"
                    },

                    {
                        test: /\.ts/,
                        exclude: /node_modules/,
                        loader: "awesome-typescript-loader"
                    }
                ]
        },

        plugins: [
            new RemovePlugin(
                mode == "production" ? {
                    after: {
                        include: [
                            __dirname + "/build/build.js.LICENSE.txt"
                        ],
                    },
                } : { after: {} }
            )
        ],

        performance: {
            hints: false
        }
    }
};