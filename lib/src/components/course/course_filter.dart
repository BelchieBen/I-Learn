import 'package:booking_app/providers/search_term.dart';
import 'package:booking_app/providers/searching.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Custom type definitions
typedef StringCallback = void Function(
    String? val); // Calls setState on parent widget
typedef ClearFilter = void
    Function(); // Function to clear the filter on parent widget

// Reusable dropdown button to allow users to filter search results
// @param, filterItems, A List of items to include in the dropdown
// @param, hintText, The text to display when there is no item selected
// @param, setValue, the function to set parents state for the input value
// @param, clearFilterCallback, the function to remove the selected value on parent
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

      // Change the content of the button if there is a slected value
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
