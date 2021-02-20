module.exports = {
  purge: [
    './src/**/*.html',
    './src/**/*.js',    
  ],
  darkMode: false, // or 'media' or 'class'
  corePlugins: {
    container: false
  },
  plugins: [
    require('@tailwindcss/forms')
  ],  
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  }
}
