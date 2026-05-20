module.exports = {
  content: [
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,html}"
  ],
  theme: {
    extend: {
      colors: {
        primary: "#1e3a5f",
        accent: "#00b4d8",
        dark: "#0f1e2e",
        light: "#f0f4f8"
      }
    }
  },
  plugins: []
}
