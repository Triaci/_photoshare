class Preferences {

  int notificationSeconds = 5;

  Preferences();

 
  int get getNotificationSeconds => this.notificationSeconds;

  set setNotificationSeconds(int notificationSeconds) =>
      this.notificationSeconds = notificationSeconds;
}
