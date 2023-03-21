// Modes
final int INTRO = 1;
final int GAME = 2;
final int PAUSE = 3;
final int GAMEOVER = 4;
int mode;
  
GameManager gm;
SceneManager sm;
Player player;

// TODO LIST
// Roommanager has check in drawall for enemies=> need to fix so enemies dont stack/iverlaps

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
