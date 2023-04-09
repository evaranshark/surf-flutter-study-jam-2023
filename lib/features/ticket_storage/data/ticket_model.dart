import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class TicketModel extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String url;
  @HiveField(2)
  final TicketType? type;
  @HiveField(3)
  final String? localRef;

  const TicketModel(
      {required this.name, required this.url, this.type, this.localRef});

  @override
  List<Object?> get props => [name, url, type, localRef];

  Map<String, dynamic> toHive() {
    return {'name': name, 'url': url, 'ref': localRef ?? ''};
  }

  static TicketModel fromHive(Map<String, dynamic> source) {
    return TicketModel(name: source['name'], url: source['url']);
  }
}

enum TicketType { train, plane, bus, ship }
