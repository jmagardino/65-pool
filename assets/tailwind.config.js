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
        'theme-blue-light': '#5D9AF9',
        'theme-blue-dark': '#3D75CE',
        'theme-gold': '#FCC885',
        'theme-darkgray': '#5B5D6B',
        'theme-gray': '#696A72'
      },
      fontFamily: {
        'body': ['"Rubik"', 'sans-serif'],
        'display': ['"Red Hat Display"', 'sans-serif']
      },
      screens: {
        'nontouch': {'raw': '(hover: hover)'}
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms')
  ]
}