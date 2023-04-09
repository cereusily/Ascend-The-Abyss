class SceneManager {
  // Class that manages cutscenes in the game
  Timer timer;
  boolean timerStarted;
  boolean introSceneOver = false;
  boolean bossSceneOver = false;
  boolean bossDeathSceneOver = false;
  
  boolean effectPlayed = false;

  String chapterOne = " = CHAPTER ONE: THE DEPTHS =";
  String chapterTwo = " = CHAPTER TWO: LIMBO =";
  String chapterThree = " = FINAL CHAPTER: ESCAPE =";

  int opacity;
  int fadeRate;

  SceneManager() {
    timer = new Timer();
    opacity = 255;
    fadeRate = 1;
  }

  void setText() {
    // Function that sest text
    font = createFont("fonts/alagard.ttf", 128);
    textSize(48);
    textAlign(CENTER);
  }

  String getChapter() {
    // Gets the chapter
    String chapter = "";

    switch (gm.currentLevel) {
    case 0:
      chapter = chapterOne;
      break;
    case 1:
      chapter = chapterTwo;
      break;
    case 2:
      chapter = chapterThree;
      break;
    }
    return chapter;
  }

  void playIntroScene() {
    // Plays intro
    push();
    
    // Plays initimidating effect :O
    if (!effectPlayed) {
      gm.playSound(gm.nextLevelEffect);
      effectPlayed = true;
    }
    
    // Text settings
    setText();

    // Sets timer
    if (!timerStarted) {
      timer.begin();
      timerStarted = true;
    }

    // Opacity
    fill(255, 255, 255, opacity);

    // Plays first line
    if (timer.getCurrentTime() < 4_000) {
      text(getChapter(), width/2, height/2 - 100);
    } else {
      introSceneOver = true;
      timerStarted = false;
      timer.reset();
      opacity = 255;
    }

    opacity -= fadeRate;

    pop();
  }
  
  void playEscapeScene() {
    // Plays scape scene'
    background(255, 255, 255);
    player.pos = new PVector(width/2, height/2 - 150);
    player.drawMe();
    setText();
    fill(0);
    text("= YOU'VE ESCAPED! =", width/2, height/2 - 50);
  }
}
