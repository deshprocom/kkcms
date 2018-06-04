ActiveAdmin.register IntegralRule do
  permit_params :option_type_alias, :option_type, :limit_times, :points, :opened
  config.filters = false
  config.batch_actions = false
  actions :all, except: [:show, :destroy]

  index do
    render 'index', context: self
  end
end
