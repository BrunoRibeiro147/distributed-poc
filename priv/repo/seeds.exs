alias DistributedPoc.Repo
alias DistributedPoc.CompanySubject

%{name: "Bruno Ribeiro"}
|> CompanySubject.changeset()
|> Repo.insert()

%{name: "Rafa Oliveira"}
|> CompanySubject.changeset()
|> Repo.insert()

%{name: "Joao Pedro"}
|> CompanySubject.changeset()
|> Repo.insert()
