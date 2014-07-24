class Periodo < ActiveRecord::Base
  attr_accessible :matricula_fim, :matricula_inicio, :reajuste_fim, :reajuste_inicio,
    :quadrimestre, :ano, :cadastro_inicio, :cadastro_fim, :registrador_ci
  
  validate :matricula_inicio_menor_matricula_fim?, :reajuste_inicio_menor_reajuste_fim?
  validate :cadastro_inicio_menor_cadastro_fim?
  
  def matricula_inicio_menor_matricula_fim?
    if matricula_inicio > matricula_fim
      errors.add(:matricula_inicio, :periodo_matricula_invalido)
    end
  end 
  
  def reajuste_inicio_menor_reajuste_fim?
    if reajuste_inicio > reajuste_fim
      errors.add(:reajuste_inicio, :periodo_reajuste_invalido)
    end
  end 

  def cadastro_inicio_menor_cadastro_fim?
    if cadastro_inicio > cadastro_fim
      errors.add(:cadastro_inicio, :periodo_cadastro_invalido)
    end
  end 
  
end
