class Shooter extends Enemy {
  // Fields
  
  Gun gun;
  ArrayList<Bullet> arr;
  
  Shooter(PVector pos, PVector vel, PVector size, int roomX, int roomY) {
    super(pos, vel, size, roomX, roomY);
    
    arr = new ArrayList<Bullet>();
    
    gun = new Pistol(pos, new PVector(), arr);
    gun.isFriendly = false;
  }
  
  void update() {
    //
  }
  
 
}
