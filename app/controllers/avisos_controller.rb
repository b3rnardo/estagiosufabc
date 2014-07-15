class AvisosController < ApplicationController
  # GET /avisos
  # GET /avisos.json
  
    def realizou_matricula()
      @matriculas = Matricula.find(:all, :conditions => {:aluno_id => current_usuario.id})
      
      if @matriculas.blank?
          #não realizou matrícula no período atual
          return false
      else
          #realizou a matrícula no período atual
          return true
      end
  end
  
  before_filter :authenticate_usuario!#, :except=>[:show]
  def index
    
    @realizou_matricula = false
    if current_usuario.tipo == "Aluno"
        if realizou_matricula()
            @realizou_matricula = true
            @matriculas = Matricula.find(:all, :conditions => {:aluno_id => current_usuario.id})
        end
    end
    @avisos = Aviso.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @avisos }
    end
  end

  # GET /avisos/1
  # GET /avisos/1.json
  def show
    @aviso = Aviso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @aviso }
    end
  end

  # GET /avisos/new
  # GET /avisos/new.json
  def new
    @aviso = Aviso.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @aviso }
    end
  end

  # GET /avisos/1/edit
  def edit
    @aviso = Aviso.find(params[:id])
  end

  # POST /avisos
  # POST /avisos.json
  def create
    @aviso = Aviso.new(params[:aviso])
    @hoje = Date.current
    @aviso.data = @hoje
    respond_to do |format|
      if @aviso.save
        format.html { redirect_to @aviso, notice: 'Aviso criado com sucesso.' }
        format.json { render json: @aviso, status: :created, location: @aviso }
      else
        format.html { render action: "new" }
        format.json { render json: @aviso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /avisos/1
  # PUT /avisos/1.json
  def update
    @aviso = Aviso.find(params[:id])

    respond_to do |format|
      if @aviso.update_attributes(params[:aviso])
        format.html { redirect_to @aviso, notice: 'Aviso was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @aviso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /avisos/1
  # DELETE /avisos/1.json
  def delete
    @aviso = Aviso.find(params[:id])
    @aviso.destroy

    respond_to do |format|
      format.html { redirect_to avisos_url }
      format.json { head :no_content }
    end
  end
end
