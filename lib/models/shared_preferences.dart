class Preferences {
  String playerAnimation =
      "https://media.tenor.com/SexsGMnqLn0AAAAi/pepe-pepe-song.gif";
  int notificationSeconds = 0;

  Preferences();

  String get getPlayerAnimation => this.playerAnimation;
  int get getNotificationSeconds => this.notificationSeconds;

  set setPlayerAnimation(String playerAnimation) =>
      this.playerAnimation = playerAnimation;
  set setNotificationSeconds(int notificationSeconds) => this.notificationSeconds = notificationSeconds;
}