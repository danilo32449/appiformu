import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/car_movie.dart';

class MovieService extends ChangeNotifier {
  // Usar la URL "raw" de tu archivo movies.json en GitHub
  final String _baseUrl = 'https://cors-anywhere.herokuapp.com/https://carsmoviesinventoryproject-production.up.railway.app/api/v1/carsmovies?size=29';
  List<CarMovie> _movies = [];

  List<CarMovie> get movies => _movies;

  Future<void> fetchMovies() async {
    final Uri uri = Uri.parse('$_baseUrl'); // Ruta completa al archivo JSON
    print('FETCH: Iniciando petición GET a: $uri');
    try {
      final response = await http.get(uri);
      print('FETCH: Respuesta recibida con código de estado: ${response.statusCode}');
      print('FETCH: Cuerpo de la respuesta: ${response.body}');
      if (response.statusCode == 200) {
        // La estructura de tu JSON es directamente un array, no dentro de "Movies"
        final List<dynamic> moviesData = json.decode(response.body)["Movies"];
        _movies = moviesData.map((json) => CarMovie.fromJson(json)).toList();
        notifyListeners();
      } else {
        print('FETCH: Falló la obtención de películas. Código de estado: ${response.statusCode}');
        // Manejar el error apropiadamente
      }
    } catch (error) {
      print('FETCH: Error al realizar la petición GET: $error');
      // Manejar el error apropiadamente
    }
  }

  // Las funciones addMovie, updateMovie y deleteMovie no funcionarán para
  // guardar datos directamente en un archivo estático de GitHub Pages.
  // Solo pueden simular la acción en la interfaz de usuario.

  Future<void> addMovie(CarMovie movie) async {
    // Simulación de agregar una película (no persistente en GitHub Pages)
    _movies = [..._movies, movie];
    notifyListeners();
    print('SIMULACIÓN: Película agregada localmente: ${movie.toJson()}');
  }

  Future<void> updateMovie(String id, CarMovie movie) async {
    // Simulación de actualizar una película (no persistente en GitHub Pages)
    final index = _movies.indexWhere((m) => m.id == id);
    if (index != -1) {
      _movies[index] = movie;
      notifyListeners();
      print('SIMULACIÓN: Película actualizada localmente: ${movie.id} con datos: ${movie.toJson()}');
    }
  }

  Future<void> deleteMovie(String id) async {
    // Simulación de eliminar una película (no persistente en GitHub Pages)
    _movies.removeWhere((m) => m.id == id);
    notifyListeners();
    print('SIMULACIÓN: Película eliminada localmente con ID: $id');
  }
}