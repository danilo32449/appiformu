import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/car_movie.dart';
import '../services/movie_service.dart';

class EditMovieScreen extends StatefulWidget {
  final CarMovie movie;

  const EditMovieScreen({super.key, required this.movie});

  @override
  _EditMovieScreenState createState() => _EditMovieScreenState();
}

class _EditMovieScreenState extends State<EditMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _yearController;
  late TextEditingController _durationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.movie.carMovieName);
    _yearController = TextEditingController(text: widget.movie.carMovieYear);
    _durationController = TextEditingController(text: widget.movie.duration.toString());
  }

  void _updateMovie(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final updatedMovie = CarMovie(
        id: widget.movie.id,
        carMovieName: _nameController.text,
        carMovieYear: _yearController.text,
        duration: int.parse(_durationController.text),
      );
      Provider.of<MovieService>(context, listen: false).updateMovie(widget.movie.id, updatedMovie);
      Navigator.pop(context); // Volver a la lista de películas
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Movie Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the movie name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(
                  labelText: 'Release Year',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the release year';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid year';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(
                  labelText: 'Duration (minutes)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the duration';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid duration';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () => _updateMovie(context),
                child: const Text('Update Movie'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}