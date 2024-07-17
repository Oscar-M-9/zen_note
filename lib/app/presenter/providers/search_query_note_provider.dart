import 'package:flutter_riverpod/flutter_riverpod.dart';

// class SearchQueryNotifier extends StateNotifier<String> {
//   SearchQueryNotifier() : super('');

//   void setQuery(String query) {
//     state = query;
//   }

//   void clear() {
//     state = '';
//   }
// }

// final searchQueryProvider = StateNotifierProvider<SearchQueryNotifier, String>(
//   (ref) => SearchQueryNotifier(),
// );

final controllerSearchProvider = StateProvider<String>((ref) {
  return "";
});
