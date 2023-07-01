class EventManager {
  // private constructor so that no new instance can be created outside this class
  EventManager._internal();

// private field to save internet connectivity status.
  static bool _internetActive = false;

// public - static - functions to save & retrieve the internet status
  static bool isInternetActive() => _internetActive;
  static setInternetActive(bool value) => _internetActive = value;
}
