ActiveAdmin.register Hotel do
  filter :id
  filter :title
  filter :location


  index do
    render 'index', context: self
  end

  permit_params :title, :logo, :location, :description
  form partial: 'form'

  show do
    render 'show', context: self
  end
end
