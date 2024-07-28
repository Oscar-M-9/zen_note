import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_notes/app/presenter/providers/search_query_note_provider.dart';
import 'package:my_notes/generated/l10n.dart';

class SearchInput extends ConsumerStatefulWidget {
  const SearchInput({super.key});

  @override
  SearchInputState createState() => SearchInputState();
}

class SearchInputState extends ConsumerState<SearchInput> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(controllerSearchProvider);
    searchController.text = searchQuery;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 15),
      child: Semantics(
        child: TextFormField(
          controller: searchController,
          // initialValue: initialValue,
          keyboardType: TextInputType.text,
          autocorrect: false,

          onChanged: (query) {
            ref.read(controllerSearchProvider.notifier).state = query;
          },
          style: Theme.of(context).textTheme.titleMedium,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5),
            prefixIcon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: 25,
              child: SvgPicture.asset(
                "assets/svg/search.svg",
                // ignore: deprecated_member_use
                color: Theme.of(context).appBarTheme.iconTheme?.color,
              ),
            ),
            hintText: S.of(context).tSearchNote,
            suffixIcon: searchQuery.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      ref.read(controllerSearchProvider.notifier).state = "";
                      searchController.clear();
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: Theme.of(context).appBarTheme.iconTheme?.color,
                      size: 20,
                    ),
                  )
                : null,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
