module MatriculasHelper
  
  def disciplina_escolhida(id_da_disciplina) 
    #inicia o checkbox se o aluno escolheu a disciplina
    @matricula = Matricula.find(:first, :conditions =>{:disciplina_id => id_da_disciplina, :periodo_id => Periodo.find(:last).id, :aluno_id => current_usuario.id})
    if @matricula.blank?
      return false
    else
      return true
    end
  end
  
  def retorna_codigo(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina) 
    if @disciplina.blank?
      @retornar = "Disciplina excluida"
    else
      @retornar = @disciplina.codigo
    end
    
  end
  
    def retorna_nome(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina) 
    
    if @disciplina.blank?
      @retornar = "Disciplina excluida"
    else
      @retornar = @disciplina.nome
    end
  end
  
end
