class ApplicationController < Sinatra::Base

  #set the default content type as json
  set :default_content_type, 'application/json'

  # add routes
  get '/bakeries' do
    # get all the bakeries from the database
    bakeries = Bakery.all
    # send them back as a JSON array
    bakeries.to_json
  end

  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.to_json(include: :baked_goods)
  end

  get '/baked_goods/by_price' do
    baked_goods = BakedGood.all.order(price: :desc)
    baked_goods.to_json
  end

  get '/baked_goods/most_expensive' do
    highest_price = BakedGood.maximum(:price)
    most_expensive_baked_good = BakedGood.find_by(price: highest_price)
    most_expensive_baked_good.to_json
  end

end
