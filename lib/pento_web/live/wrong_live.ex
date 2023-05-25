defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {
      :ok,
      assign(
        socket,
        score: 0,
        message: "Make a guess:",
        target: :rand.uniform(10) |> to_string()
        )
    }
  end

  def handle_event("guess", %{"number" => guess}, %{assigns: %{target: guess}} = socket) do
    correct_message = "You guessed! The number was #{guess}"
    score = socket.assigns.score + 1

    {
      :noreply,
      assign(
        socket,
        message: correct_message,
        score: score
      )
    }
  end

  def handle_event("guess", %{"number" => guess}, %{assigns: %{target: _target}} = socket) do
    wrong_message = "Your guess: #{guess}. Wrong. Guess again."

    score = socket.assigns.score - 1

    {
      :noreply,
      assign(
        socket,
        message: wrong_message,
        score: score
        )
    }
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <.link href="#" phx-click="guess" phx-value-number= {n} >
          <%= n %>
        </.link>
      <% end %>
    </h2>
    """
  end
end
