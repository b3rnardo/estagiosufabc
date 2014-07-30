class Disciplina < ActiveRecord::Base
  
  has_many :matriculas
  attr_accessible :codigo, :curso, :dia, :horario_fim, :horario_inicio, :nome, :turno
  
  validate :checa_horarios
  
  def checa_horarios
    if horario_inicio > horario_fim
      errors.add(:horario_inicio, :conflito_de_horarios_no_modelo)
    end    
  end
end
