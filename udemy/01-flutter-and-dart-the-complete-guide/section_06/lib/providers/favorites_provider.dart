import 'package:flutter_riverpod/legacy.dart';

import 'package:section_06/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  // 즐겨찾기 토글 처리
  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      // 해당 아이템만 제거
      state = state.where((meal) => meal.id != meal.id).toList();

      return false;
    } else {
      // 해당 아이템 추가
      state = [...state, meal];

      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
      (ref) {
        return FavoriteMealsNotifier();
      },
    );
