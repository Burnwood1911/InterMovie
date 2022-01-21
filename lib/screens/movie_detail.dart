import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inter_movie/models/movie_detail.dart';
import 'package:inter_movie/services/api_service.dart';

class MovieDetalView extends StatefulWidget {
  final int movieId;
  const MovieDetalView({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  _MovieDetalViewState createState() => _MovieDetalViewState();
}

class _MovieDetalViewState extends State<MovieDetalView> {
  ApiService? _apiService;
  Future<MovieDetail>? movieFuture;

  @override
  void initState() {
    _apiService = ApiService();
    movieFuture = _apiService!.movieDetail(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieDetail>(
        future: movieFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Container(
                  color: Colors.white,
                  child: const Center(child: CupertinoActivityIndicator())),
            );
          } else {
            MovieDetail movieDetail = snapshot.data!;
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(movieDetail.title!, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                centerTitle: true,
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                iconTheme: const IconThemeData(color: Colors.black),),
              body: Column(
                children: [
                  ClipPath(
                    child: ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/original${movieDetail.backdropPath}',
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CupertinoActivityIndicator(),
                      ),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("OVERVIEW",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black45))
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                            height: 100,
                            child: Text(
                              movieDetail.overview!,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            )),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "RELEASE DATE",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  movieDetail.releaseDate!,
                                  style: const TextStyle(
                                      color: Color.fromRGBO(
                                          232, 22, 103, 75)),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "RUNTIME",
                                  style: TextStyle(color: Colors.black45),
                                ),
                                Text(
                                  '${movieDetail.runtime!.toString()} MINS',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(
                                          232, 22, 103, 75),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "BUDGET",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w500),
                                ),

                                
                                Text(
                                  '\$${movieDetail.budget!.toString()}',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(
                                          232, 22, 103, 75)),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            const Text("CAST",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black45)), const
                                    SizedBox(height: 15,),

                          SizedBox(
                            height: 100,
                            child: Text(
                              movieDetail.castList!.join(', '),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            )),
                          ],
                        ),
                        
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        });
  }
}
