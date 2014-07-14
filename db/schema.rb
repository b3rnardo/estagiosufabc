# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140714152956) do

  create_table "avisos", :force => true do |t|
    t.string   "detalhes"
    t.string   "autor"
    t.string   "titulo"
    t.date     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "disciplinas", :force => true do |t|
    t.string   "curso"
    t.string   "codigo"
    t.string   "nome"
    t.string   "turno"
    t.string   "dia"
    t.time     "horario_inicio"
    t.time     "horario_fim"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "matriculas", :force => true do |t|
    t.integer  "disciplina_id"
    t.integer  "aluno_id"
    t.integer  "periodo_id"
    t.integer  "situacao"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "periodos", :force => true do |t|
    t.date     "matricula_inicio"
    t.date     "matricula_fim"
    t.date     "reajuste_inicio"
    t.date     "reajuste_fim"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "quadrimestre"
    t.integer  "ano"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "nome"
    t.string   "tipo"
    t.string   "ra"
    t.string   "centro"
    t.string   "telefone"
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true

end
