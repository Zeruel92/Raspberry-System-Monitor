# Raspberry System Monitor

Monitor di sistema che permette l'avvio e lo stop di alcuni servizi che girano sulla raspberry

## Compilare su Desktop

L'app è stata testata usando Flutter 1.2.1 e [Flutter Desktop Embedding][2] su Linux, la versione dell'embedder usata è il commit 92fa610.
Per compilare portarsi nella root del progetto e usare il comando make -C linux_fde.
Per usare sistemi operativi differenti fare riferimento alle istruzioni su [Flutter Desktop Embedding][2].

## Getting Started

Avvia l'app e aspetta che comunichi col sistema.

NB: sulla raspberrry deve essere installato e avviato il server: [Raspberry Server][1]

### Status
32 bit: [![Codemagic build status](https://api.codemagic.io/apps/5c854d9117fd830009ea0236/5c854d9117fd830009ea0235/status_badge.svg)](https://codemagic.io/apps/5c854d9117fd830009ea0236/5c854d9117fd830009ea0235/latest_build)
64 bit: [![Codemagic build status](https://api.codemagic.io/apps/5c854d9117fd830009ea0236/5ce79f6d1c60c30016c4b76b/status_badge.svg)](https://codemagic.io/apps/5c854d9117fd830009ea0236/5ce79f6d1c60c30016c4b76b/latest_build)

[//]: #Links
[1]: https://github.com/pspgt/Raspberry-System-Monitor-Server
[2]: https://github.com/google/flutter-desktop-embedding