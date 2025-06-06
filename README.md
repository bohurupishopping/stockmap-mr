# StockMap MR - Flutter App

A Flutter application for Medical Representatives (MR) to manage stock and inventory. This app provides role-based authentication where only users with 'mr' role can access the application.

## Features

- **Role-based Authentication**: Only users with 'mr' role can login
- **Supabase Integration**: Uses Supabase for authentication and database
- **Modern UI**: Clean and responsive Material Design 3 interface
- **State Management**: Uses Bloc pattern for robust state management
- **Navigation**: GoRouter for declarative routing

## Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- A Supabase project with the required database schema

## Database Setup

The app requires a Supabase database with the following setup:

1. **User Profiles Table**: Run the migration files in the `migrations/` folder:
   - `000initial.sql` - Creates the initial profiles table and user_role enum
   - `018add_mr_role.sql` - Adds the 'mr' role to the enum
   - `001UserSetup.sql` - Sets up user creation triggers

2. **Required Database Schema**:
   ```sql
   -- User roles enum
   CREATE TYPE public.user_role AS ENUM ('admin', 'user', 'mr');
   
   -- Profiles table
   CREATE TABLE public.profiles (
     id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
     user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL UNIQUE,
     name TEXT NOT NULL,
     email TEXT NOT NULL,
     role user_role NOT NULL DEFAULT 'user',
     created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
     updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
   );
   ```

## Setup Instructions

### 1. Clone and Install Dependencies

```bash
cd stockmap_mr
flutter pub get
```

### 2. Configure Supabase

1. Create a Supabase project at [supabase.com](https://supabase.com)
2. Run the migration files in your Supabase SQL editor
3. Get your project URL and anon key from Project Settings > API
4. Update the configuration in `lib/config/supabase_config.dart`:

```dart
class SupabaseConfig {
  static const String supabaseUrl = 'https://your-project-id.supabase.co';
  static const String supabaseAnonKey = 'your-anon-key-here';
}
```

### 3. Generate Code

Run the build runner to generate Freezed and JSON serialization code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Create Test User

In your Supabase dashboard:

1. Go to Authentication > Users
2. Create a new user with email and password
3. Go to Table Editor > profiles
4. Update the user's role to 'mr'

### 5. Run the App

```bash
flutter run
```

## Project Structure

```
lib/
├── bloc/
│   └── auth/
│       ├── auth_bloc.dart
│       ├── auth_event.dart
│       └── auth_state.dart
├── config/
│   └── supabase_config.dart
├── models/
│   └── user_profile.dart
├── pages/
│   ├── dashboard_page.dart
│   └── login_page.dart
├── repositories/
│   └── auth_repository.dart
├── router/
│   └── app_router.dart
└── main.dart
```

## Key Components

### Authentication Flow

1. **Login Page**: Users enter email and password
2. **Authentication**: Supabase Auth validates credentials
3. **Role Verification**: App checks if user has 'mr' role in profiles table
4. **Access Control**: Only 'mr' role users can access the dashboard
5. **Auto Logout**: Users without 'mr' role are automatically signed out

### State Management

- **AuthBloc**: Manages authentication state
- **AuthRepository**: Handles Supabase interactions
- **Freezed Models**: Immutable data classes for type safety

### Navigation

- **GoRouter**: Declarative routing with authentication guards
- **Auto Redirect**: Automatic navigation based on auth state

## Security Features

- **Role-based Access**: Only 'mr' role users can access the app
- **Automatic Logout**: Users are logged out if role changes
- **Secure Authentication**: Uses Supabase Auth with RLS policies

## Development

### Adding New Features

1. Create new pages in `lib/pages/`
2. Add routes in `lib/router/app_router.dart`
3. Create Bloc/Cubit for state management
4. Update navigation in dashboard

### Code Generation

When modifying models with Freezed annotations:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Troubleshooting

### Common Issues

1. **Supabase Connection Error**:
   - Verify URL and anon key in `supabase_config.dart`
   - Check internet connection
   - Ensure Supabase project is active

2. **Role Access Denied**:
   - Verify user has 'mr' role in profiles table
   - Check if user_role enum includes 'mr' value
   - Ensure RLS policies allow access

3. **Build Errors**:
   - Run `flutter clean && flutter pub get`
   - Regenerate code with build_runner
   - Check for missing imports

### Database Debugging

To check user roles in Supabase:

```sql
SELECT p.*, u.email 
FROM profiles p 
JOIN auth.users u ON p.user_id = u.id 
WHERE p.role = 'mr';
```

## License

This project is licensed under the MIT License.
#   s t o c k m a p - m r  
 