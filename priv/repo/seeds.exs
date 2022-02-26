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
alias Faker.Person
alias Faker.Internet
alias Faker.Team

Repo.delete_all(Accounts.User)
Repo.delete_all(Contests.Contest)
Repo.delete_all(Games.Team)
Repo.delete_all(Games.Game)

# -- GENERATE USER ACCOUNTS -- #
Accounts.register_user(%{
  email: "joe@65pool.com",
  password: "123456789012",
  first_name: "joe",
  last_name: "magardino"
})

Accounts.register_user(%{
  email: "josh@65pool.com",
  password: "123456789012",
  first_name: "Josh",
  last_name: "Cobert"
})

for _ <- 1..10 do
  Accounts.register_user(%{
    email: Internet.email(),
    password: Faker.String.base64(12),
    first_name: Person.first_name(),
    last_name: Person.last_name()
  })
end

# -- GENERATE CONTESTS -- #
for i <- 1..10 do
  Repo.insert!(%Contests.Contest{
    id: i,
    name: Faker.Pizza.topping() <> " " <> Faker.Superhero.suffix(),
    inserted_at: ~N[2022-02-26 17:06:16],
    updated_at: ~N[2022-02-26 17:06:16],
    owner_account_id: :rand.uniform(10)
  })
end

# -- GENERATE TEAMS -- #
for i <- 1..10 do
  Repo.insert!(%Games.Team{
    id: i,
    logo: "https://picsum.photos/seed/picsum/200/200",
    name: Team.name(),
    inserted_at: ~N[2022-02-26 17:06:16],
    updated_at: ~N[2022-02-26 17:06:16]
  })
end

# -- GENERATE GAMES -- #
for i <- 1..5 do
  home = i
  away = 11 - home
  Repo.insert!(%Games.Game{
    id: i,
    over_under: Enum.random(60..130)/2,
    spread: Enum.random(1..30)/2,
    start: DateTime.truncate(Faker.DateTime.forward(14), :second),
    home_team_id: home,
    away_team_id: away,
    inserted_at: ~N[2022-02-26 17:06:16],
    updated_at: ~N[2022-02-26 17:06:16]
  })
end
