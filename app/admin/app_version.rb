ActiveAdmin.register AppVersion do
  config.batch_actions = false
  config.filters = false

  permit_params :platform, :version, :force_upgrade, :title, :content, :download_url
  form partial: 'form'

  index do
    column :platform
    column :version
    column :title
    column :force_upgrade
    column :download_url
    actions
  end
end
