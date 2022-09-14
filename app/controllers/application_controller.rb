class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  get '/bakeries' do
    bakeries = Bakery.all
    bakeries.to_json
  end

  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.to_json(only: [:name], include: { 
      baked_goods: { only: [ :name, :price ]}})
  end

  get '/baked_goods/by_price' do
    goods = BakedGood.order('price DESC')
    goods.to_json(only: [:name, :price])
  end

  get '/baked_goods/most_expensive' do
    expensive_good = BakedGood.all.order('price DESC').first
    expensive_good.to_json(only: [:name, :price])
  end
end
