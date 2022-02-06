// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex'
  ],
  theme: {
    extend: {
      colors: {
        'theme-blue': '#4A88EA',
        'theme-blue-light': '#75A4EF',
        'theme-gold': '#FCC885',
        'theme-darkgray': '#5B5D6B',
        'theme-gray': '#696A72'
      },
      fontFamily: {
        'body': ['"Readex Pro"', 'sans-serif'],
        'display': ['"Red Hat Display"', 'sans-serif']
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms')
  ]
}