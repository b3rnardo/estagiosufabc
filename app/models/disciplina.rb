class Disciplina < ActiveRecord::Base
  attr_accessible :codigo, :curso, :dia, :horario_fim, :horario_inicio, :nome, :turno
end
