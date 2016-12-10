defmodule Ab do
  use Ecto.Model

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "ab" do
    field :name
    field :a, :integer
    field :b, :integer
    field :a_pv, :integer
    field :b_pv, :integer
  end
end
