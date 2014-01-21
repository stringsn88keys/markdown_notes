require 'rubygems'
require 'redcarpet'
require 'sinatra'
require 'coderay'
require 'kramdown'
#require 'github/markup'

class MarkdownNotes < Sinatra::Application
  def template_file
    @template ||= File.expand_path(File.dirname(__FILE__) + '/views/default.erb')
  end
  def render_with_template(filename, string)
    Kramdown::Document.new(string, :template => template_file).to_html
    #GitHub::Markup.render(filename, string)
  end

  def file_list
    Dir.glob('notes/**/*.md')
  end

  get '/' do
    render_with_template('index.md', file_list.map { |x| "* [" + x[0].gsub(/_/,"\\_") + "](/#{x[1]})" }.join("\n"))
    erb :index, :layout => :default, :locals => { :file_list => file_list }
  end

  get '/*.md' do
  #  render(params[:splat].join('/')+".md",
  #  '[\[Back to File listing\]](/)
  #
  #' + File.read(params[:splat].join('/') + ".md"))

    Kramdown::Document.new('[\[Back to File listing\]](/)

  ' + File.read(params[:splat].join('/') + ".md"), :template => template_file).to_html
  end
end
