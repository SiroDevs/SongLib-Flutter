part of '../main_screen.dart';

class SearchWidget extends StatelessWidget {
  final Function(String) onSearch;
  final FocusNode? searchFocus;
  final TextEditingController? searchController;
  const SearchWidget({
    super.key,
    required this.onSearch,
    required this.searchFocus,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: searchFocus,
      controller: searchController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: ThemeColors.primaryDark),
        suffixIcon: InkWell(
          onTap: () {
            searchController!.clear();
            onSearch('');
          },
          child: const Icon(Icons.clear, color: ThemeColors.primaryDark),
        ),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
      style: const TextStyle(fontSize: 18, color: ThemeColors.primaryDark),
      textInputAction: TextInputAction.done,
      onChanged: (String query) => onSearch(query),
    ).decorated(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    );
  }
}
