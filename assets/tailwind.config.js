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
        'blue': '#4A88EA',
        'blue-hover': '#75A4EF',
        'gold': '#FCC885',
        'darkgray': '#5B5D6B',
        'gray': '#696A72'
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