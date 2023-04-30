import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_pizza/bloc/pizza_bloc.dart';
import 'package:flutter_bloc_pizza/models/pizza_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return MultiBlocProvider(
      providers: [
        BlocProvider<PizzaBloc>(
          create: (context) => PizzaBloc()..add(LoadPizzaCounter()),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pizza Bloc',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Builder(builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Pizza Bloc'),
                centerTitle: true,
                backgroundColor: Colors.orange[800],
              ),
              body: Center(
                child: BlocBuilder<PizzaBloc, PizzaState>(
                    builder: (context, state) {
                  if (state is PizzaInitial) {
                    return const CircularProgressIndicator(
                        color: Colors.orange);
                  }
                  if (state is PizzaLoaded) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${state.pizzas.length}',
                          style: const TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 1.5,
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                for (int index = 0;
                                    index < state.pizzas.length;
                                    index++)
                                  Positioned(
                                      left: random.nextInt(250).toDouble(),
                                      top: random.nextInt(250).toDouble(),
                                      child: SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: state.pizzas[index].image,
                                      ))
                              ],
                            ))
                      ],
                    );
                  } else {
                    return const Text('Something went wrong');
                  }
                }),
              ),
              floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.orange[800],
                    onPressed: () {
                      context
                          .read<PizzaBloc>()
                          .add(AddPizza(pizza: Pizza.pizzas[0]));
                    },
                    child: const Icon(Icons.local_pizza_outlined),
                  ),
                  const SizedBox(height: 20),
                  FloatingActionButton(
                    backgroundColor: Colors.orange[800],
                    onPressed: () {
                      context
                          .read<PizzaBloc>()
                          .add(RemovePizza(pizza: Pizza.pizzas[0]));
                    },
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(height: 20),
                  FloatingActionButton(
                    backgroundColor: Colors.orange[800],
                    onPressed: () {
                      context
                          .read<PizzaBloc>()
                          .add(AddPizza(pizza: Pizza.pizzas[1]));
                    },
                    child: const Icon(Icons.local_pizza),
                  ),
                  const SizedBox(height: 20),
                  FloatingActionButton(
                    backgroundColor: Colors.orange[800],
                    onPressed: () {
                      context
                          .read<PizzaBloc>()
                          .add(RemovePizza(pizza: Pizza.pizzas[1]));
                    },
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            );
          })),
    );
  }
}
