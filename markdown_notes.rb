require 'rubygems'
require 'redcarpet'
require 'sinatra'
require 'coderay'
require 'kramdown'
#require 'github/markup'

def render(filename, string)
  Kramdown::Document.new(string, :template => 'default.erb.html').to_html
  #GitHub::Markup.render(filename, string)
end

get '/' do
  render('index.md', Dir.glob('notes/**/*.md').map { |x| "* [" + x.gsub(/_/,"\\_") + "](/#{x})" }.join("\n"))
end

get '/*.md' do
#  render(params[:splat].join('/')+".md",
#  '[\[Back to File listing\]](/)
#
#' + File.read(params[:splat].join('/') + ".md"))

  Kramdown::Document.new('[\[Back to File listing\]](/)

' + File.read(params[:splat].join('/') + ".md"), :template => 'default.erb.html').to_html
end

