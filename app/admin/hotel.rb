ActiveAdmin.register Hotel do
  permit_params :title, :logo, :location, :description

  form partial: 'form'

end
