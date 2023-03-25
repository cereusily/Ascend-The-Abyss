class RoomManager {
  // Fields
 
  ArrayList<GameObject> group;
  ArrayList<Item> rewards;

  RoomManager() {
    // Gameobjects in room
    group = new ArrayList<GameObject>();
    rewards = new ArrayList<Item>();
  }

  void addToRoom(GameObject obj) {
    group.add(obj);
  }

  void clearAll() {
    group.clear();
  }
  
  void addReward(Item item) {
    rewards.add(item);
  }

  boolean isClear() {
    // If no enemies left in room
    return getAliveEnemiesCount() == 0;
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
  
  // Do some sort of flocking mechanic idk
  void drawObjects() {
    // Draws and updates all game objects
    for (int i = 0; i < group.size(); i++) {
      GameObject obj = group.get(i);
      // Only updates and draws if same room as player
      if (obj.roomX == player.roomX && obj.roomY == player.roomY) {  // Only runs for loop for enemies
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
