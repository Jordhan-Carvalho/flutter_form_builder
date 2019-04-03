import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

class FormBuilderStepper extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final num initialValue;
  final bool readonly;
  final InputDecoration decoration;

  final num step;
  final num min;
  final num max;
  final num size;

  FormBuilderStepper({
    @required this.attribute,
    this.initialValue,
    this.validators = const [],
    this.readonly = false,
    this.decoration = const InputDecoration(),
    this.step,
    this.min,
    this.max,
    this.size = 24.0,
  });

  @override
  _FormBuilderStepperState createState() => _FormBuilderStepperState();
}

class _FormBuilderStepperState extends State<FormBuilderStepper> {
  @override
  Widget build(BuildContext context) {
    return FormField(
      enabled: !(widget.readonly || widget.readonly),
      // key: _fieldKey,
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
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !(widget.readonly || widget.readonly),
            errorText: field.errorText,
          ),
          child: SyStepper(
            value: field.value ?? 0,
            step: widget.step ?? 1,
            min: widget.min ?? 0,
            max: widget.max ?? 9999999,
            size: widget.size,
            onChange: (widget.readonly)
                ? null
                : (value) {
                    field.didChange(value);
                  },
          ),
        );
      },
    );
  }
}
