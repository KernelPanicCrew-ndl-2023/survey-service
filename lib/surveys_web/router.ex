defmodule SurveysWeb.Router do
  use SurveysWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SurveysWeb do
    pipe_through :api

    resources "/questions", QuestionController, except: [:new, :edit]

    resources "/answers", AnswerController, except: [:new, :edit]
    get "/answer/:id/choose/", AnswerController, :choose

    resources "/users", UserController, except: [:new, :edit]
    post "/users/compare", UserController, :compare
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:surveys, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: SurveysWeb.Telemetry
    end
  end
end
