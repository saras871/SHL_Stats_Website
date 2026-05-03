# 🏒 SHL Analytics Website

A full-stack hockey analytics project that evaluates SHL players and teams by transforming performance data into ranked insights using SQL-based models

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


