const { ESLINT_MODES } = require("@craco/craco");
module.exports = {
  style: {
    postcss: {
      plugins: [require("tailwindcss"), require("autoprefixer")],
    },
  },
  eslint: {
    mode: ESLINT_MODES.file,
    // Add `"eslintIgnore":["./src/**/*.js"],` to your `package.json`
    loaderOptions: (eslintOptions) => {
      return { ...eslintOptions, ignore: true };
    },
  },
};
