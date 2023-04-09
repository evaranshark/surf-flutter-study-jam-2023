import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/ticket_download_event.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/ticket_downloading_state.dart';
import 'package:path_provider/path_provider.dart';

class TicketDownloadBloc
    extends Bloc<TicketDownloadEvent, TicketDownloadState> {
  final String url;
  CancelToken cancelToken = CancelToken();
  TicketDownloadBloc(this.url) : super(TicketWaitState()) {
    on<DownloadTicket>(
      (event, emit) => onDownloadTicket(event, emit),
    );
    on<PauseTicket>(
      (event, emit) => onPause(event, emit),
    );
    on<CompleteTicket>(
      (event, emit) => emit(TicketCompleteState()),
    );
  }

  onDownloadTicket(event, emit) async {
    emit(TicketLoadingState(0, '0', '0'));
    var path = await getFilePath(event.name);
    try {
      await Dio().download(
        url,
        path,
        cancelToken: cancelToken,
        deleteOnError: true,
        onReceiveProgress: (count, total) {
          var percentage = (count / total);
          emit(
            TicketLoadingState(
                percentage,
                (count / 1000000).toStringAsPrecision(2),
                (total / 1000000).toStringAsPrecision(2)),
          );
          if (count == total) {
            emit(TicketCompleteState());
          }
        },
      );
    } catch (e) {
      emit(TicketWaitState());
    }
  }

  onPause(event, emit) async {
    cancelToken.cancel();
    cancelToken = CancelToken();
    emit(TicketWaitState());
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName.pdf';

    return path;
  }
}
