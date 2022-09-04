import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    this.showSearch = true,
    this.toolbarHeight,
    this.expandedHeight,
    this.collapseHeight,
    this.cleanSearch,
    this.controller,
  }) : super(key: key);

  final double? expandedHeight;
  final double? toolbarHeight;
  final double? collapseHeight;
  final VoidCallback? cleanSearch;
  final TextEditingController? controller;
  final bool showSearch;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: toolbarHeight ?? kToolbarHeight,
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: expandedHeight ?? kToolbarHeight,
      collapsedHeight: collapseHeight ?? 0.0,
      backgroundColor: Colors.white.withOpacity(0.2),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 0,
        ),
        title: AnimatedOpacity(
            opacity: showSearch ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 400),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: SearchField(
                cleanSearch: cleanSearch,
                controller: controller,
              ),
            )),
        expandedTitleScale: 1.0,
        stretchModes: const [StretchMode.fadeTitle],
      ),
    );
  }
}

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
    this.cleanSearch,
    this.controller,
  }) : super(key: key);

  final VoidCallback? cleanSearch;
  final TextEditingController? controller;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late FocusNode focusNode;
  Color focusColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode()..addListener(focus);
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void focus() {
    setState(() {
      focusColor = focusNode.hasFocus ? Colors.orange : Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextFormField(
      focusNode: focusNode,
      controller: widget.controller,
      textAlignVertical: TextAlignVertical.bottom,
      style: TextStyle(color: focusColor),
      toolbarOptions: const ToolbarOptions(
          copy: true, paste: true, cut: true, selectAll: true),
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Container(
          margin: const EdgeInsets.only(right: 10, top: 10),
          child: Icon(
            Icons.search_outlined,
            size: screenWidth * 0.0625,
            color: focusColor,
          ),
        ),
        border: const UnderlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: Colors.grey)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: Colors.orange)),
        hintText: 'Search',
        hintStyle: TextStyle(color: focusColor),
        suffixIcon: GestureDetector(
          onTap: () {
            focusNode.unfocus();
            widget.cleanSearch?.call();
          },
          child: Container(
            margin: const EdgeInsets.only(right: 10, top: 10),
            child: Icon(
              Icons.close,
              size: screenWidth * 0.0625,
              color: focusColor,
            ),
          ),
        ),
      ),
    );
  }
}
