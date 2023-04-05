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
final int LEVEL_KEY = 5;
 
GameManager gm;
SceneManager sm;
Player player;

/* TODO LIST
 - Roommanager has check in drawall for enemies=> need to fix so enemies dont stack/overlaps
 - Add inventory display
 - Add chest drops for room clear
 - Added additional items to augment player ability (ricochet gun, shotguns, speed boost etc)
 - Redo some sprites :(
 
 Updates from Milestone 1
 - Added additional items
 - Added bosskeys!
 - Added chest drops for keys
 - Animated profile
 - Very cool sprites that puts Picasso to shame
 - New maps!
*/

void setup() {
  // Sets up game
  size(1200, 750);
  background(255);
  
  // Framerate
  frameRate(60);
  
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
