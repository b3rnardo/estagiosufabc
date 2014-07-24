class Disciplina < ActiveRecord::Base
  
  has_many :matricula
  attr_accessible :codigo, :curso, :dia, :horario_fim, :horario_inicio, :nome, :turno
end
