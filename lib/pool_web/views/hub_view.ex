defmodule PoolWeb.HubView do
  use PoolWeb, :view

  # sets weather icon
  def set_icon(code) do
    case code do
      "01d" -> "fa-solid fa-sun"
      "01n" -> "fa-solid fa-moon-stars"
      "02d" -> "fa-solid fa-sun-cloud"
      "02n" -> "fa-solid fa-moon-cloud"
      "03d" -> "fa-solid fa-cloud-sun"
      "03n" -> "fa-solid fa-cloud-moon"
      "04d" -> "fa-solid fa-clouds-sun"
      "04n" -> "fa-solid fa-clouds-moon"
      "09d" -> "fa-solid fa-cloud-drizzle"
      "09n" -> "fa-solid fa-cloud-moon-rain"
      "10d" -> "fa-solid fa-cloud-rain"
      "10n" -> "fa-solid fa-cloud-moon-rain"
      "11d" -> "fa-solid fa-cloud-bolt"
      "11n" -> "fa-solid fa-cloud-bolt-moon"
      "13d" -> "fa-solid fa-snowflakes"
      "13n" -> "fa-solid fa-snowflakes"
      "50d" -> "fa-solid fa-cloud-fog"
      "50n" -> "fa-solid fa-cloud-fog"
    end
  end
end
