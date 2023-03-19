// Modes
final int INTRO = 1;
final int GAME = 2;
final int PAUSE = 3;
final int GAMEOVER = 4;
int mode;
  
GameManager gm;
Player player;


void setup() {
  // Sets up game
  size(1200, 750);
  background(255);
  
  // Init assets
  gm = new GameManager();
  
  // Gameobjects
  player = new Player(new PVector(width/2, height/2), new PVector(), new PVector(70, 70));
  gm.objectGroup.add(player);
  
  // Test enemies
  gm.spawnEnemy(new PVector(width/2, height/2), new PVector(), 2, 1);
  gm.spawnEnemy(new PVector(width/2, height/2), new PVector(), 2, 2);
  gm.spawnEnemy(new PVector(width/2, height/2), new PVector(), 3, 1);
  gm.spawnEnemy(new PVector(width/2, height/2), new PVector(), 3, 2);
  
}

void draw() {
  // Clear
  background(255);

  // Game manager
  gm.drawRoom();
  
  gm.drawHUD();
  
  gm.checkEvents();
  
  gm.drawObjects(); 
  
}

void keyPressed() {
  gm.checkKeyPressed();
}

void keyReleased() {
  gm.checkKeyReleased();
}
