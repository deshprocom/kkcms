module Shop
  ActiveAdmin.register Shipping, as: 'Shipping', namespace: :shop do
    config.batch_actions = false
    config.filters = false

    permit_params :name, :express_id, :calc_rule
    form partial: 'form'

    index do
      render 'index', context: self
    end

    show do
      render 'show', context: self
    end
  end
end

