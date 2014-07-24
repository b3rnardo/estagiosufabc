class Matricula < ActiveRecord::Base
  
  belongs_to :disciplina
  
  attr_accessible :aluno_id, :disciplina_id, :periodo_id, :situacao,
    :status, :observacao, :parecer, :mensagem, :arquivo, :arquivo_cache, :conceito, :horas
  
  validate :checa_matricula, :on => :create
  
  mount_uploader :arquivo, ArquivoUploader
  
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
