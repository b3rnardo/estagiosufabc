class UserMailer < ActionMailer::Base
  default :from => 'estagios.licenciaturaufabc@gmail.com'
  
  include ApplicationHelper
  include MatriculasHelper
  
  def matriculas(usuario,matriculas)
    @hoje = I18n.l Time.now
    @usuario = usuario
    @matriculas = matriculas
    

    @disciplinas = [["Codigo","Nome","Turno","Dia","Horario"]]
    
    @matriculas.each do|matricula|
      disciplina_aux = Disciplina.find(matricula.disciplina_id)
      horario_inicio = I18n.l disciplina_aux.horario_inicio, :format => :hora
      horario_fim = I18n.l disciplina_aux.horario_fim, :format => :hora
      horario = "das "+horario_inicio.to_s+" as"+horario_fim.to_s
      @aux = [[disciplina_aux.codigo],[disciplina_aux.nome],[disciplina_aux.turno],[disciplina_aux.dia],[horario]]
      @disciplinas.append(@aux)
    end
    mail(:to => "bernardo_mec@live.com", :subject => "Matriculas em disciplina") 
    
  end
end
