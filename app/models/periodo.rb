class Periodo < ActiveRecord::Base
  attr_accessible :matricula_fim, :matricula_inicio, :reajuste_fim, :reajuste_inicio,
    :quadrimestre, :ano
end
