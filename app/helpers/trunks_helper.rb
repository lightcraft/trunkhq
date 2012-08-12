module TrunksHelper
  #def _trunk_form_path(trunk)
  #  trunk.new_recor
  #  [current_user.locations.first, @trunk ||= Trunk.new]
  #
  #end

  def edit_dom_id(obj)
    dom_id(obj, :edit)
  end

  def new_dom_id(obj)
    dom_id(obj, :new)
  end
end
