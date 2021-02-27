defmodule Rocketpay.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table :users do
      add :name, :string
      add :age, :integer
      add :email, :string
      add :password_hash, :string
      add :username, :string

      # Adiciona automaticamente o created_at e o updated_at
      timestamps()
    end

    # Cria um index e o torna único na tabela
    create unique_index(:users, [:email])
    create unique_index(:users, [:username])
  end
end
