enum WinType { topLine, middleLine, bottomLine, earlyFive, fullHouse }

extension WinTypeLabel on WinType {
  String get label {
    switch (this) {
      case WinType.topLine:
        return '🏆 Top Line!';
      case WinType.middleLine:
        return '🏆 Middle Line!';
      case WinType.bottomLine:
        return '🏆 Bottom Line!';
      case WinType.earlyFive:
        return '⭐ Early Five!';
      case WinType.fullHouse:
        return '🎉 Full House!';
    }
  }

  String get description {
    switch (this) {
      case WinType.topLine:
        return 'All numbers in the top row marked!';
      case WinType.middleLine:
        return 'All numbers in the middle row marked!';
      case WinType.bottomLine:
        return 'All numbers in the bottom row marked!';
      case WinType.earlyFive:
        return 'First 5 numbers on your ticket marked!';
      case WinType.fullHouse:
        return 'All 15 numbers on your ticket marked!';
    }
  }
}
