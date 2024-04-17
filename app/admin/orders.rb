ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :total, :gst_tax, :customer_id, :hst_tax, :pst_tax
  #
  # or
  #
  # permit_params do
  #   permitted = [:total, :gst_tax, :customer_id, :hst_tax, :pst_tax, :total_price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :total
      f.input :gst_tax
      f.input :hst_tax
      f.input :pst_tax
      f.input :customer_id, :as => :select, :collection => User.pluck(Arel.sql("CONCAT(`firstname`, ' ', `lastname`)"), :id)
    end
    f.actions
  end
end
