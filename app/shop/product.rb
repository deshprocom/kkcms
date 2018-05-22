# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Shop::Product, as: 'Product', namespace: :shop do
  config.batch_actions = false
  config.sort_order = 'published_desc'
  menu priority: 2

  filter :title
  filter :published
  filter :recommended
  filter :by_root_category_in, label: '主类别', as: :select, collection: Shop::Category.roots_collection

  permit_params :title, :description, :product_type, :category_id, :recommended,
                :published, :returnable,
                master_attributes: [:original_price, :price, :stock,
                                    :volume, :origin_point, :weight]

  sidebar '侧边栏', only: [:edit, :update, :variants] do
    product_sidebar_generator(self)
  end

  form partial: 'form'

  index do
    render 'index', context: self
  end

  controller do
    def create
      @product = Shop::Product.new(permitted_params[:shop_product])
      if @product.save
        flash[:notice] = '新建商品详情成功'
        redirect_to edit_shop_product_path(@product)
      else
        render :new
      end
    end

    def update
      @product = Shop::Product.find(params[:id])
      @product.assign_attributes(permitted_params[:shop_product])
      if @product.save
        flash[:notice] = '修改商品详情成功'
        redirect_to edit_shop_product_path(@product)
      else
        flash[:error] = '修改商品详情失败'
        render :edit
      end
    end
  end

  member_action :publish, method: :post do
    Shop::Product.find(params[:id]).publish!
    redirect_back fallback_location: shop_products_url, notice: '上架商品成功'
  end

  member_action :unpublish, method: :post do
    Shop::Product.find(params[:id]).unpublish!
    redirect_back fallback_location: shop_products_url, notice: '已下架商品'
  end

  member_action :recommend, method: :post do
    Shop::Product.find(params[:id]).recommend!
    redirect_back fallback_location: shop_products_url, notice: '推荐商品成功'
  end

  member_action :unrecommend, method: :post do
    Shop::Product.find(params[:id]).unrecommend!
    redirect_back fallback_location: shop_products_url, notice: '已取消推荐商品'
  end
end
