# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pool.Repo.insert!(%Pool.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Pool.Repo
alias Pool.Accounts
alias Pool.Contests
alias Pool.Games
alias Pool.SportsData

Repo.delete_all(Accounts.User)
Repo.delete_all(Contests.Contest)
Repo.delete_all(Games.Team)
Repo.delete_all(Games.Game)

# -- SETUP -- #
contest_count = 10

# -- GENERATE USER ACCOUNTS -- #
Accounts.register_user(%{
  email: "joe@65pool.com",
  password: "000000000000",
  first_name: "joe",
  last_name: "magardino"
})

Accounts.register_user(%{
  email: "josh@65pool.com",
  password: "000000000000",
  first_name: "Josh",
  last_name: "Cobert"
})

Accounts.register_user(%{
  email: "kelly@brockington.com",
  password: "000000000000",
  first_name: "Kelly",
  last_name: "Brockington"
})

# -- GENERATE CONTESTS -- #
for i <- 1..contest_count do
  Repo.insert!(%Contests.Contest{
    id: i,
    name: Faker.Pizza.topping() <> " " <> Faker.Superhero.suffix(),
    inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
    updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
    owner_account_id: :rand.uniform(3),
    avatar: PoolWeb.ContestView.set_avatar()
  })
end

# -- GENERATE TEAMS -- #
SportsData.get_all_teams("Key") |> Enum.with_index() |> Enum.each(fn {k, i} ->
  Repo.insert!(%Games.Team{
    id: i + 1,
    logo: SportsData.get_team_details(k).logo,
    name: SportsData.get_team_details(k).full_name,
    city: SportsData.get_team_details(k).city,
    key: SportsData.get_team_details(k).key,
    conference: SportsData.get_team_details(k).conference,
    division: SportsData.get_team_details(k).division,
    stadium_details: SportsData.get_team_details(k).stadium_details,
    colors: SportsData.get_team_details(k).colors,
    inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
    updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
  })
end)

# -- GENERATE GAMES -- #
game_count = 16
for i <- 1..game_count do
  home = i
  away = 33 - home

  Repo.insert!(%Games.Game{
    id: i,
    over_under: Enum.random(60..130) / 2,
    spread: Enum.random(1..30) / 2,
    start: DateTime.truncate(Faker.DateTime.forward(14), :second),
    home_team_id: home,
    away_team_id: away,
    inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
    updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
  })
end
