class RdocSearchController < ApplicationController
  
  def index
    @libraries = Library.find(:all)
    @libraries_use_check = cookies[:libraries_use_check].nil? ? Array.new : cookies[:libraries_use_check].split(",")
  end
  
  def list
    @library = Library.find(params[:id])
    @libraries = Library.find(:all)
    @ruby_methods = RubyMethod.find(:all, :conditions => [" library_id = ? ", params[:id]])
  end
  
  def show
    @libraries = Library.find(:all)
    @ruby_method = RubyMethod.find(params[:id])
  end
  
  def ajax_search
    @phrase = (request.raw_post || request.query_string).sub(/=/, '')
    phrase = @phrase + '%'
    
    if @phrase.length >= 3 # 3文字以上でないと検索しない
      if cookies[:libraries_use_check].nil? 
        @ruby_methods = RubyMethod.find(:all, :conditions => ["name like ? ", phrase])
      else
        @ruby_methods = RubyMethod.find(:all, :conditions => ["name like ? and library_id in ( ? ) ", phrase, cookies[:libraries_use_check].split(",")])
      end
    end
    render :partial => 'search_result'
  end
  
  def search
    @libraries = Library.find(:all)
    @libraries_use_check = cookies[:libraries_use_check].nil? ? Array.new : cookies[:libraries_use_check].split(",")
    
    @phrase = params[:phrase]
    phrase = @phrase + '%'
    if @phrase.length >= 3
      if cookies[:libraries_use_check].nil? 
        @ruby_methods = RubyMethod.find(:all, :conditions => ["name like ? ", phrase])
      else
        @ruby_methods = RubyMethod.find(:all, :conditions => ["name like ? and library_id in ( ? ) ", phrase, cookies[:libraries_use_check].split(",")])
      end
    end
    render :action => 'index'
  end
  
  def remove_target_library
    libraries_use_check = cookies[:libraries_use_check].nil? ? Array.new : cookies[:libraries_use_check].split(",")
    libraries_use_check.reject! { |i| i == params[:id] }
    cookies_value = ""
    libraries_use_check.each {|j| cookies_value += "#{j},"}
    cookies[:libraries_use_check] = { :value => cookies_value, :expires => 7.days.from_now }
  end
  
  def add_target_library
    libraries_use_check = cookies[:libraries_use_check].nil? ? Array.new : cookies[:libraries_use_check].split(",")
    libraries_use_check << params[:id]
    cookies_value = ""
    libraries_use_check.each {|j| cookies_value += "#{j},"}
    p cookies_value
    cookies[:libraries_use_check] = { :value => cookies_value, :expires => 7.days.from_now }
  end
end
