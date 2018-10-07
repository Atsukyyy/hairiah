module SearchFormsHelper
  def params_present?(param)
    params[:q].present? && params[:q][param].present?
  end

  def aaa(a)
    "#{a}"
  end
end
