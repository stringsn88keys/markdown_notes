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

def file_list
  Dir.glob('notes/**/*.md')
end

get '/' do
  render('index.md', file_list.map { |x| "* [" + x[0].gsub(/_/,"\\_") + "](/#{x[1]})" }.join("\n"))
  erb :index, :layout => :default, :locals => { :file_list => file_list }
end

get '/*.md' do
#  render(params[:splat].join('/')+".md",
#  '[\[Back to File listing\]](/)
#
#' + File.read(params[:splat].join('/') + ".md"))

  Kramdown::Document.new('[\[Back to File listing\]](/)

' + File.read(params[:splat].join('/') + ".md"), :template => 'views/default.erb').to_html
end

