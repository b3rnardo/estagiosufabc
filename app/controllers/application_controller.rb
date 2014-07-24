class ApplicationController < ActionController::Base
  
  protect_from_forgery
  before_filter :authenticate_usuario!#, :except=>[:show]


  def retorna_nome_aluno(id_do_aluno)
    @aluno = Usuario.find(id_do_aluno).nome
  end
  
  def retorna_ra(id_do_aluno)
    @aluno = Usuario.find(id_do_aluno).ra
  end    
  
  def retorna_nome_disciplina(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina).nome
  end
  
  def retorna_codigo(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina).codigo
  end
  
    def periodo_atual()
        @periodos = Periodo.find(:all, :conditions => ['cadastro_inicio <= ? AND reajuste_fim >= ?', Date.today, Date.today])
        @periodo = @periodos[0]
        @periodo
    end

  
end
