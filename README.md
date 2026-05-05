# 🏒 SHL Analytics Website

Beginning of a full-stack hockey analytics project that evaluates SHL players and teams by transforming performance data into ranked insights using SQL-based models

## 💡 Current features

- **Goalie Analytics**
  - Interactive table with sorting
  - Key stats: SVS%, Saves, GA, GAA, Games Played, Shutouts
  - Custom ranking model combining SVS% (higher is better) and GAA (lower is better)
  - Uses SQL function (`RANK()`) to generate a combined rank score.

- **Clutch Performance**
  - Compares playoff vs regular season performance
  - Highlights goalies who perform better under pressure
  
- **Team Rankings**
  - Weighted averages across all goalies per team
  - Separate views for:
    - Regular season
    - Overall (including playoffs & relegation)
   
## 📈 Future Improvements
- Add skater analytics and rankings
- Improve UI/UX design
- Add filtering and search functionality
- Deploy live version (API + frontend)

## 🗄 Database Setup
Run the SQL scripts in the following order:
1.	database/create_database.sql
2.	database/create_tables.sql
3.	database/populate_teams.sql
4.	database/populate_players_goalies.sql
5.	database/populate_goaliestats.sql

## ⚙️ Configuration
Update your connection string in appsettings.json depending on your SQL Server setup.
- **Option 1: Windows Authentication (local development)**
- "ConnectionStrings": {"DefaultConnection": "Server=localhost;Database=shl;Trusted_Connection=True;"
}
- **Option 2: SQL Server Authentication**
- "ConnectionStrings": {"DefaultConnection": "Server=localhost;Database=shl;User Id=YOUR_USER;Password=YOUR_PASSWORD;"
}

## ▶️ Running the Project
1.	Open a terminal in the project root folder
2.	Start the API:
    dotnet run
4.	The API will run on:
http://localhost:5057
5.	Open the frontend manually:
html/index.html


