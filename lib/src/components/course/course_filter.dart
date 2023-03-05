import 'package:booking_app/providers/search_term.dart';
import 'package:booking_app/providers/searching.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef StringCallback = void Function(String? val);
typedef ClearFilter = void Function();

class CourseFilter extends StatefulWidget {
  final List<String> filterItems;
  final String hintText;
  final StringCallback setValue;
  final ClearFilter clearFilterCallback;
  const CourseFilter({
    super.key,
    required this.filterItems,
    required this.hintText,
    required this.setValue,
    required this.clearFilterCallback,
  });

  @override
  State<CourseFilter> createState() => _CourseFilterState();
}

class _CourseFilterState extends State<CourseFilter> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color.fromRGBO(110, 120, 129, 1)),
      ),
      child: selectedValue != null
          ? Row(
              children: [
                Text(selectedValue!),
                IconButton(
                    onPressed: () {
                      widget.clearFilterCallback();
                      setState(() => selectedValue = null);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 16,
                    ))
              ],
            )
          : DropdownButtonHideUnderline(
              child: DropdownButton2(
                hint: Text(
                  widget.hintText,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: context.watch<Searching>().isSearching &&
                            context.watch<SearchTerm>().searchTerm != "" ||
                        !context.watch<Searching>().isSearching
                    ? widget.filterItems
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList()
                    : null,
                value: selectedValue,
                onChanged: (value) {
                  if (value != null) {
                    widget.setValue(value!.toLowerCase().replaceAll(" ", "_"));
                  }

                  setState(() {
                    selectedValue = value as String;
                  });
                },
                buttonHeight: 40,
                buttonWidth: 135,
                itemHeight: 40,
              ),
            ),
    );
  }
}
