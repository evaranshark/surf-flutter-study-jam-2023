abstract class TicketDownloadEvent {}

class DownloadTicket extends TicketDownloadEvent {
  final String name;
  DownloadTicket(this.name);
}

class PauseTicket extends TicketDownloadEvent {}

class CompleteTicket extends TicketDownloadEvent {}
