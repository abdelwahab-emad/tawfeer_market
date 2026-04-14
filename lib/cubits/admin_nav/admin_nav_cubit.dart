import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'admin_nav_state.dart';


class AdminNavCubit extends Cubit<AdminNavState> {
  AdminNavCubit() : super(AdminNavInitial());

  int currentIndex = 0;
  bool isCollapsed = true; 

  void changePage(int index) {
    currentIndex = index;
    emit(AdminNavUpdated(index: index));
  }

  void toggleMenu() {
    isCollapsed = !isCollapsed;
    emit(AdminNavUpdated(index: currentIndex));
  }
}