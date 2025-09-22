# 📝 Note-Taking App with Offline Sync

A professional Flutter note-taking application built with clean architecture, featuring offline-first functionality and automatic synchronization with remote API.

## ✨ Features

### Core Features
- **Create, Edit, Delete Notes**: Full CRUD operations for note management
- **Offline-First Architecture**: Works seamlessly without internet connection
- **Automatic Sync**: Syncs with JSONPlaceholder API when online
- **Local Storage**: Uses Hive for fast, efficient local data persistence
- **Real-time Connectivity**: Monitors network status and auto-syncs when back online

### Bonus Features
- **🌙 Dark Mode Support**: Toggle between light and dark themes
- **🎨 Color Tags**: Organize notes with customizable color coding
- **🔍 Search Functionality**: Find notes quickly with search
- **📱 Responsive Design**: Optimized for all screen sizes using ScreenUtil
- **⚡ Shimmer Loading**: Beautiful loading states with shimmer effects

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── main.dart                    # App entry point
├── app.dart                     # App configuration
├── core/                        # Core functionality
│   ├── bindings/               # Dependency injection
│   ├── common/                 # Shared widgets & styles
│   ├── services/               # External services
│   ├── utils/                  # Constants, helpers, theme
│   └── websocketMethod/        # WebSocket implementation
├── features/                   # Feature modules
│   └── notes/                  # Notes feature
│       ├── data/               # Data layer
│       │   ├── datasources/    # Local & remote data sources
│       │   ├── models/         # Data models
│       │   └── repositories/   # Repository implementations
│       ├── domain/             # Domain layer
│       │   ├── entities/       # Business entities
│       │   ├── repositories/   # Repository interfaces
│       │   └── usecases/       # Business logic
│       └── presentation/       # Presentation layer
│           ├── controllers/    # State management (GetX)
│           └── views/          # UI screens & widgets
└── routes/                     # Navigation routing
```

### Architecture Layers

#### 1. **Data Layer**
- **Local Data Source**: Hive database for offline storage
- **Remote Data Source**: JSONPlaceholder API integration
- **Repository Implementation**: Handles data operations and caching

#### 2. **Domain Layer**
- **Entities**: Core business models
- **Repository Interfaces**: Abstract data operations
- **Use Cases**: Business logic implementation

#### 3. **Presentation Layer**
- **Controllers**: State management with GetX
- **Views**: UI screens and widgets
- **Models**: UI-specific data models

## 🛠️ Tech Stack

### Core Dependencies
- **Flutter**: Cross-platform UI framework
- **GetX**: State management, routing, and dependency injection
- **Hive**: Fast, lightweight NoSQL database
- **HTTP**: API communication
- **Connectivity Plus**: Network connectivity monitoring

### UI & UX
- **Flutter ScreenUtil**: Responsive design
- **Flutter EasyLoading**: Loading states and notifications
- **Shimmer**: Beautiful loading animations

### Development
- **Logger**: Advanced logging functionality
- **Shared Preferences**: Simple key-value storage

## 📱 Screenshots

*Screenshots will be added after UI implementation*

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.8.1)
- Dart SDK
- Android Studio / VS Code
- Android device/emulator or iOS device/simulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd task_3
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

**Android APK:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## 🔧 Configuration

### API Configuration
The app uses JSONPlaceholder API for demonstration:
- **Base URL**: `https://jsonplaceholder.typicode.com`
- **Endpoint**: `POST /posts` for note synchronization

### Local Storage
- **Database**: Hive boxes for notes and sync queue
- **Cache**: Automatic cleanup of old data
- **Encryption**: Ready for production encryption setup

## 📊 State Management

Using **GetX** for:
- **Reactive State Management**: Automatic UI updates
- **Dependency Injection**: Clean service registration
- **Route Management**: Declarative navigation
- **Utils**: Snackbars, dialogs, and bottom sheets

## 🔄 Offline Sync Logic

### Sync Strategy
1. **Offline Operations**: All CRUD operations work offline
2. **Queue System**: Failed sync operations are queued
3. **Connectivity Monitoring**: Auto-retry when connection restored
4. **Conflict Resolution**: Last-write-wins strategy
5. **Error Handling**: Graceful failure with user feedback

### Sync Process
```
1. User performs action (create/edit/delete note)
2. Save to local database immediately
3. Attempt API sync if online
4. If offline, add to sync queue
5. Monitor connectivity
6. Auto-sync queue when back online
7. Update UI with sync status
```

## 🧪 Testing

### Running Tests
```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/

# Test coverage
flutter test --coverage
```

### Test Strategy
- **Unit Tests**: Business logic and use cases
- **Widget Tests**: UI components and interactions
- **Integration Tests**: End-to-end user flows
- **API Tests**: Network layer and error scenarios

## 📚 API Documentation

### JSONPlaceholder Integration

**Create/Update Note:**
```http
POST https://jsonplaceholder.typicode.com/posts
Content-Type: application/json

{
  "title": "Note Title",
  "body": "Note content",
  "userId": 1
}
```

**Response:**
```json
{
  "id": 101,
  "title": "Note Title",
  "body": "Note content",
  "userId": 1
}
```

### Error Handling
- **Network Errors**: Graceful offline mode
- **API Errors**: User-friendly error messages
- **Validation Errors**: Form validation feedback
- **Sync Conflicts**: Automatic resolution

## 🎨 Design System

### Colors
- **Primary**: Material 3 design system
- **Note Tags**: Customizable color palette
- **Dark Mode**: Automatic theme switching

### Typography
- **Global Text Styles**: Consistent font sizing
- **Responsive Text**: ScreenUtil integration
- **Accessibility**: Support for system font scaling

### Components
- **Custom Widgets**: Reusable UI components
- **Material Design**: Following Material 3 guidelines
- **Animations**: Smooth transitions and micro-interactions

## 🔒 Security Considerations

- **Data Encryption**: Ready for Hive encryption
- **API Security**: Token-based authentication ready
- **Input Validation**: Comprehensive form validation
- **Error Logging**: Secure error reporting

## 📈 Performance Optimizations

- **Lazy Loading**: Efficient data loading
- **Caching Strategy**: Intelligent cache management
- **Memory Management**: Proper disposal of resources
- **Build Optimization**: Tree shaking and code splitting

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Developer

**Johirul Islam**
- Clean Architecture Implementation
- Offline-First Development
- Flutter Expert

## 📞 Support

For support and questions:
- Create an issue in the repository
- Follow Flutter best practices
- Check documentation for detailed implementation

---

**Built with ❤️ using Flutter and Clean Architecture**
