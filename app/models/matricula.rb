class Matricula < ActiveRecord::Base
  attr_accessible :aluno_id, :disciplina_id, :periodo_id, :situacao,
    :status, :observacao, :parecer
end
