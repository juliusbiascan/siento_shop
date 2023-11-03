import 'package:siento_shop/pages/home/screens/filters_screen.dart';
import 'package:flutter/material.dart';

class FilterProvider with ChangeNotifier {
  int filterNumber = 0;

  int get getFilterNumber => filterNumber;

  void setFilterNumber(int filterNo) {
    filterNumber = filterNo;

    notifyListeners();
  }

  FilterType getFilterRadio(int filterNumber) {
    switch (filterNumber) {
      case 0:
        notifyListeners();
        return FilterType.atoZ;
      case 1:
        notifyListeners();
        return FilterType.priceLtoH;
      case 2:
        notifyListeners();
        return FilterType.priceHtoL;
      default:
        notifyListeners();
        return FilterType.atoZ;
    }
  }
}
