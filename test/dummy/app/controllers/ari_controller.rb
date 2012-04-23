class AriController < ActionController::Base
  def index
    @models = Ari::Inspector.collect_models()
  end
  
  def show
    @data = Ari::Inspector.inspect_data(params[:id], params[:method], params[:where], params[:parent_model], params[:parent_id], params[:belongs_to], params[:collection], params[:offset].to_i)
  end
  
end