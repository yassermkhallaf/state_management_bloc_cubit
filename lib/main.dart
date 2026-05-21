import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:state_management_bloc_cubit/controllers/cubit/counter_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocSelector<CounterCubit, CounterState,int>(
                selector: (state)=>state.countA,
                builder: (context, countA) {
                  print("Counter A");
                  return Text(
                    'Counter A= ${countA.toString()}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  );
                },
              ),
              BlocSelector<CounterCubit, CounterState,int>(
                selector: (state)=> state.countB,
                builder: (context, countB) {
                  print("Counter b");
                  return Text(
                    'Counter B= ${countB.toString()}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<CounterCubit, CounterState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        context.read<CounterCubit>().incrementA();
                      },
                      child: Icon(Icons.add),
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton(
                      onPressed: () {
                        context.read<CounterCubit>().decrementA();
                      },
                      child: Icon(Icons.minimize),
                    ),
                  ],
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        context.read<CounterCubit>().incrementB();
                      },
                      child: Icon(Icons.add),
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton(
                      onPressed: () {
                        context.read<CounterCubit>().decrementB();
                      },
                      child: Icon(Icons.minimize),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
