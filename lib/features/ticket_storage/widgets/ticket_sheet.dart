import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/core/link_validator.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/ticket_storage_bloc.dart';

class TicketSheet extends StatefulWidget {
  TicketSheet({super.key, required this.onSubmit});
  final Function(String) onSubmit;

  @override
  State<TicketSheet> createState() => _TicketSheetState();
}

class _TicketSheetState extends State<TicketSheet> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _controller,
              validator: (value) {
                if (!LinkValidator.isPdfLink(value)) {
                  return ('Введите корректный url');
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: 'Введите url'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                  onPressed: () => onPressed(context),
                  child: const Text('Добавить')),
            )
          ],
        ),
      ),
    );
  }

  onPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      widget.onSubmit(_controller.text);
      Navigator.of(context).pop<String>(_controller.text);
    }
  }
}
