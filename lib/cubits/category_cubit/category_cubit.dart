import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/models.dart' as models;
import '../../utils/utils.dart' as utils;

part 'category_state.dart';

class CategoryCubit extends HydratedCubit<CategoryState> {
  CategoryCubit()
      : super(
          const CategoryState(
            utils.Category.child,
          ),
        );

  void setCategory(
    utils.Category category,
  ) {
    emit(
      CategoryState(
        category,
      ),
    );
  }

  @override
  CategoryState? fromJson(Map<String, dynamic> json) {
    try {
      final category = models.Category.fromJson(json);
      return CategoryState(category.category);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(CategoryState state) =>
      models.Category(state.category).toJson();
}
