import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/ticket_download_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/ticket_download_event.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/ticket_downloading_state.dart';
import 'ticket_download_button.dart';

import '../data/ticket_model.dart';
import 'ticket_type_icon.dart';

class TicketTile extends StatefulWidget {
  const TicketTile({super.key, required this.title, this.subtitle});

  final String title;
  final Widget? subtitle;

  @override
  State<TicketTile> createState() => _TicketTileState();
}

class _TicketTileState extends State<TicketTile> {
  double progressValue = 0;
  TicketLoadState loadState = TicketLoadState.notStarted;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TicketTypeIcon(),
      title: Text(
        widget.title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      subtitle: BlocBuilder<TicketDownloadBloc, TicketDownloadState>(
        builder: (context, state) {
          if (state is TicketWaitState) {
            return const Text('Ожидает начала загрузки');
          }
          if (state is TicketLoadingState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(
                  value: state.progress,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text("Загружается ${state.count} из ${state.total}"),
              ],
            );
          }
          return const Text('Файл загружен');
        },
      ),
      trailing: TicketDownloadButton(
        startAction: () {
          var bloc = context.read<TicketDownloadBloc>();
          bloc.add(DownloadTicket(widget.title));
        },
        pauseAction: () {
          context.read<TicketDownloadBloc>().add(PauseTicket());
        },
      ),
    );
  }
}

enum TicketLoadState { notStarted, inProgress, completed }
