// Modes
final int INTRO = 1;
final int GAME = 2;
final int PAUSE = 3;
final int GAMEOVER = 4;
int mode;

// Items
final int MONEY = 0;
final int CONSUMABLE = 1;
final int RELIC = 2;
final int GUN = 3;
final int KEY = 4;

 
GameManager gm;
SceneManager sm;
Player player;

/* TODO LIST
 - Roommanager has check in drawall for enemies=> need to fix so enemies dont stack/overlaps
 - Fix rewards system thingie
 - Add inventory display
 - Add bosskey requirement for boss door
 
 Difference from Assignment 3
 - Added moveable/explorable areas
 - Added different types of enemies with a variety of behaviour
 - Added items
*/

void setup() {
  // Sets up game
  size(1200, 750);
  background(255);
  
  // Init assets
  gm = new GameManager();
}

void draw() {
  // Game states
  switch (mode) {
    case INTRO:
      gm.intro();
      break;
    case GAME:
      gm.runGame();
      break;
    case PAUSE:
      gm.pause();
      break;
    case GAMEOVER:
      gm.gameOver();
      break;
  }
}

void keyPressed() {
  gm.checkKeyPressed();
}

void keyReleased() {
  gm.checkKeyReleased();
}
