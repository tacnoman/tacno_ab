defmodule TacnoAb.PageController do
  use TacnoAb.Web, :controller

  def index(conn, params) do
    #    render conn, "index.html"
    json conn, %{ ok: true }
  end

  def create(conn, params) do
    unless "name" in params do
      json conn, %{ ok: false, error: "You must pass param name" }
    end

    experiment = %Ab{ name: params["name"], a: 0, b: 0, a_pv: 0, b_pv: 0} |> Repo.insert!
    json conn, %{ ok: true, experiment: experiment.name }
  end

  def sort(conn, params) do
    name = params["name"]
    experiment = Ab |> Repo.get_by(name: name)

    if experiment == nil do
      json conn, %{ ok: false, error: "You must pass an exist experiment" }
    end

    if Dict.has_key?(params, "side") and (params["side"] == "a" or params["side"] == "b") do
      side = params["side"]
    else
      vv = :rand.uniform(100)-1
      side = "a"
      if vv > 50 do
        side = "b"
      end
    end

    if side == "a" do
      value = experiment.a_pv + 1
      experiment = %{ experiment | a_pv: value}
    else
      value = experiment.b_pv + 1
      experiment = %{ experiment | b_pv: value}
    end
    Repo.update!(experiment)
    json conn, %{ side: side }
  end
end
