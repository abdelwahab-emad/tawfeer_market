import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:tawfeer_market/cubits/bottom_nav_cubit/bottom_nav_states.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavInitial());

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(BottomNavUpdated(index: index));
  }
}