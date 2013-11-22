Deary::App.helpers do
  def error_stylesheet(code)
    scss = Padrino.root('app', 'assets', 'stylesheets', 'errors', "#{code}.scss")
    Sass.compile_file(scss)
  end

  def data_uri(file)
    mime_type = `file --mime-type #{file}`.strip[/#{file}: (.*)/, 1]
    encoded = Base64.strict_encode64(File.binread(file)).gsub(/\n/, '')
    "data:#{mime_type};base64,#{encoded}"
  end
end
