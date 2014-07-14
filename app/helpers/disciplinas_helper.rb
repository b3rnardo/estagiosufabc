module DisciplinasHelper
  
  def concatena(id)
    @disciplina = Disciplina.find(id)
    @link = "localhost:3000/delete/disciplina"+@disciplina.id.to_string
  end
end
