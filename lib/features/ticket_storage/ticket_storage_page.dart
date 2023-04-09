import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/ticket_download_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/ticket_storage_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/ticket_storage_state.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/config.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/ticket_model.dart';

import 'widgets/ticket_sheet.dart';
import 'widgets/ticket_tile.dart';

/// Экран “Хранения билетов”.
class TicketStoragePage extends StatelessWidget {
  const TicketStoragePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TicketStorageCubit>(
      create: (context) => TicketStorageConfig.storageCubit,
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Хранение билетов'),
          ),
          body: TicketStorageBody(),
          floatingActionButton: MyFab(
            onPress: (String string) =>
                context.read<TicketStorageCubit>().addTicket(string),
          ),
        );
      }),
    );
  }
}

class MyFab extends StatelessWidget {
  const MyFab({super.key, required this.onPress});
  final Function(String) onPress;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _onFab(context),
      label: const Text('Добавить'),
    );
  }

  _onFab(context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TicketSheet(onSubmit: onPress),
        );
      },
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      elevation: 32,
      isScrollControlled: true,
      isDismissible: true,
      //useSafeArea: true,
    );
  }
}

class TicketStorageBody extends StatelessWidget {
  const TicketStorageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketStorageCubit, TicketStorageState>(
        builder: (context, state) {
      if (state.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Center(
        child: (state.tickets != null && state.tickets!.isNotEmpty)
            ? ListView.builder(
                itemCount: state.tickets!.length,
                itemBuilder: (context, index) {
                  var ticketData = state.tickets![index];
                  return BlocProvider(
                    create: (context) => TicketDownloadBloc(ticketData.url),
                    child: TicketTile(
                      title: ticketData.name,
                    ),
                  );
                },
              )
            : const Text('Здесь пока ничего нет'),
      );
    });
  }
}
