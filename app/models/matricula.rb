class Matricula < ActiveRecord::Base
  
  belongs_to :disciplina
  
  attr_accessible :aluno_id, :disciplina_id, :periodo_id, :situacao,
    :status, :observacao, :parecer, :mensagem, :arquivo, :arquivo_cache, :conceito, :horas
  
  validate :checa_matricula, :on => :create
  validate :checa_conflitos, :on => :create
  mount_uploader :arquivo, ArquivoUploader
  
    def checa_conflitos
      @matriculas = Matricula.find(:all, :conditions => {:periodo_id => periodo_id, :aluno_id => $id_do_usuario})
      i = Array.new  
      
      @matriculas.each do |matricula|
        #retorna o id de todas as disciplinas que o aluno fez o cadastro
        i.append(matricula.disciplina_id)
        
      end
      #encontra todas as disciplinas matriculadas pelo aluno
      @disciplinas = Disciplina.find(:all, :conditions => {:id =>i})
      
      @disciplina_atual = Disciplina.find(disciplina_id)
      @disciplinas.each do |disc|
        if @disciplina_atual.horario_inicio >= disc.horario_fim or @disciplina_atual.horario_fim <= disc.horario_inicio or @disciplina_atual.dia != disc.dia
          #permite que o aluno se matricule
          @test = true
        else
          errors.add(:duplicado, "horario conflitante")
          return false
        end
      end
      
      
      
    end
  
    def checa_matricula
    #impede que o aluno se matricule duas vezes na mesma disciplina e mesmo período
    
    @matricula = Matricula.find(:first, :conditions => {:disciplina_id => disciplina_id, :periodo_id => periodo_id, :aluno_id => $id_do_usuario})
    if @matricula == nil
      return true
    else
      
      errors.add(:duplicado, "ja cadastrado")
      return false
    end
    
  end 
end
