ActiveAdmin.register IntegralRule do
  menu priority: 5, parent: '积分管理', label: '积分规则'
  permit_params :option_type_alias, :option_type, :limit_times, :points, :opened, :icon
  config.filters = false
  config.batch_actions = false
  actions :all, except: [:show, :destroy]

  index do
    render 'index', context: self
  end

  form partial: 'form'
end
