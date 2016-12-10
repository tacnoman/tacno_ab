defmodule TacnoAb.PageController do
  use TacnoAb.Web, :controller

  def index(conn, params) do
    #    render conn, "index.html"
    json conn, %{ ok: true }
  end

  def create(conn, params) do
    unless Dict.has_key?(params, "name") do
      json conn, %{ ok: false, error: "You must pass param name" }
    end

    Redis.command(~w(SET #{params["name"]}_a 0))
    Redis.command(~w(SET #{params["name"]}_pv_a 0))
    Redis.command(~w(SET #{params["name"]}_b 0))
    Redis.command(~w(SET #{params["name"]}_pv_b 0))

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
      rand = :rand.uniform(100)-1
      side = "a"
      if rand > 50 do
        side = "b"
      end
    end

    Redis.command(~w(INCR #{params["name"]}_pv_#{side}))
    json conn, %{ side: side }
  end

  def convert(conn, params) do
    name = params["name"]
    experiment = Ab |> Repo.get_by(name: name)

    if experiment == nil do
      json conn, %{ ok: false, error: "You must pass an exist experiment" }
    end

    Redis.command(~w(INCR #{params["name"]}_#{params["side"]}))
    json conn, %{ ok: true }
  end
end
