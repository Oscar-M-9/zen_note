import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_notes/generated/l10n.dart';

import 'package:my_notes/app/config/theme/colors_app.dart';
import 'package:my_notes/app/config/router/router_name.dart';
import 'package:my_notes/app/presenter/providers/note_state_provider.dart';
import 'package:my_notes/app/presenter/providers/search_query_note_provider.dart';
import 'package:my_notes/app/presenter/providers/selected_note_provider.dart';

import 'package:my_notes/app/ui/shared/search_input.dart';
import 'package:my_notes/app/ui/pages/home/body_home_view.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
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
    final textTheme = Theme.of(context).textTheme;
    final selectedNotes = ref.watch(selectedNotesProvider);

    final searchQuery = ref.watch(controllerSearchProvider);
    searchController.text = searchQuery;

    return KeyboardDismissOnTap(
      child: Scaffold(
        extendBody: true,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 140,
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  S.of(context).tMyNotes,
                  style: textTheme.headlineLarge,
                ),
                centerTitle: true,
              ),
              actions: [
                Semantics(
                  label: S.of(context).tSettingButton,
                  excludeSemantics: true,
                  focusable: true,
                  child: IconButton(
                    onPressed: () {
                      ref.read(selectedNotesProvider.notifier).clear();
                      context.router.pushNamed(RouteName.setting);
                    },
                    icon: SvgPicture.asset(
                      "assets/svg/settings.svg",
                      // ignore: deprecated_member_use
                      color: Theme.of(context).appBarTheme.iconTheme?.color,
                    ),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SearchInput(
                    hinText: S.of(context).tSearchNote,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).appBarTheme.iconTheme?.color,
                    ),
                    controller: searchController,
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              ref
                                  .read(controllerSearchProvider.notifier)
                                  .state = "";
                              searchController.clear();
                            },
                            icon: Icon(
                              Icons.close_rounded,
                              color: Theme.of(context)
                                  .appBarTheme
                                  .iconTheme
                                  ?.color,
                              size: 20,
                            ),
                          )
                        : null,
                    onChanged: (query) {
                      ref.read(controllerSearchProvider.notifier).state = query;
                    },
                  ),
                ],
              ),
            ),
            const BodyHomeView(),
          ],
        ),
        bottomNavigationBar: selectedNotes.isEmpty
            ? null
            : BottomAppBar(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Focus(
                        child: Semantics(
                          label: S.of(context).tCancelButton,
                          excludeSemantics: true,
                          focusable: true,
                          child: IconButton(
                            icon: SvgPicture.asset(
                              "assets/svg/cancel.svg",
                              width: 20,
                              // ignore: deprecated_member_use
                              color: Theme.of(context)
                                  .appBarTheme
                                  .iconTheme
                                  ?.color,
                            ),
                            onPressed: () {
                              ref.read(selectedNotesProvider.notifier).clear();
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: ColorsApp.primary,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: SvgPicture.asset(
                          "assets/svg/delete-note.svg",
                          // ignore: deprecated_member_use
                          color: Theme.of(context).appBarTheme.iconTheme?.color,
                        ),
                        label: Text(
                          '${S.of(context).tDeleteNotes} (${selectedNotes.length})',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        onPressed: () {
                          ref
                              .read(noteProvider.notifier)
                              .deleteNotes(selectedNotes);
                          ref.read(selectedNotesProvider.notifier).clear();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 252, 100, 100),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        floatingActionButton: Focus(
          child: Semantics(
            label: S.of(context).tAddNoteButton,
            excludeSemantics: true,
            focusable: true,
            button: true,
            expanded: false,
            child: FloatingActionButton(
              onPressed: () {
                ref.read(selectedNotesProvider.notifier).clear();
                context.router.pushNamed(RouteName.addNote);
              },
              elevation: 0,
              hoverElevation: 0,
              highlightElevation: 0,
              backgroundColor: ColorsApp.primary,
              child: Semantics(
                child: SvgPicture.asset(
                  "assets/svg/add-note.svg",
                  // ignore: deprecated_member_use
                  color: Theme.of(context).appBarTheme.iconTheme?.color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
