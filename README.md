# Authentication With Firebase

Questa applicazione Flutter implementa un sistema di autenticazione con **Firebase** che supporta: 
- **Login** con email e password
- **Registrazione** di nuovi utenti
- **Login con Google**
- **Gestione utente** e salvataggio dati in **Firebase Realtime Database**
- **Logout** e gestione sessione utente

---

## Anteprima

### Login screen
![Login](assets/login.png)

### Register screen
![Register](assets/register.png)

### Home screen
![Home](assets/home.png)

### Struttura Database Firebase
![Database](assets/database.png)

---

## Struttura del Progetto

Tutti i file sorgente si trovano nella cartella `lib/`.

lib/  
│  
├── main.dart --> Inizializzazione Firebase e schermata principale  
├── login_screen.dart --> Login con email/password o Google  
├── register_screen.dart --> Registrazione nuovi utenti  
├── profile_screen.dart --> Schermata utente loggato  
├── GoogleAuthentication.dart --> Funzione di login con Google  
│  
├── widgets/  
│ ├── alertDialog.dart --> Messaggi di errore/successo  
│ ├── buildTitle.dart --> Titoli schermate  
│ ├── button.dart --> Pulsanti personalizzati  
│ ├── textField.dart --> Input personalizzati  
│ └── textdisplay.dart --> Testo personalizzato  
│  
└── generated_plugin_registrant.dart --> Integrazione plugin Web Firebase  
