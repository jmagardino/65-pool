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
# for i <- 1..contest_count do
#   Repo.insert!(%Contests.Contest{
#     id: i,
#     name: Faker.Pizza.topping() <> " " <> Faker.Superhero.suffix(),
#     inserted_at: ~N[2022-02-26 17:06:16],
#     updated_at: ~N[2022-02-26 17:06:16],
#     owner_account_id: :rand.uniform(3)
#   })
# end

# -- GENERATE TEAMS -- #
teams_data = %{name: SportsData.get_all_teams("FullName"), logo: SportsData.get_all_teams("WikipediaLogoUrl")}

for i <- 1..32 do
  Repo.insert!(%Games.Team{
    id: i,
    logo: Enum.at(teams_data.logo, i-1),
    name: Enum.at(teams_data.name, i-1),
    inserted_at: ~N[2022-02-26 17:06:16],
    updated_at: ~N[2022-02-26 17:06:16]
  })
end

# -- GENERATE GAMES -- #
for i <- 1..(div(32, 2)) do
  home = i
  away = 33 - home

  Repo.insert!(%Games.Game{
    id: i,
    over_under: Enum.random(60..130) / 2,
    spread: Enum.random(1..30) / 2,
    start: DateTime.truncate(Faker.DateTime.forward(14), :second),
    home_team_id: home,
    away_team_id: away,
    inserted_at: ~N[2022-02-26 17:06:16],
    updated_at: ~N[2022-02-26 17:06:16]
  })
end
