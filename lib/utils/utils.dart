class Utils {
  static String addMin(String timePeriodString) {
    const int duration = 15;
    List result = timePeriodString.split(":");

    int hrs = int.parse(result[0]);
    int min = int.parse(result[1]);

    min += duration;

    if (min >= 60) {
      min = min - 60;
      hrs += 1;

      return "$hrs:${min.toString().padRight(2, "0")}";
    } else {
      return "$hrs:${min.toString().padRight(2, "0")}";
    }
  }
}
