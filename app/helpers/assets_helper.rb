Deary::App.helpers do
  def app_css_file(minified: settings.production?)
    [
      "app",
      minified ? "min" : nil,
      "css"
    ].compact.join(".")
  end

  def app_js_file(minified: settings.production?)
    [
      "app",
      minified ? "min" : nil,
      "js"
    ].compact.join(".")
  end
end
