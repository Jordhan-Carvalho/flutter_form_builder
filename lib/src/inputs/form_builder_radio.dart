import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderRadio extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readonly;
  final InputDecoration decoration;

  final List<FormBuilderInputOption> options;

  FormBuilderRadio({
    @required this.attribute,
    @required this.options,
    this.initialValue,
    this.validators = const [],
    this.readonly = false,
    this.decoration = const InputDecoration(),
  });

  @override
  _FormBuilderRadioState createState() => _FormBuilderRadioState();
}

class _FormBuilderRadioState extends State<FormBuilderRadio> {
  @override
  Widget build(BuildContext context) {
    return FormField(
      // key: _fieldKey,
      enabled: !widget.readonly && !widget.readonly,
      initialValue: widget.initialValue,
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
        List<Widget> radioList = [];
        for (int i = 0; i < widget.options.length; i++) {
          radioList.addAll([
            ListTile(
              dense: true,
              isThreeLine: false,
              contentPadding: EdgeInsets.all(0.0),
              leading: null,
              title: Text(
                  "${widget.options[i].label ?? widget.options[i].value}"),
              trailing: Radio<dynamic>(
                value: widget.options[i].value,
                groupValue: field.value,
                onChanged: (widget.readonly || widget.readonly)
                    ? null
                    : (dynamic value) {
                  field.didChange(value);
                },
              ),
              onTap: (widget.readonly || widget.readonly)
                  ? null
                  : () {
                field.didChange(widget.options[i].value);
              },
            ),
            Divider(
              height: 0.0,
            ),
          ]);
        }
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !(widget.readonly || widget.readonly),
            errorText: field.errorText,
            contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
            border: InputBorder.none,
          ),
          child: Column(
            children: radioList,
          ),
        );
      },
    );
  }
}
