class BabyNamesController < ApplicationController
  before_filter :finesse_params
  def index
    @search = BabyName.search(params[:search])
    params.delete(:search)
    @baby_names = if params[:all]
      @search.all.paginate(:per_page => @search.all.size, :page => 1)
    else
      per_page = params[:per_page] || 10
      page = params[:page] || 1
      @search.all.paginate(:page => page, :per_page => per_page)
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @baby_names }
    end
  end

  protected
  def finesse_params
    params[:search] = params.reject{|key,value| key =~ /action|controller|all|page|format/}
  end
end

