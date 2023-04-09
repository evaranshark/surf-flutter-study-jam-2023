import 'package:flutter/material.dart';

import '../data/ticket_model.dart';

class TicketTypeIcon extends StatelessWidget {
  final TicketType type;
  const TicketTypeIcon({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (type) {
      case TicketType.plane:
        icon = Icons.airplane_ticket_outlined;
        break;
      case TicketType.train:
        icon = Icons.train_outlined;
        break;
      default:
        icon = Icons.article_outlined;
    }
    return Icon(icon);
  }
}
