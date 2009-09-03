class LibrariesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @library_pages, @libraries = paginate :libraries, :per_page => 10
  end

  def show
    @library = Library.find(params[:id])
  end

  def new
    @library = Library.new
    @repository_types = RepositoryType.find(:all)
  end
  
  def create
    @library = Library.new(params[:library])
    if @library.save
      flash[:notice] = 'ライブラリを追加しました。rdocの反映には１時間ほどかかります。'
      redirect_to :action => 'list'
    else
      @repository_types = RepositoryType.find(:all)
      render :action => 'new'
    end
  end

  def edit
    @library = Library.find(params[:id])
    @repository_types = RepositoryType.find(:all)
  end

  def update
    @library = Library.find(params[:id])
    if @library.update_attributes(params[:library])
      flash[:notice] = 'Library was successfully updated.'
      redirect_to :action => 'show', :id => @library
    else
      render :action => 'edit'
    end
  end

  def destroy
    Library.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
