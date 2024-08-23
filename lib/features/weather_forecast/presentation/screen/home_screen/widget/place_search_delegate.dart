import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/resource/resource.dart';
import 'package:weather/features/weather_forecast/presentation/provider/place_provider.dart';
import '../../../../domain/entity/local/place_entity.dart';

class PlaceSearchDelegate extends SearchDelegate<PlaceEntity> {
  Function(String)? onPlaceSelected;
  Function()? onCurrentLocation;

  BuildContext? context;
  String _currentQuery = "";
  final ScrollController _controller = ScrollController();

  PlaceSearchDelegate(this.context,
      {required Function(String) this.onPlaceSelected,
      required Function() this.onCurrentLocation}
      ) {
    _controller.addListener(() {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange &&
          _currentQuery != "") {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context!
              .read<PlaceProvider>()
              .loadMore("%${_currentQuery.toUpperCase()}%");
        });
      }
    });
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return theme.copyWith(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: colorScheme.brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          backgroundColor: colorScheme.surface,
          iconTheme: theme.primaryIconTheme.copyWith(color: colorScheme.onSurface),
          titleTextStyle: Theme.of(context).textTheme.titleMedium,
          toolbarTextStyle: Theme.of(context).textTheme.bodyMedium,
        ),
        inputDecorationTheme: searchFieldDecorationTheme ??
            InputDecorationTheme(
              hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
              border: InputBorder.none,
            ));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          _clear(context);
          query.isEmpty ? close(context, PlaceEntity()) : query = '';
        },
      ),
      IconButton(
        icon: const Icon(Icons.location_on),
        onPressed: () {
          if(onCurrentLocation != null) onCurrentLocation!();
          close(context, PlaceEntity());
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        _clear(context);
        close(context, PlaceEntity());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return (query != "") ? _buildSearchResult(context) : const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return (query != "") ? _buildSearchResult(context) : const SizedBox();
  }

  void _search(BuildContext context, String query) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlaceProvider>().searchPlace("%${query.toUpperCase()}%");
    });
  }

  void _clear(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlaceProvider>().clearSearchResult();
    });
  }

  Widget _buildSearchResult(BuildContext context) {
    if (query != _currentQuery) {
      _currentQuery = query;
      _search(context, query);
    }
    return Consumer<PlaceProvider>(
      builder: (context, provider, child) {
        if (provider.searchResult is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.searchResult is Error) {
          return const Center(child: Icon(Icons.error));
        } else if (provider.searchResult is Success) {
          final searchResult = provider.searchResult?.data ?? [];

          return ListView.builder(
            controller: _controller,
            itemCount: searchResult.length,
            itemBuilder: (context, index) {
              return _buildListItem(searchResult[index], context);
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildListItem(PlaceEntity entity, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPlaceSelected != null) onPlaceSelected!(entity.place!);
        _clear(context);
        close(context, PlaceEntity());
      },
      child: ListTile(
        leading: const Icon(Icons.gps_fixed),
        title: Text("${entity.countryCode}, ${entity.city}, ${entity.place}"),
      ),
    );
  }
}
