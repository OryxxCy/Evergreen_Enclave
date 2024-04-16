ActiveAdmin.register Customer do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :first_name, :last_name, :email, :address, :tax_rate_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:first_name, :last_name, :email, :address, :tax_rate_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :address
      f.input :tax_rate_id, :as => :select, :collection => TaxRate.pluck(:province, :id)
    end
    f.actions
  end

end
