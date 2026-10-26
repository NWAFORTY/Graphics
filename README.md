# Graphics

**Zombie Survival** is a 2D Processing platformer: jump a sprite-sheet zombie between platforms, dodge falling balls, collect stars for score, and grab health packs to stay alive.

Earlier Graphics module work (2D sprites and simple physics). For 3D dynamics see [Marble Race](https://github.com/NWAFORTY/Graphics-for-Games-and-Dynamics-Modelling). The sketch, zip, and How To Play guide are in this repo.

## Run the sketch

1. Install [Processing](https://processing.org/).
2. File → Open → `Graphics/main/main.pde`.
3. Click Run. The window is 600×600 at 60 FPS.

Keep `main.pde` in the same folder as the other `.pde` tabs and PNG images (`zombie.png`, `platform.png`, `star.png`, `healthpack.png`, `shield.png`).

## How to play

Aim: survive falling balls and collect stars to raise your score.

| Control | Action |
| --- | --- |
| **Enter** | Start from the main menu |
| **A** | Move left |
| **D** | Move right |
| **W** | Jump |
| **R** | Restart after Game Over |

- **Stars** spawn on random platforms. Touch one to score, then it moves to another platform.
- **Health packs** restore 20 HP (max 100) and respawn about 10 seconds after you collect them.
- **Falling balls** spawn from the top every second. A hit costs 20 HP.
- The **health bar** sits above the zombie (green / yellow / red). Health 0 or falling off the screen ends the game.
- Nine platforms are laid out as a climbable grid.

Full notes are in `Graphics/How To Play.docx`.

## Project files

All game tabs live in `Graphics/main/`. Processing treats them as one sketch.

| File | Role |
| --- | --- |
| `main.pde` | Game loop, menu, score, collisions, ball spawning |
| `zombie.pde` | Player: WASD movement, jump/gravity, sprite-sheet animation, health |
| `platform.pde` | Platform sprites the zombie can stand on |
| `Ball.pde` | Falling red balls that damage the zombie |
| `Star.pde` | Collectible stars that add to the score |
| `Health.pde` | Health bar drawn above the player |
| `HealthPowerUp.pde` | Health pack pickup and respawn timer |
| `main.zip` | Archive of the same sketch |
| `How To Play.docx` | Player instructions |

## Course

**Graphics** — 2D sprites, animation, collision, simple physics (gravity and jumps), and a score/health game loop in Processing.
