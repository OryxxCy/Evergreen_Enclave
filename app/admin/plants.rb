ActiveAdmin.register Plant do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :price, :plant_type_id, :other_name, :image, :stock
  remove_filter :image_attachment, :image_blob
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :price, :plant_type_id, :other_name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :description, as: :text, input_html: { rows: 5 }
      f.input :price
      f.input :stock
      f.input :plant_type_id, :as => :select, :collection => PlantType.all
      f.input :other_name
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image, size:"200x200") : ""
    end
    f.actions
  end

end
