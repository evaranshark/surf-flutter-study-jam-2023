import 'package:flutter/material.dart';

import '../data/ticket_model.dart';

class TicketTypeIcon extends StatelessWidget {
  const TicketTypeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    icon = Icons.airplane_ticket_outlined;
    return Icon(icon);
  }
}
