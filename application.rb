require 'sinatra'
require 'i18n_template'

class Application < Sinatra::Base
  get '/' do
    internationalize
  end

  post '/' do
    internationalize
  end

  include ERB::Util

  def internationalize
    @source = params[:source] || default_source

    document = I18nTemplate::Document.new(@source)
    document.process!

    @template = document.source
    @phrases = document.keys.uniq.join("\n")
    @error = document.errors.join(", ")

    erb :index
  end

  def default_source
    <<-DATA
<body>
  <h2>Hello World</h2>
  <%= link_to "Home", home_path %>
</body>
    DATA
  end
end
