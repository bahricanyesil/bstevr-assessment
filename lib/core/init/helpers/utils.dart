/// Util functions that can be used in any screen/widget.
mixin Utils {
  static String dateDiffHelper(DateTime date, [DateTime? now]) {
    var diff = (now ?? DateTime.now()).difference(date);
    var text = '';
    if (diff.inDays > 0) {
      text += '${diff.inDays}d';
    }
    if ((diff.inHours % 24) > 0) {
      text += '${diff.inHours % 24}h';
    }
    if ((diff.inMinutes % 60) > 0) {
      var inMinutes = diff.inMinutes;
      text += '${inMinutes % 60}m';
    }
    if ((diff.inSeconds % 60) > 0) {
      text += '${diff.inSeconds % 60}s';
    }
    if (text == '') text = '${diff.inSeconds}s';
    return '$text ago';
  }
}
