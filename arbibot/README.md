# ArbiBot

ArbiBot is an AI-powered legal assistant application for Ghanaian law, built with Flutter and powered by LangChain and Supabase.

## Features

- 🔐 **Authentication** - Secure user authentication with Supabase
- 💬 **AI Chat** - Intelligent legal assistance with streaming responses
- 📚 **Legal Research** - Citation-based research for Ghanaian case law
- 📝 **Document Drafting** - AI-assisted legal document generation
- 👤 **CV Builder** - Professional CV creation for legal professionals
- 📄 **Document Management** - Store and manage legal documents

## Tech Stack

- **Frontend**: Flutter
- **State Management**: Riverpod
- **Navigation**: GoRouter
- **Backend**: Supabase (Auth, Database, Storage)
- **AI**: LangChain.dart with OpenAI
- **Design**: Custom Material Design theme with Manrope font

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Supabase account
- OpenAI API key

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/FredrickDickson/arbibot.git
   cd arbibot
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Set up environment variables:
   - Copy `.env.example` to `.env`
   - Add your Supabase and OpenAI credentials

4. Run the app:
   ```bash
   flutter run
   ```

## Database Setup

The database schema is managed with Supabase migrations. See `supabase/SETUP_GUIDE.md` for detailed instructions.

## Project Structure

```
lib/
├── core/           # Core functionality (theme, router, services)
├── features/       # Feature modules
│   ├── auth/       # Authentication
│   ├── chat/       # AI Chat
│   ├── research/   # Legal Research
│   ├── drafting/   # Document Drafting
│   ├── profile/    # User Profile & CV
│   └── ...
└── main.dart       # App entry point
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.

## Disclaimer

ArbiBot is an assistive tool. All outputs are drafts only, citation-based, and must be reviewed by a qualified legal professional.
