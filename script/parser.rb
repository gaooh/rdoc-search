require File.dirname(__FILE__) + '/../config/environment'
require 'application'

require 'rubygems'
require 'hpricot'
require 'open-uri'

libraries = Library.find(:all)
libraries.each do | library |
  libpath = "#{RAILS_ROOT}/public/system/libraries/#{library.name}/#{library.version}"
  unless File.exist?(libpath)
    if library.repository_type.svn?
      system("svn co #{library.url} #{libpath}")
      system("rdoc #{libpath} --charset=UTF-8 --op #{libpath}/doc -m "" #{libpath} --exclude template/* " )
    elsif library.repository_type.git?
      system("git clone #{library.url} #{libpath}")
      system("rdoc #{libpath} --charset=UTF-8 --op #{libpath}/doc -m "" #{libpath} --exclude template/* " )
    end
  end
end

dirpath = "#{RAILS_ROOT}/public/system/libraries/"
Dir::open(dirpath) do | namedirs |
  namedirs.each do | namedir |
    next if namedir == "." || namedir == ".." || namedir == ".svn" || namedir == ".git"
    
    if namedir = "rails"
      Dir::open("#{dirpath}#{namedir}") do | libdirs |
        libdirs.each do | libdir |
          next if libdir == "." || libdir == ".." || libdir == ".svn" || libdir == ".git" || libdir == "doc"
          libpath = "#{dirpath}#{namedir}/#{libdir}"
          if File::ftype(libpath) == "directory"
            unless File.exist?("#{libpath}/doc")
              system("rdoc #{libpath} --charset=UTF-8 --op #{libpath}/doc -m "" #{libpath} --exclude template/* " )
            end
          
            next unless File.exist?("#{libpath}/doc/fr_method_index.html")
            
            doc = Hpricot( open("#{libpath}/doc/fr_method_index.html").read )

            library = Library.find(:first, :conditions => [" name = ? and version = 'trunk' ", libdir])
            if library.nil?
              library = Library.new({:name => libdir, :version => "trunk", :repository_type_id => 1})
              library.save
            end

            (doc/:a).each do |link|
              parts = link[:href].split(/#/)
              ruby_method = RubyMethod.find(:first, :conditions => ['filename = ? and anchor = ?', parts[0], parts[1]])
              if ruby_method.nil?
                ruby_method = RubyMethod.new({:library_id => library.id, :name => link.inner_html, :filename => parts[0], :anchor => parts[1]})
              end
              doc_detail = Hpricot( open("#{libpath}/doc/#{parts[0]}").read )
              ruby_method.description = (doc_detail/"#method-#{parts[1]}/.method-description").inner_html
              ruby_method.save
            end
          end
        end
      end
    else
      Dir::open("#{dirpath}#{namedir}") do | versiondirs |
        versiondirs.each do | versiondir |
          doc = Hpricot( open("#{dirpath}#{namedir}/#{versiondir}/doc/fr_method_index.html").read )
    
          library = Library.find(:first, :conditions => [" name = ? and version = ? ", namedir, versiondir])
          if libray.nil?
            library = Library.new({:name => namedir, :version => versiondir})
            library.save
          end
      
          (doc/:a).each do |link|
            parts = link[:href].split(/#/)
            ruby_method = RubyMethod.find(:first, :conditions => ['filename = ? and anchor = ?', parts[0], parts[1]])
            if ruby_method.nil?
              ruby_method = RubyMethod.new({:library_id => library.id, :name => link.inner_html, :filename => parts[0], :anchor => parts[1]})
            end
            doc_detail = Hpricot( open("#{dirpath}#{dir}/doc/#{parts[0]}").read )
            ruby_method.description = (doc_detail/"#method-#{parts[1]}/.method-description").inner_html
            ruby_method.save
          end
        end
      end
    end
  end
end