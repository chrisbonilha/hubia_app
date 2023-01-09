import 'package:flutter/material.dart';

class HubiaDropdown extends StatefulWidget {
  final Function(String? newValue)? onChange;
  final List<String> options;
  final String? hint;
  final String? value;
  final String? initialValue;
  final String? label;
  final String? Function(String?)? validator;

  const HubiaDropdown({
    Key? key,
    this.onChange,
    required this.options,
    this.hint,
    this.value,
    this.initialValue,
    this.label,
    this.validator,
  }) : super(key: key);

  @override
  State<HubiaDropdown> createState() => _HubiaDropdownState();
}

class _HubiaDropdownState extends State<HubiaDropdown> {
  String? _dropdownValue;

  @override
  initState() {
    _dropdownValue = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField(
            isExpanded: true,
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              labelText: widget.label,
            ),
            value: _dropdownValue ?? widget.initialValue,
            hint: Text(widget.hint ?? ''),
            style: const TextStyle(color: Colors.black54),
            onChanged: (String? newValue) {
              setState(() {
                _dropdownValue = newValue!;
              });
              if (widget.onChange != null) widget.onChange!(newValue);
            },
            validator: widget.validator,
            items: widget.options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
