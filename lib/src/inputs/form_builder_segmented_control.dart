import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderSegmentedControl extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readonly;
  final InputDecoration decoration;

  final List<FormBuilderInputOption> options;

  FormBuilderSegmentedControl({
    @required this.attribute,
    @required this.options,
    this.initialValue,
    this.validators = const [],
    this.readonly = false,
    this.decoration = const InputDecoration(),
  });

  @override
  _FormBuilderSegmentedControlState createState() => _FormBuilderSegmentedControlState();
}

class _FormBuilderSegmentedControlState extends State<FormBuilderSegmentedControl> {
  @override
  Widget build(BuildContext context) {
    return FormField(
      // key: _fieldKey,
      initialValue: widget.initialValue,
      enabled: !(widget.readonly || widget.readonly),
      validator: (val) {
        for (int i = 0; i < widget.validators.length; i++) {
          if (widget.validators[i](val) != null)
            return widget.validators[i](val);
        }
      },
      onSaved: (val) {
        FormBuilder.of(context)?.setValue(widget.attribute, val);
      },
      builder: (FormFieldState<dynamic> field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !(widget.readonly),
            errorText: field.errorText,
            contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            border: InputBorder.none,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: CupertinoSegmentedControl(
              borderColor: (widget.readonly)
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).primaryColor,
              selectedColor: (widget.readonly)
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).primaryColor,
              pressedColor: (widget.readonly)
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).primaryColor,
              groupValue: field.value,
              children: Map.fromIterable(
                widget.options,
                key: (v) => v.value,
                value: (v) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text("${v.label ?? v.value}"),
                    ),
              ),
              onValueChanged: (dynamic value) {
                if (widget.readonly) {
                  field.reset();
                } else
                  field.didChange(value);
              },
            ),
          ),
        );
      },
    );
  }
}
