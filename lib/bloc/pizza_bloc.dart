import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_pizza/models/pizza_model.dart';

part 'pizza_event.dart';
part 'pizza_state.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  PizzaBloc() : super(PizzaInitial()) {
    on<PizzaEvent>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 3));
      emit(const PizzaLoaded(pizzas: <Pizza>[]));
    });

    on<AddPizza>((event, emit) {
      if (state is PizzaLoaded) {
        final state = this.state as PizzaLoaded;
        emit(
          PizzaLoaded(
            pizzas: List<Pizza>.from(state.pizzas)..add(event.pizza),
          ),
        );
      }
    });

    on<RemovePizza>((event, emit) {
      if (state is PizzaLoaded) {
        final state = this.state as PizzaLoaded;
        emit(
          PizzaLoaded(
            pizzas: List<Pizza>.from(state.pizzas)..remove(event.pizza),
          ),
        );
      }
    });
  }
}
