part of 'category_cubit.dart';

class CategoryState extends Equatable {
  final utils.Category category;

  const CategoryState(
    this.category,
  );

  @override
  List<Object?> get props => [
        category,
      ];
}
