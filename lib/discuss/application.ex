defmodule Discuss.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Discuss.Repo, []),
      supervisor(Discuss.Web.Endpoint, [])
    ]

    opts = [strategy: :one_for_one, name: Discuss.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
