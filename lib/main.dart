// Flutter Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import './providers/accounts.dart';
import './providers/projects.dart';

// Screens
import './screens/accounts_screen.dart';
import './screens/account_detail_screen.dart';
import './screens/edit_account_screen.dart';
import './screens/projects_screen.dart';
import './screens/project_detail_screen.dart';

// Widgets
import './widgets/app_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Accounts(),
        ),
        ChangeNotifierProvider.value(
          value: Projects(),
        )
      ],
      child: MaterialApp(
        title: 'Solar WMS',
        theme: ThemeData(
          fontFamily: 'Roboto',
          primaryColor: Colors.blue,
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 25),
          ),
        ),
        home: MyHomePage(title: 'Solar Warehouse Management System'),
        routes: {
          AccountsScreen.routeName: (context) => AccountsScreen(),
          AccountDetailScreen.routeName: (context) => AccountDetailScreen(),
          ProjectsScreen.routeName: (context) => ProjectsScreen(),
          ProjectDetailScreen.routeName: (context) => ProjectDetailScreen(),
          EditAccountScreen.routeName: (context) => EditAccountScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      drawer: AppDrawer(),
      body: Center(),
    );
  }
}
