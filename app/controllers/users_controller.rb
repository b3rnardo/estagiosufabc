class UsersController < ApplicationController
  
  
  before_filter :authenticate_usuario!#, :except=>[:show]
  
  def show
    @aluno = Usuario.find(params[:id])
  end
  
  def index
    @usuarios = Usuario.all
  end

  def edit
    @usuario = Usuario.find(params[:id])
  end
  
  def update

    @parametros = params[:usuario]
    @usuario = Usuario.find(params[:id])

      if @usuario.update_attributes(params[:usuario])
            flash[:notice] = t(:editado_com_sucesso) 
            redirect_to ('/estagios/users/')

      else
        flash[:notice] = t(:erro_ao_editar)
        respond_to do |format|
            format.html { render action: "edit" }
            format.json { render json: @usuario.errors, status: :unprocessable_entity }             
        end
      end    
    
    
  end
end
