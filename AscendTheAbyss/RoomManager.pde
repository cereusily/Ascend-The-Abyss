class RoomManager {
  // Fields  
  ArrayList<GameObject> group;
  
  RoomManager() {   
    // Gameobjects in room
    group = new ArrayList<GameObject>();
  }
  
  void addToRoom(GameObject obj) {
    group.add(obj);
  }
  
  void clearAll() {
    group.clear();
  }
  
  int getAliveEnemiesCount() {
    // Returns number of enemies alive in room
    int count = 0;
    
    for (int i = 0; i < group.size(); i++) {
      GameObject obj = group.get(i);
      if (obj instanceof Enemy) {
        count++;
      }
    }  
    return count;
  }

  void drawObjects() {
    // Draws and updates all game objects
    for (int i = 0; i < group.size(); i++) {
      GameObject obj = group.get(i);
      
      // Only updates and draws if same room as player
      if (obj.roomX == player.roomX && obj.roomY == player.roomY) {
        obj.update();
        obj.drawMe();
      }
      else {
        if (obj instanceof Bullet) {  // Removes lingering bullets in rooms
          group.remove(i);
        }
      }
    }
  }
}
