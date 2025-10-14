module ApplicationHelper
  # Mapeia as chaves do Rails Flash para as classes de alerta do Bootstrap
  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
    when :notice
      "alert-success" # Verde para sucesso
    when :alert
      "alert-danger"  # Vermelho para erro
    when :warning
      "alert-warning" # Amarelo para atenção
    when :info
      "alert-info"    # Azul claro para informação
    else
      flash_type.to_s
    end
  end
end
