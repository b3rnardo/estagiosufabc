module MatriculasHelper
  
  def filtro_centro(matricula)
    #checa se a disciplina é do centro
    @retornar = false
    @matricula = matricula
    @disciplina = Disciplina.find(@matricula.disciplina_id)
    
    if current_usuario.centro == "CMCC"
      
        if @disciplina.curso == t(:lic_ciencia_bio) #"Licenciatura em ciências biológicas"
            #teste, atualizar
            @retornar = true
        
        end
      
    end
    
    @retornar
  end
  
  def disciplina_escolhida(id_da_disciplina) 
    #inicia o checkbox se o aluno escolheu a disciplina
    @matricula = Matricula.find(:first, :conditions =>{:disciplina_id => id_da_disciplina,  :aluno_id => current_usuario.id})
    if @matricula.blank?
      return false
    else
      return true
    end
  end
  
  def retorna_horario_disciplina(id_do_periodo)
    #@periodo = Periodo
  end
  
  def retorna_nome_aluno(id_do_aluno)
    @aluno = Usuario.find(id_do_aluno).nome
  end
  
  def retorna_ra(id_do_aluno)
    @aluno = Usuario.find(id_do_aluno).ra
  end
  
  def retorna_codigo(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina) 
    if @disciplina.blank?
      @retornar = "-"
    else
      @retornar = @disciplina.codigo
    end
    
  end
  
    def retorna_nome(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina) 
    
    if @disciplina.blank?
      @retornar = "-"
    else
      @retornar = @disciplina.nome
    end
  end
  
    def retorna_turno(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina) 
    
    if @disciplina.blank?
      @retornar = "-"
    else
      @retornar = @disciplina.turno
    end
  end
  
    def retorna_dia(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina) 
    
    if @disciplina.blank?
      @retornar = "-"
    else
      @retornar = @disciplina.dia
    end
  end
  
    def retorna_horario_inicio(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina) 
    
    if @disciplina.blank?
      @retornar = "-"
    else
      @retornar = @disciplina.horario_inicio
    end
  end
  
    def retorna_horario_fim(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina) 
    
    if @disciplina.blank?
      @retornar = "-"
    else
      @retornar = @disciplina.horario_fim
    end
  end
  
end
