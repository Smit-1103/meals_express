import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_express/provider/favorites_provider.dart';
import '../models/meal.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded ? 'Meal Added!' : 'Meal Removed!'),
                ),
              );
            },
            icon: Icon(isFavorite ? Icons.star : Icons.star_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Image with rounded corners
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  meal.imageUrl,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),

              // Ingredient section
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        Text(
                          "Ingredients:",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    ...meal.ingredients
                        .map((ingredient) => TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0), // Indent for bullets
                                  child: Text(
                                    "• $ingredient",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                  ),
                                ),
                              ],
                            ))
                        .toList(),
                  ],
                ),
              ),

              // Steps section
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        Text(
                          "Steps:",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    ...meal.steps
                        .map((step) => TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0), // Indent for numbers
                                  child: Text(
                                    "${meal.steps.indexOf(step) + 1}. $step",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                  ),
                                ),
                              ],
                            ))
                        .toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



 // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Image.asset(
      //         meal.imageUrl,
      //         width: double.infinity,
      //         height: 300,
      //         fit: BoxFit.cover,
      //       ),
      //       const SizedBox(height: 14),
      //       Text(
      //         'Ingredients',
      //         style: Theme.of(context).textTheme.titleLarge!.copyWith(
      //             color: Theme.of(context).colorScheme.primary,
      //             fontWeight: FontWeight.bold),
      //       ),
      //       const SizedBox(
      //         height: 14,
      //       ),
      //       for (final ingredient in meal.ingredients)
      //         Text(
      //           ingredient,
      //           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      //               color: Theme.of(context).colorScheme.onBackground),
      //         ),
      //       const SizedBox(
      //         height: 24,
      //       ),
      //       Text(
      //         'Steps',
      //         style: Theme.of(context).textTheme.titleLarge!.copyWith(
      //             color: Theme.of(context).colorScheme.primary,
      //             fontWeight: FontWeight.bold),
      //       ),
      //       const SizedBox(
      //         height: 14,
      //       ),
      //       for (final step in meal.steps)
      //         Padding(
      //           padding:
      //               const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      //           child: Text(
      //             step,
      //             textAlign: TextAlign.center,
      //             style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      //                 color: Theme.of(context).colorScheme.onBackground),
      //           ),
      //         ),
      //     ],
      //   ),
      // ),