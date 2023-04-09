import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'ticket_model.g.dart';

@HiveType(typeId: 0)
class TicketModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String url;
  @HiveField(2)
  final String? localRef;

  TicketModel({required this.name, required this.url, this.localRef});
}
