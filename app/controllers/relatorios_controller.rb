class RelatoriosController < ApplicationController
  
  before_filter :authenticate_usuario!, :except=>[:view]
  prawnto :prawn => {:page_size   => "A4"}

  def envio
    @lista_recebida = params[:lista].to_a
    @disciplina = Disciplina.find(params[:id])
    @periodo = @disciplina.periodo_id
    @emails = @lista_recebida[0][1].split(';') 
    
    @emails.each do |email|

      UserMailer.relatorio_matriculas(email,@disciplina,Usuario.find(current_usuario.id)).deliver
      
    end
      flash[:notice] = t(:emailenviado)
      redirect_to :back
      
  end
  
  def view
    
    @disciplinas = Disciplina.find(:all, :conditions =>{:codigo => params[:codigo], :periodo_id => params[:periodo]})
    @ids = [nil]
    @disciplinas.each do |disciplina|
      @ids.append(disciplina.id)
    end
    
    @periodo = Periodo.find(params[:periodo])
    @matriculas = Matricula.find(:all, :conditions =>{:disciplina_id => @ids}, :order => "aluno_id")
    @agora = Time.now
    
  end
  
  def index
    @periodos = Periodo.all
    @periodos.reverse!

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @periodos }
    end
  end 
  
  def show

    $disciplinas_amostradas = [nil]
    
    @periodo = Periodo.find(params[:id])
    unless @periodo.blank?
      
      
      @disciplinas = Disciplina.find(:all, :conditions => {:periodo_id => params[:id]}, :order => "curso")
      @titulo = "Disciplinas ofertadas para o "+@periodo.quadrimestre.to_s+" de "+@periodo.ano.to_s+" pelo "+current_usuario.centro.to_s
    else
      @titulo = t(:semperiodo) #"Nenhum período cadastrado"
    end
    
  end
end
