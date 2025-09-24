# Notes App - Flutter Task 3

A professional note-taking application built with Flutter featuring offline-first architecture, clean code structure, and seamless API synchronization.

## 📱 Features

### Core Functionality
- ✅ **Create/Edit/Delete Notes**: Full CRUD operations for notes management
- ✅ **Local Storage**: Uses Hive for efficient local data persistence  
- ✅ **API Synchronization**: Syncs notes with JSONPlaceholder API on save
- ✅ **Offline-First Logic**: Works seamlessly offline with automatic sync when online
- ✅ **Search Functionality**: Real-time search through notes by title and content

### Bonus Features  
- ✅ **Dark Mode Support**: Toggle between light and dark themes with proper color contrast
- ✅ **Shimmer Loading**: Beautiful shimmer loading effects during data fetch
- ✅ **Color Tags**: Assign colors to notes for better organization
- ✅ **Error Handling**: Comprehensive error handling with user-friendly messages
- ✅ **Loading States**: Professional loading indicators and shimmer effects
- ✅ **Pull to Refresh**: Refresh notes list with pull gesture

## 🏗️ Architecture

### Clean Architecture Implementation
The app follows a strict **3-layer clean architecture** pattern:

```
lib/
├── core/                           # Core functionality & utilities
│   ├── bindings/                   # Dependency injection
│   ├── common/                     # Shared widgets & styles
│   ├── services/                   # Core services (Network, Storage, local data persistence etc.)
│   └── utils/                      # Constants, themes, helpers
├── features/                       # Feature modules
│   ├── notes/                      # Notes feature
│   │   ├── controllers/            # Business logic & state management
│   │   ├── models/                 # Data models
│   │   └── views/                  # UI layer (screens & widgets)
│   └── settings/                   # Settings feature
└── routes/                         # App routing configuration
```

### Layer Separation
│   │   ├── repositories/           # Data layer abstraction
#### 1. **Presentation Layer** (`views/`)
- UI components (screens & widgets)
- User interaction handling
- State observation

#### 2. **Domain Layer** (`controllers/`)  
- Business logic implementation
- State management with GetX
- Use case orchestration

#### 3. **Data Layer** (`repositories/`, `models/`)
- Local storage with Hive
- API communication
- Data transformation

## 🛠️ Technical Stack

### State Management
- **GetX**: Reactive state management with dependency injection
- **Reactive Programming**: Observable patterns for UI updates

### Local Database
- **Hive**: High-performance NoSQL database
- **Type Adapters**: Code generation for type-safe serialization
- **Box Management**: Efficient data organization

### Network & Sync
- **HTTP Client**: RESTful API communication
- **Connectivity Plus**: Network status monitoring  
- **Retry Logic**: Automatic retry mechanism for failed requests
- **JSONPlaceholder API**: Mock backend for note synchronization

### UI & Theming
- **Material Design 3**: Modern UI components
- **Custom Themes**: Light/Dark mode support
- **ScreenUtil**: Responsive sizing
- **EasyLoading**: Elegant loading states

## 📦 Dependencies

```yaml
dependencies:
  # State Management
  get: ^4.6.6
  
  # Local Storage  
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # Network
  http: ^1.2.1
  connectivity_plus: ^6.0.3
  
  # UI & Utils
  flutter_screenutil: ^5.9.3
  flutter_easyloading: ^3.0.5
  shimmer: ^3.0.0
  logger: ^2.4.0
  flutter_colorpicker: ^1.1.0

dev_dependencies:
  # Code Generation
  hive_generator: ^2.0.1  
  build_runner: ^2.4.12
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>= 3.8.1)
- Dart SDK (>= 3.8.1)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/MrJohir/Task_3.git
   cd task_3
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

```bash
# Android
flutter build apk --release

# iOS  
flutter build ios --release
```

## 🔄 API Integration

### JSONPlaceholder Integration
The app integrates with [JSONPlaceholder](https://jsonplaceholder.typicode.com/) for note synchronization:

- **Endpoint**: `POST https://jsonplaceholder.typicode.com/posts`
- **Request Format**:
  ```json
  {
    "title": "Note Title",
    "body": "Note Content", 
    "userId": 1
  }
  ```
- **Response**: Returns server-generated ID for sync tracking

### Offline-First Strategy
1. **Local-First**: All operations work locally first
2. **Background Sync**: Automatic sync when connectivity restored
3. **Conflict Resolution**: Server data takes precedence
4. **Retry Logic**: Failed requests automatically retried

## 🎨 Features Deep Dive

### Note Management
- **Rich Text Editor**: Multi-line content support
- **Auto-save**: Automatic local saving
- **Validation**: Input validation with error messages
- **Color Coding**: 9 predefined color options

### Search & Filter
- **Real-time Search**: Instant search results
- **Title & Content**: Searches both title and content
- **Case Insensitive**: Flexible search matching

### Synchronization
- **Status Indicators**: Visual sync status on each note
- **Batch Sync**: Sync multiple notes efficiently  
- **Error Recovery**: Graceful handling of sync failures
- **Connectivity Aware**: Smart sync based on network status

### User Experience
- **Responsive Design**: Adapts to different screen sizes
- **Smooth Animations**: Polished transitions
- **Shimmer Loading**: Professional loading placeholders that mimic content structure
- **Dark Mode**: Complete dark theme with proper color contrast for visibility
- **Loading States**: Clear feedback during operations with shimmer effects
- **Error Messages**: User-friendly error communication

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests  
```bash
flutter drive --target=test_driver/app.dart
```

## 📁 Project Structure Details

### Core Services
- **NetworkCaller**: HTTP client wrapper with error handling
- **StorageService**: Hive database management
- **ConnectivityService**: Network monitoring with GetX reactive updates
- **SyncService**: Background synchronization logic

### Feature Organization
Each feature follows the same structure:
- `controllers/`: State management & business logic
- `models/`: Data models with Hive annotations
- `repositories/`: Data access layer
- `views/screens/`: Full-screen UI components
- `views/widgets/`: Reusable UI components

### Common Components
- **CustomAppBar**: Consistent app bar design
- **CustomButton**: Reusable button variants
- **CustomCard**: Material card wrapper
- **LoadingWidget**: Standardized loading states
- **EmptyStateWidget**: Elegant empty states

## 🎯 Code Quality

### Standards Followed
- **Clean Code**: Self-documenting code with meaningful names
- **SOLID Principles**: Single responsibility, dependency inversion
- **Consistent Formatting**: Automated formatting with Dart conventions
- **Error Handling**: Comprehensive try-catch blocks
- **Logging**: Structured logging for debugging

### Architecture Benefits
- **Maintainability**: Clear separation of concerns
- **Testability**: Easily mockable dependencies  
- **Scalability**: Feature-based organization
- **Reusability**: Shared components and utilities

## 🚀 Performance Optimizations

- **Lazy Loading**: On-demand data loading
- **Efficient Queries**: Optimized Hive operations
- **Memory Management**: Proper disposal of controllers
- **Network Optimization**: Request batching and caching

## 🔮 Future Enhancements

- [ ] **Rich Text Formatting**: Bold, italic, lists
- [ ] **Image Support**: Attach images to notes
- [ ] **Categories**: Organize notes in folders
- [ ] **Sharing**: Export and share notes
- [ ] **Backup**: Cloud backup integration
- [ ] **Collaboration**: Multi-user note sharing

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Developer

**Johirul Islam**
- GitHub: [@MrJohir](https://github.com/MrJohir)
- Email: johir.cse@gmail.com

---

Built with ❤️ using Flutter & Clean Architecture principles.
