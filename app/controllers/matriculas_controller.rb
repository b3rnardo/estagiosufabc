class MatriculasController < ApplicationController
  # GET /matriculas
  # GET /matriculas.json
  before_filter :authenticate_usuario!#, :except=>[:show]

  def email_matriculas
      @matriculas = Matricula.find(:all, :conditions => {:aluno_id => current_usuario.id, :periodo_id => Periodo.find(:last).id})
      UserMailer.matriculas(Usuario.find(current_usuario.id),@matriculas).deliver
      redirect_to :back
      flash[:notice] = t(:emailenviado)
  end
  
  def cadastro
    @disciplinas = Disciplina.all
  end
  
  def index
    if current_usuario.tipo == "Aluno"
      @matriculas = Matricula.find(:all, :conditions => {:aluno_id => current_usuario.id, :periodo_id => Periodo.find(:last).id})
    else
      # o usuário é secretaria/administrador
      @matriculas = Matricula.all
    end
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @matriculas }
    end
  end

  # GET /matriculas/1
  # GET /matriculas/1.json
  def show
    @matricula = Matricula.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @matricula }
    end
  end

  # GET /matriculas/new
  # GET /matriculas/new.json
  def new
    @matricula = Matricula.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @matricula }
    end
  end

  # GET /matriculas/1/edit
  def edit
    @matricula = Matricula.find(params[:id])
  end

  # POST /matriculas
  # POST /matriculas.json
  
  def teste
    @matricula = Matricula.new
    @teste = 4
    unless @matricula.empty?
      teste
    end
  end
  
  def create    
    @disciplinas = params[:disciplinas] 
    controle = false
    @disciplinas.each do |disciplina|
      @matricula = Matricula.new :disciplina_id => disciplina, :aluno_id => current_usuario.id
        
      unless @matricula.save
          controle = true
          break
      end
      
    end
    
    respond_to do |format|
      unless controle
        format.html { redirect_to :root, notice: 'Matricula realizada com sucesso.' }
        format.json { render json: @matricula, status: :created, location: @matricula }
      else
        format.html { render action: "cadastro" }
        format.json { render json: @matricula.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /matriculas/1
  # PUT /matriculas/1.json
  def update
    @matricula = Matricula.find(params[:id])

    respond_to do |format|
      if @matricula.update_attributes(params[:matricula])
        format.html { redirect_to @matricula, notice: 'Matricula was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @matricula.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matriculas/1
  # DELETE /matriculas/1.json
  def destroy
    @matricula = Matricula.find(params[:id])
    @matricula.destroy

    respond_to do |format|
      format.html { redirect_to matriculas_url }
      format.json { head :no_content }
    end
  end
end
