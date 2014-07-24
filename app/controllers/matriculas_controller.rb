class MatriculasController < ApplicationController
  # GET /matriculas
  # GET /matriculas.json
  before_filter :authenticate_usuario!#, :except=>[:show]

  def filtro
    @filtro = params[:filtro].to_a    
    $curso = @filtro[0][1]
    @bra = 4
        

    redirect_to :back
  end
  
  def download
    @matricula = Matricula.find(params[:id])
    send_file  @matricula.arquivo.path
    
  end
  
  def anexo
    
      @matricula = Matricula.find(params[:id])
      if @matricula.update_attributes(params[:informacoes])
          flash[:notice] = t(:anexo_enviado) #arquivo e mensagem enviados com sucesso!
      else
          flash[:erro] = t(:anexo_erro)
      
      end
      
  redirect_to :back
    
  end
  
  def email_matriculas
      @matriculas = Matricula.find(:all, :conditions => {:aluno_id => current_usuario.id, :periodo_id => Periodo.find(:last).id})
      UserMailer.matriculas(Usuario.find(current_usuario.id),@matriculas).deliver
      redirect_to :back
      flash[:notice] = t(:emailenviado)
  end
  
  def cadastro
    
    @periodo = Periodo.find(:last)
    @disciplinas = Disciplina.find(:all, :conditions => {:periodo_id => @periodo.id})
  end
  
  def index
    
    @periodo = Periodo.find(:last)
    
    unless @periodo.blank?
        @matriculas = Matricula.find(:all, :conditions =>{:periodo_id => @periodo.id, :status => 0})
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
  
  
  def create     #inicio
    $filtro = nil
    $id_do_usuario = current_usuario.id
    @disciplinas = params[:disciplinas]
    @cursos_antigo = Curso.find(:all, :conditions => {:aluno_id => current_usuario.id})
    @cursos_novo = params[:cursos]
    @periodo = Periodo.find(:last)
    
    if @cursos_novo.blank?
        flash[:erro] = t(:erro_curso)
        redirect_to :back
        return
        
    else
      
        @cursos_novo.each do |curso|
        @curso = Curso.new :aluno_id => current_usuario.id, :nome_do_curso => curso
        @curso.save
  
        end

      
    end
    
    @cursos_antigo.each do |curso_antigo|
      #apaga o curso, caso o aluno desmarque a caixa
      controle3 = false
      
      for i in @cursos_novo
        if i == curso_antigo.nome_do_curso
          controle3 = true
          break
          
        end
        
      end
      
      unless controle3
        curso_antigo.destroy
      end
    end
    
    
    
    if @disciplinas.blank?
        #apaga todas as matrículas, para o caso do aluno ter desmarcado
        @matriculas = Matricula.find(:all, :conditions => {:aluno_id => current_usuario.id, :periodo_id => @periodo.id})
        @matriculas.each do |matricula|
          matricula.destroy
        end
        respond_to do |format|
                format.html { redirect_to :root, notice: 'Matriculas realizadas com sucesso.' }
                format.json { render json: @matricula, status: :created, location: @matricula }
        end
        return
      
    end
    
    
    $matriculas_atuais = Matricula.find(:all, :conditions => {:aluno_id => $id_do_usuario, :periodo_id => @periodo.id})
    #procura todas as matrículas do aluno no período atual
    
    controle = false
    @disciplinas.each do |disciplina|
      
      #verifica se o aluno ja se matriculou na disciplina
      @aux = Matricula.find(:first, :conditions => {:disciplina_id => disciplina, :periodo_id => @periodo.id, :aluno_id => current_usuario.id})
      

      
      if @aux.blank?
          @matricula = Matricula.new :disciplina_id => disciplina, :aluno_id => current_usuario.id, :periodo_id => Periodo.find(:last).id, :status => 0,
          :parecer => "Aguardando analise da secretaria"
      
          unless @matricula.save
              controle = true
              break
          end        
      end
    end  
    @matriculas_atuais = Matricula.find(:all, :conditions => {:aluno_id => $id_do_usuario, :periodo_id => @periodo.id})
    
    #verifica se existe alguma matrícula fora as que o aluno solicitou agora
    # - para o caso de ter desistido de uma disciplina
    
    unless controle
    
        @matriculas_atuais.each do |matricula|
            controle2 = false
            for i in @disciplinas
          
                if i.to_i == matricula.disciplina_id
                    controle2 = true
                    break
                end
            end
      
            unless controle2
                matricula.destroy
            end
      
        end  

    end
         unless controle
            respond_to do |format|
                format.html { redirect_to :root, notice: 'Matriculas realizadas com sucesso.' }
                format.json { render json: @matricula, status: :created, location: @matricula }
            end
         else
            flash[:erro] = t(:erro_matricula) #Uma ou mais disciplinas não puderam ser salvas devido à conflito de horários
            redirect_to :back

         end
  end # fim

  # PUT /matriculas/1
  # PUT /matriculas/1.json
  def analise
    @matricula = Matricula.find(params[:id])
    @teste = params[:matricula]
    
      if @matricula.update_attributes(params[:matricula])
            UserMailer.analise_matricula(@matricula).deliver
            if @matricula.parecer ==  "Aprovado"
                  @matricula.status = 1
            else
                  @matricula.status = 2
            end
            
            @matricula.save
            flash[:notice] = t(:analise_realizada)

      
      else                
            flash[:erro] = t(:erro_analise)
      end
      redirect_to :back
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
