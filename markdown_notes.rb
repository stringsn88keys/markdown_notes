require 'rubygems'
require 'redcarpet'
require 'sinatra'

get '/' do
  markdown Dir.glob('notes/**/*.md').map { |x| "* [" + x.gsub(/_/,"\\_") + "](/#{x})" }.join("\n")
end

get '/*.md' do
  markdown File.read(params[:splat].join('.') + ".md")
end
