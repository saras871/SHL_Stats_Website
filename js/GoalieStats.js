
let exploreData = [];
let currentSort = {
    // Default sorting 
    field: "rankScore",
    direction: "asc"
};

document.addEventListener("DOMContentLoaded", () => {
    setupSorting();
    loadData();
    loadClutch();
    loadTeamRegular();
    loadTeamOverall();
});

function sortExplore() {
    // Sort data based on selected field and direction
    exploreData.sort((a, b) => {
        const field = currentSort.field;
        // Handle string sorting with localeCompare
        if (typeof a[field] === "string") {
            return currentSort.direction === "asc"
                ? a[field].localeCompare(b[field])
                : b[field].localeCompare(a[field]);
        }
        // Handle numeric sorting through subtraction
        return currentSort.direction === "asc"
            ? a[field] - b[field]
            : b[field] - a[field];
    });

    updateHeaderArrows();
    renderExplore(exploreData);
}

function updateHeaderArrows() {
    document.querySelectorAll("#exploreHeader div").forEach(h => {
        const field = h.dataset.field;
        // Remove old arrow
        h.innerText = h.innerText.replace(" ▲", "").replace(" ▼", "");
        // Add new arrow on current sort field
        if (field === currentSort.field) {
            h.innerText += currentSort.direction === "asc" ? " ▲" : " ▼";
        }
    });
}

function renderExplore(data) {
    const table = document.getElementById("exploreTable");
    // Clear old data rows
    table.querySelectorAll(".data-row").forEach(r => r.remove());
    // Loop through goalies and create new rows
    data.forEach((g, index) => {
        const row = document.createElement("div");
        row.className = "row data-row";

        if (index < 5) row.classList.add("top");
        // Color coding for stats
        const saveClass = g.savePercentage > 90 ? "good" : "bad";
        const gaaClass = g.goalsAgainstAverage <= 2.5 ? "good" : "bad";
        // Medal emojis for top 3 ranking goalies
        let medal = "";
        if (g.position === 1) medal = "🥇";
        else if (g.position === 2) medal = "🥈";
        else if (g.position === 3) medal = "🥉";

        row.innerHTML = `
            <div>${medal} ${g.name} </div>
            <div>${g.team}</div>
            <div class="stat"> ${g.gamesPlayed}</div>
            <div class="stat"> ${g.saves}</div>
            <div class="stat ${saveClass}">${g.savePercentage.toFixed(2)}</div>
            <div class="stat">${g.goalsAgainst}</div>
            <div class="stat ${gaaClass}">${g.goalsAgainstAverage.toFixed(2)}</div>
            <div class="stat">${g.shutouts}</div>
        `;

        table.appendChild(row);
    });
}

function renderClutch(data) {
    const table = document.getElementById("clutchTable");
    table.querySelectorAll(".data-row").forEach(r => r.remove());


    data.forEach((g, index) => {
        const row = document.createElement("div");
        row.className = "row data-row";

        const clutchScoreClass = g.clutchScore > 0 ? "good" : "bad";

        row.innerHTML = `
            <div>${g.name}</div>
            <div>${g.team}</div>
            <div class="stat">${g.saveDiff.toFixed(3)}</div>
            <div class="stat">${g.gaaDiff.toFixed(2)}</div>
            <div class="stat ${clutchScoreClass}">${g.clutchScore.toFixed(3)}</div>
        `;

        table.appendChild(row);
    });
}
function renderTeamRegular(data) {
    const table = document.getElementById("regularTeamRank");
    table.querySelectorAll(".data-row").forEach(r => r.remove());


    data.forEach((g, index) => {
        const row = document.createElement("div");
        row.className = "row data-row";

        row.innerHTML = `
            <div>${g.team}</div>
            <div class="stat">${g.savePercentage.toFixed(2)}</div>
            <div class="stat">${g.goalsAgainstAverage.toFixed(2)}</div>
        `;

        table.appendChild(row);
    });
}
function renderTeamOverall(data) {
    const table = document.getElementById("overallTeamRank");
    table.querySelectorAll(".data-row").forEach(r => r.remove());
    // Color coding for teams who played relegation and playoff 
    data.forEach((g, index) => {
        let teamClass = "";
        if (g.relegationGames > 0) {
            teamClass = "relegation";
        }
        else if (g.playoffGames > 0) {
            teamClass = "playoff";
        }
        const row = document.createElement("div");
        row.className = `row data-row ${teamClass}`;

        row.innerHTML = `
            <div>${g.team}</div>
            <div class="stat">${g.savePercentage.toFixed(2)}</div>
            <div class="stat">${g.goalsAgainstAverage.toFixed(2)}</div>
        `;

        table.appendChild(row);
    });
}

function setupSorting() {
    // Add click listeners to headers for sorting
    document.querySelectorAll("#exploreHeader div").forEach(header => {
        header.addEventListener("click", () => {
            const field = header.dataset.field;
            // If column is already sorted toggle direction.
            // Else sort new column descending by default.
            if (currentSort.field === field) {
                currentSort.direction = currentSort.direction === "asc" ? "desc" : "asc";
            }
            else {
                currentSort.field = field;
                currentSort.direction = "desc";
            }

            sortExplore();
        });
    });
}

async function loadData() {
    // Fetch goalie ranking data from API
    const res = await fetch("http://localhost:5057/api/goalies/ranking");
    // Convert response to array of goalie objects
    const data = await res.json();
    // Store data in global variable for sorting and rendering
    exploreData = [...data];

    sortExplore();
}

async function loadClutch() {
    const res = await fetch("http://localhost:5057/api/goalies/clutch");
    const data = await res.json();

    renderClutch(data);
}
async function loadTeamRegular() {
    const res = await fetch("http://localhost:5057/api/goalies/teamRegular");
    const data = await res.json();

    renderTeamRegular(data);
}
async function loadTeamOverall() {
    const res = await fetch("http://localhost:5057/api/goalies/teamOverall");
    const data = await res.json();
    console.log(data);
    renderTeamOverall(data);
}