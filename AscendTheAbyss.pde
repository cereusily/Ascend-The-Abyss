

/* Asset Credits:
Original Art: Timothy Kung
Audio Retrieved from:

Pixabay: https://pixabay.com/sound-effects/search/8-bit/
  Doorbell by Surn Thing
  Game Over by Zombie Expert
  Hurt C 08 by Cabled Mess
  Pick-Up SFX by Jhyland
  Retro Game SFX Explosion by SunTemple
  Retro Game Dramatic Effect by Jofae
  Bitcrushed Ambient Background Loop by Everflux
  
Title Screen Audio retrieved from https://www.chosic.com/download-audio/45392/
  Demented Nightmare by Darren Curtis
*/


// Modes
final int INTRO = 1;
final int GAME = 2;
final int PAUSE = 3;
final int GAMEOVER = 4;
final int WIN = 5;
int gameMode;

// Item rarities
final int COMMON = 0;
final int UNCOMMON = 1;
final int RARE = 2;
final int LEGENDARY = 3;
final int KEY = 4;

// Audio
Minim minim;

// Managers & players
GameManager gm;
SceneManager sm;
Player player;

// Fonts
PFont font;

void setup() {
  // Sets up game
  size(1280, 720);
  background(255);

  // Framerate
  frameRate(60);

  // Init assets
  minim = new Minim(this);
  gm = new GameManager();
}

void draw() {
  // Game states
  switch (gameMode) {
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
  case WIN:
    gm.win();
    break;
  }
}

void keyPressed() {
  gm.checkKeyPressed();
}

void keyReleased() {
  gm.checkKeyReleased();
}
