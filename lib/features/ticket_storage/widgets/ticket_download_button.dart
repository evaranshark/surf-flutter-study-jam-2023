import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/ticket_download_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/ticket_downloading_state.dart';

class TicketDownloadButton extends StatelessWidget {
  TicketDownloadButton({
    super.key,
    required this.startAction,
    required this.pauseAction,
  });
  final VoidCallback startAction, pauseAction;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketDownloadBloc, TicketDownloadState>(
        builder: (context, state) {
      IconData data;
      if (state is TicketWaitState) {
        data = Icons.cloud_download_outlined;
      } else if (state is TicketLoadingState) {
        data = Icons.pause_circle_outline_outlined;
      } else {
        data = Icons.cloud_download;
      }
      return IconButton(
        icon: Icon(
          data,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () => _onPressed(state),
      );
    });
  }

  void _onPressed(state) {
    if (state is TicketWaitState) {
      startAction.call();
    } else if (state is TicketLoadingState) {
      pauseAction.call();
    }
  }
}
