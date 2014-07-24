module RelatoriosHelper
  
  def filtro_centro(disciplina_id)
    #checa se a disciplina é do centro
    @retornar = false    
    @disciplina = Disciplina.find(disciplina_id)
    
    if current_usuario.centro == "CMCC"
      
        if @disciplina.curso == t(:lic_matematica) #"Licenciatura em matemática"            
            @retornar = true
        
        end
    elsif current_usuario.centro == "CCNH"
      
        if @disciplina.curso == t(:lic_ciencia_bio) or @disciplina.curso == t(:lic_fisica) or @disciplina.curso == t(:lic_quimica) or @disciplina.curso == t(:lic_filosofia) #Licenciatura em ciencias biologicas, física, química ou filosofia
            @retornar = true
        end

    end
    
    @retornar
  end  
  
  def filtro_relatorio(disciplina_id)
    
    @return = true
    $disciplinas_amostradas.each do |disciplina|
        if disciplina == disciplina_id
          @return = false
          break
        end
    end
    
    $disciplinas_amostradas.append(disciplina_id)
    @return
    
  end
end
