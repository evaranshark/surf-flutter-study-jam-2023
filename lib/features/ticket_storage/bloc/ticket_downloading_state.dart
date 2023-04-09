abstract class TicketDownloadState {}

class TicketWaitState extends TicketDownloadState {}

class TicketLoadingState extends TicketDownloadState {
  final double progress;
  final String count;
  final String total;

  TicketLoadingState(this.progress, this.count, this.total);
}

class TicketCompleteState extends TicketDownloadState {}
