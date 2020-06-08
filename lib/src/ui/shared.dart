class Shared {
  static String getDayFromDate(String sDate) {
    DateTime dateTime = DateTime.parse(sDate);
    return "${dateTime.year.toString()}-${dateTime.month.toString()}-${dateTime.day.toString()}";
  }

  static String getHourFromDate(String sDate) {
    DateTime dateTime = DateTime.parse(sDate);
    String firstPart = "";
    String secondPart = "";

    if (dateTime.hour.toString().length == 1) {
      firstPart = "0${dateTime.hour}";
    } else {
      firstPart = dateTime.hour.toString();
    }
    if (dateTime.minute.toString().length == 1) {
      secondPart = "0${dateTime.minute}";
    } else {
      secondPart = dateTime.minute.toString();
    }

    String thirdPart = "";
    if (dateTime.hour >= 12) {
      thirdPart = "PM";
    } else {
      thirdPart = "AM";
    }

    return "$firstPart:${secondPart} $thirdPart";
  }

  static String parseOrderStatus(String status) {
    if (status == "pending") {
      return "Pendiente";
    } else if (status == "in_progress") {
      return "En progreso";
    }

    return "";
  }
}
