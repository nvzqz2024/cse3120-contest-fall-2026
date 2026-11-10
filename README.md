# cse3120-contest-fall-2026
### Instructions:
Open the Visual Studio Developer command prompt
Navigate to the downloaded directory
run the compilation script `compile.bat`
If successful, run `terminaltomb.exe`

-----
# Terminal Tomb
-----
**Elevator Pitch:** "Terminal Tomb" is top-down, grid-based dungeon-crawling microgame that runs and displays entirely within your terminal. You are a hero trapped inside a tomb with zombies, traps, and gold distributed throughout. Your goal is to reach the exit space without dying, collecting gold along the way for extra score.\
**Minimal Viable Product:** Upon running the program, a square grid is displayed in your terminal, rendered with standard ASCII characters. Your health and gold value is displayed underneath the grid. Your goal is to move player 'P' to exit 'E' without running out of health by touching too many zombies 'Z' or traps 'T'. You can move in any of the four cardinal directions, unless a wall '#' is blocking your way. Movement is taken one action at a time, simple implementation can use text input directions such as 'up' or 'right.'\
**Implementation Details:** Written in MASM

### Stretch Goals
**(Highest Priority):** Randomize the grid on every run
**(Mid Priority):** Food that restores health... Zombies chase after you... Player can attack adjacent cells... A key is needed to open exit...\
**(Low Priority):** Ability to store food for later... Save high score between runs... Zombies have chance of dropping health...\
Selectable player characters could have different strengths/weaknesses. Example: Half health but able to jump over a tile... More complex grid (larger dimensions. Hallways)...



**(Scope Creep Central):** The grid handles all game logic. The player is now specified as facing N/S/E/W. The game is now rendered as first person perspective ASCII art.
```
#####..........______.........#####
#####.........|......|........#####
#####.........|.0..0.|-(Grr!).#####
#####..........VVVVVV.........#####
#####..........__||__.........#####
#####........./|....|\........#####
#####......../.|____|.\.......#####
#####..........L....L.........#####
#####.........................#####
```
