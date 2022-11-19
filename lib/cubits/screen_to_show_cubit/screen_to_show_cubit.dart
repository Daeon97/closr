import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/models.dart' as models;
import '../../utils/utils.dart' as utils;

part 'screen_to_show_state.dart';

class ScreenToShowCubit extends HydratedCubit<ScreenToShowState> {
  ScreenToShowCubit()
      : super(
          const ScreenToShowState(
            utils.ScreenToShow.selectCategory,
          ),
        );

  void setScreenToShow(
    utils.ScreenToShow screenToShow,
  ) {
    emit(
      ScreenToShowState(
        screenToShow,
      ),
    );
  }

  @override
  ScreenToShowState? fromJson(Map<String, dynamic> json) {
    try {
      final screenToShow = models.ScreenToShow.fromJson(json);
      return ScreenToShowState(
        screenToShow.screenToShow,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ScreenToShowState state) =>
      models.ScreenToShow(state.screenToShow).toJson();
}
