import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/car_movie.dart';
import '../services/movie_service.dart';
import 'add_movie_screen.dart';
import 'edit_movie_screen.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MovieService>(context, listen: false).fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    final movieService = Provider.of<MovieService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Movies'),
      ),
      body: movieService.movies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: movieService.movies.length,
              itemBuilder: (context, index) {
                final movie = movieService.movies[index];
                return ListTile(
                  title: Text(movie.carMovieName),
                  subtitle: Text('${movie.carMovieYear} - ${movie.duration} min'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditMovieScreen(movie: movie),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteMovie(context, movie.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMovieScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _deleteMovie(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext alertContext) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text('¿Estás seguro de que deseas eliminar esta película?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(alertContext).pop();
              },
            ),
            TextButton(
              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Provider.of<MovieService>(context, listen: false).deleteMovie(id);
                Navigator.of(alertContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}