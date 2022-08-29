Select *
From portfolio_project.dbo.covid_deaths

Select*
From portfolio_project.dbo.covid_vaccination


-- finding total cases vs total deaths percentage
Select location,  date, total_cases, total_deaths, total_deaths/total_cases * 100 as death_percentage
From portfolio_project.dbo.covid_deaths
order by 1,2


-- finding total cases vs population (Infection percentage)

Select location, date, total_cases, population, total_cases/population * 100 as infection_percentage 
From portfolio_project.dbo.covid_deaths
order by 1,2


-- Global infection continent wise

select continent, MAX(total_cases) 
From portfolio_project.dbo.covid_deaths
where continent is not NULL
Group by continent


--Global deaths continent wise

Select continent, MAX(CAST(total_deaths as int)) as Totaldeathcount
From portfolio_project.dbo.covid_deaths
where continent is not null
Group by continent
order by Totaldeathcount desc



-- Countries with highest infection rates

Select location,MAX(total_cases) as HIghest_infection_count, population, MAX((total_cases/population)*100) as highestinfectionpercentage
From portfolio_project.dbo.covid_deaths
Group by population, location
order by highestinfectionpercentage desc

-- Countries with highest death rates

Select location, MAX(CAST(total_deaths as int)) as Highest_death_count
From portfolio_project.dbo.covid_deaths
Where continent is not Null
Group by location
order by Highest_death_count desc


-- countries with most vaccination 

select death.location, death.population, MAX(CAST(vaccine.total_vaccinations as bigint)) as total_vaccination
from portfolio_project.dbo.covid_deaths death
join portfolio_project.dbo.covid_vaccination vaccine
on death.location = vaccine.location
where death.continent is not null
Group by death.location, death.population
order by 3 desc



-- population vs people fully vaccinated

select death.location, death.population, MAX(CAST(vaccine.people_fully_vaccinated as bigint)) as full_vaccination
from portfolio_project.dbo.covid_deaths death
join portfolio_project.dbo.covid_vaccination vaccine
on death.location = vaccine.location
where death.continent is not null
Group by death.location, death.population
order by 3 desc

--CTE to find percentage of people fully vaccinated

with fullvaccinations ( location, population, full_vaccination)
as
(
select death.location, death.population, MAX(CAST(vaccine.people_fully_vaccinated as bigint)) as full_vaccination
from portfolio_project.dbo.covid_deaths death
join portfolio_project.dbo.covid_vaccination vaccine
on death.location = vaccine.location
where death.continent is not null
Group by death.location, death.population
)
Select * , full_vaccination/population * 100 as percent_people_Fully_vaccinated 
from fullvaccinations
order by 1,2
