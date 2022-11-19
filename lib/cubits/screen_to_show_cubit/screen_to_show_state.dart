part of 'screen_to_show_cubit.dart';

class ScreenToShowState extends Equatable {
  final utils.ScreenToShow screenToShow;

  const ScreenToShowState(
    this.screenToShow,
  );

  @override
  List<Object?> get props => [
        screenToShow,
      ];
}
