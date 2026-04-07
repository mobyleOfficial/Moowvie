import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import 'package:movies_data/datasources/remote/movies_remote_data_source.dart';
import 'package:movies_data/models/remote/remote_movie_collection.dart';
import 'package:movies_data/models/remote/remote_movie_collection_listing.dart';
import 'package:movies_data/models/remote/remote_movie.dart';
import 'package:movies_data/models/remote/remote_movie_list.dart';
import 'package:movies_data/models/remote/remote_movie_list_detail.dart';
import 'package:movies_data/models/remote/remote_movie_list_listing.dart';
import 'package:movies_data/models/remote/remote_movie_detail.dart';
import 'package:movies_data/models/remote/remote_movie_review.dart';
import 'package:movies_data/models/remote/remote_movie_review_listing.dart';
import 'package:movies_data/models/remote/remote_trending_movie_listing.dart';

@injectable
class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final HttpClient _httpClient;

  MoviesRemoteDataSourceImpl(@Named('tmdb') this._httpClient);

  static const _mockedReviews = [
    RemoteMovieReview(id: 693134, title: 'Dune: Part Two', date: 'Mar 15, 2024', rating: 4.5),
    RemoteMovieReview(id: 872585, title: 'Oppenheimer', date: 'Mar 10, 2024', rating: 5.0),
    RemoteMovieReview(id: 792307, title: 'Poor Things', date: 'Mar 5, 2024', rating: 4.0),
    RemoteMovieReview(id: 929590, title: 'The Zone of Interest', date: 'Feb 28, 2024', rating: 3.5),
    RemoteMovieReview(id: 876969, title: 'Society of the Snow', date: 'Feb 20, 2024', rating: 4.0),
    RemoteMovieReview(id: 976573, title: 'Past Lives', date: 'Feb 14, 2024', rating: 4.5),
    RemoteMovieReview(id: 913209, title: 'Anatomy of a Fall', date: 'Feb 10, 2024', rating: 4.0),
    RemoteMovieReview(id: 840430, title: 'The Holdovers', date: 'Feb 5, 2024', rating: 4.5),
    RemoteMovieReview(id: 346698, title: 'Barbie', date: 'Jan 28, 2024', rating: 3.5),
    RemoteMovieReview(id: 507089, title: 'Five Nights at Freddy\'s', date: 'Jan 20, 2024', rating: 3.0),
    RemoteMovieReview(id: 609681, title: 'The Beekeeper', date: 'Jan 15, 2024', rating: 3.5),
    RemoteMovieReview(id: 940551, title: 'Migration', date: 'Jan 10, 2024', rating: 4.0),
    RemoteMovieReview(id: 866398, title: 'The Brutalist', date: 'Jan 5, 2024', rating: 4.5),
    RemoteMovieReview(id: 1064028, title: 'Anora', date: 'Dec 28, 2023', rating: 5.0),
    RemoteMovieReview(id: 558449, title: 'Animal', date: 'Dec 20, 2023', rating: 3.0),
    RemoteMovieReview(id: 753342, title: 'Napoleon', date: 'Dec 15, 2023', rating: 3.5),
  ];

  static const _mockedCollections = [
    RemoteMovieCollection(title: 'Best of 2024', movieCount: 24),
    RemoteMovieCollection(title: 'Essential Sci-Fi', movieCount: 18),
    RemoteMovieCollection(title: 'Weekend Picks', movieCount: 12),
    RemoteMovieCollection(title: 'Must Watch Classics', movieCount: 30),
    RemoteMovieCollection(title: 'Horror Gems', movieCount: 15),
    RemoteMovieCollection(title: 'A24 Favorites', movieCount: 22),
    RemoteMovieCollection(title: 'Oscar Winners', movieCount: 20),
    RemoteMovieCollection(title: 'Hidden Gems 2023', movieCount: 16),
    RemoteMovieCollection(title: 'Action Blockbusters', movieCount: 25),
    RemoteMovieCollection(title: 'Indie Darlings', movieCount: 14),
    RemoteMovieCollection(title: 'Documentary Essentials', movieCount: 10),
    RemoteMovieCollection(title: 'Animation Masterpieces', movieCount: 19),
  ];

  static const _mockedLists = [
    RemoteMovieList(
      id: 1,
      name: 'Weekend Watchlist',
      creator: 'Sarah Chen',
      description: 'Perfect movies for a lazy weekend. A curated selection of feel-good films, cozy dramas, and light-hearted comedies that pair perfectly with a blanket and some popcorn. Whether you are looking for something to watch solo or with the whole family, this list has you covered with titles that range from critically acclaimed indie gems to crowd-pleasing blockbusters. Grab your favorite snacks, dim the lights, and let these stories transport you somewhere wonderful without ever leaving your couch.',
      movieCount: 12,
      posterPaths: ['/8b8R8l88Qje9dn9OE8PY05Nez7C.jpg', '/d5NXSklXo0qyIYkgV94XAgMIckC.jpg', '/gPbM0MK8CP8A174kI2PGjGVdWHN.jpg', '/vpnVM9B6NMmQpWeZvzLbVd9dTSA.jpg', '/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg'],
    ),
    RemoteMovieList(
      id: 2,
      name: 'Mind-Bending Thrillers',
      creator: 'Jake Morrison',
      description: 'Films that will keep you guessing until the very last frame. From psychological twists to reality-warping narratives, these movies demand your full attention. Every entry on this list was chosen because it does something unexpected with the thriller genre — whether it is an unreliable narrator, a time-loop puzzle, or a slow-burn mystery that completely recontextualizes everything you thought you knew. Perfect for viewers who love dissecting plot details and rewatching scenes to catch hidden clues they missed the first time around.',
      movieCount: 18,
      posterPaths: ['/qJ2tW6WMUDux911BTUgDYCrmpGe.jpg', '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg', '/7WsyChQLEftFiDhRDpZFHSunFD2.jpg', '/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg'],
    ),
    RemoteMovieList(
      id: 3,
      name: 'Feel-Good Classics',
      creator: 'Emma Wright',
      description: 'Guaranteed to brighten your day. Timeless films that never fail to put a smile on your face, from beloved rom-coms to heartwarming family favorites.',
      movieCount: 24,
      posterPaths: ['/d5NXSklXo0qyIYkgV94XAgMIckC.jpg', '/vpnVM9B6NMmQpWeZvzLbVd9dTSA.jpg', '/8b8R8l88Qje9dn9OE8PY05Nez7C.jpg', '/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg', '/gPbM0MK8CP8A174kI2PGjGVdWHN.jpg', '/qJ2tW6WMUDux911BTUgDYCrmpGe.jpg'],
    ),
    RemoteMovieList(
      id: 4,
      name: 'Foreign Language Gems',
      creator: 'Luca Rossi',
      description: 'The best of world cinema. Explore extraordinary stories from every corner of the globe — from Korean thrillers to French dramas to Japanese animation. This collection celebrates the incredible diversity of international filmmaking, featuring works that have won top prizes at Cannes, Venice, Berlin, and beyond. Each film offers a window into a different culture and storytelling tradition, proving that great cinema transcends language barriers. Subtitles included, of course, because as Bong Joon-ho once said, once you overcome the one-inch-tall barrier of subtitles, you will be introduced to so many more amazing films.',
      movieCount: 15,
      posterPaths: ['/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg', '/7WsyChQLEftFiDhRDpZFHSunFD2.jpg', '/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg'],
    ),
    RemoteMovieList(
      id: 5,
      name: 'Director\'s Cut',
      creator: 'Mia Tanaka',
      description: 'Essential films from legendary directors. A journey through the filmographies of cinema\'s greatest visionaries, from Kubrick to Villeneuve. This list spans decades of filmmaking excellence, highlighting the defining works of auteurs who shaped the language of cinema itself. You will find everything from Hitchcock\'s masterful suspense to Scorsese\'s gritty character studies, from Spielberg\'s sense of wonder to Nolan\'s architectural storytelling. Each film is not just entertainment but a masterclass in the craft of directing.',
      movieCount: 30,
      posterPaths: ['/gPbM0MK8CP8A174kI2PGjGVdWHN.jpg', '/8b8R8l88Qje9dn9OE8PY05Nez7C.jpg', '/d5NXSklXo0qyIYkgV94XAgMIckC.jpg', '/vpnVM9B6NMmQpWeZvzLbVd9dTSA.jpg', '/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg'],
    ),
    RemoteMovieList(
      id: 6,
      name: 'Underrated 2024',
      creator: 'Noah Kim',
      description: 'Great films you might have missed this year. Hidden treasures that flew under the radar but deserve your attention.',
      movieCount: 10,
      posterPaths: ['/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg', '/qJ2tW6WMUDux911BTUgDYCrmpGe.jpg', '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg', '/7WsyChQLEftFiDhRDpZFHSunFD2.jpg'],
    ),
    RemoteMovieList(
      id: 7,
      name: 'Sci-Fi Essentials',
      creator: 'Alex Rivera',
      description: 'Must-watch science fiction from across the decades. From space operas to dystopian futures, these films explore what it means to be human. This collection traces the evolution of the genre from the golden age of practical effects to the modern era of photorealistic CGI, but what ties every entry together is the power of ideas. Whether it is a quiet contemplation of artificial intelligence, a sprawling interstellar adventure, or a claustrophobic survival horror set on a derelict spaceship, each film uses speculative premises to ask profound questions about identity, technology, and our place in the universe.',
      movieCount: 22,
      posterPaths: ['/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg', '/gPbM0MK8CP8A174kI2PGjGVdWHN.jpg', '/8b8R8l88Qje9dn9OE8PY05Nez7C.jpg', '/d5NXSklXo0qyIYkgV94XAgMIckC.jpg', '/vpnVM9B6NMmQpWeZvzLbVd9dTSA.jpg'],
    ),
    RemoteMovieList(
      id: 8,
      name: 'Date Night Picks',
      creator: 'Olivia Hart',
      description: 'Romantic and fun movies for two. Whether you\'re in the mood for a sweeping romance or a quirky comedy, these films set the perfect tone.',
      movieCount: 16,
      posterPaths: ['/vpnVM9B6NMmQpWeZvzLbVd9dTSA.jpg', '/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg', '/qJ2tW6WMUDux911BTUgDYCrmpGe.jpg'],
    ),
    RemoteMovieList(
      id: 9,
      name: 'Comfort Rewatches',
      creator: 'Ben Torres',
      description: 'Movies worth watching again and again. The cinematic equivalent of comfort food — films you return to like old friends. There is something deeply satisfying about revisiting a movie you already love: you notice new details in the cinematography, catch subtle foreshadowing you missed before, and rediscover why certain scenes moved you in the first place. This list is full of films that reward repeat viewings, from endlessly quotable comedies to epic adventures that feel just as thrilling the tenth time around.',
      movieCount: 20,
      posterPaths: ['/d5NXSklXo0qyIYkgV94XAgMIckC.jpg', '/8b8R8l88Qje9dn9OE8PY05Nez7C.jpg', '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg', '/7WsyChQLEftFiDhRDpZFHSunFD2.jpg', '/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg', '/gPbM0MK8CP8A174kI2PGjGVdWHN.jpg'],
    ),
    RemoteMovieList(
      id: 10,
      name: 'Award Season Contenders',
      creator: 'Priya Sharma',
      description: 'This year\'s Oscar hopefuls. The most talked-about performances, directing achievements, and screenplays competing for gold.',
      movieCount: 14,
      posterPaths: ['/7WsyChQLEftFiDhRDpZFHSunFD2.jpg', '/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg', '/gPbM0MK8CP8A174kI2PGjGVdWHN.jpg', '/8b8R8l88Qje9dn9OE8PY05Nez7C.jpg'],
    ),
  ];

  static const _mockedListMovies = [
    RemoteMovie(id: 693134, title: 'Dune: Part Two', overview: 'Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen.', posterPath: '/8b8R8l88Qje9dn9OE8PY05Nez7C.jpg', backdropPath: '/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg', voteAverage: 8.2, releaseDate: '2024-02-27'),
    RemoteMovie(id: 872585, title: 'Oppenheimer', overview: 'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb.', posterPath: '/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg', backdropPath: '/fm6KqXpk3M2HVveHwCrBSSBaO0V.jpg', voteAverage: 8.1, releaseDate: '2023-07-19'),
    RemoteMovie(id: 792307, title: 'Poor Things', overview: 'Brought back to life by an unorthodox scientist, a young woman runs off with a debauched lawyer.', posterPath: '/kCGlIMHnOm8JPXq3rXM6c5wMxcT.jpg', backdropPath: '/bQS43HSLZzMjZkcHJz4fGc9fgrt.jpg', voteAverage: 7.9, releaseDate: '2023-12-07'),
    RemoteMovie(id: 929590, title: 'The Zone of Interest', overview: 'The commandant of Auschwitz and his wife strive to build a dream life beside the camp.', posterPath: '/hUu9zyZmDd8VZegKi1iK1Vk0RYS.jpg', backdropPath: '/geLtY6DGe2d7wkNYfsDhMGSlVQ2.jpg', voteAverage: 7.4, releaseDate: '2023-12-15'),
    RemoteMovie(id: 976573, title: 'Past Lives', overview: 'Two childhood friends are reunited in New York after decades apart.', posterPath: '/k3waqVXSnvCDWnTYDx4gT4LjESh.jpg', backdropPath: '/5wDLhJp4oIwwLDxewlMQXpZ3Mfd.jpg', voteAverage: 7.8, releaseDate: '2023-06-02'),
    RemoteMovie(id: 840430, title: 'The Holdovers', overview: 'A curmudgeonly instructor at a prep school is forced to babysit a student over Christmas break.', posterPath: '/VHSzNBTwxV8vh7wylo7O9CLdac.jpg', backdropPath: '/rz8GGX5Id2hCW1PzgCY8HNONnBl.jpg', voteAverage: 7.9, releaseDate: '2023-10-27'),
    RemoteMovie(id: 346698, title: 'Barbie', overview: 'Barbie and Ken are having the time of their lives in the colorful and seemingly perfect world of Barbie Land.', posterPath: '/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg', backdropPath: '/nHf61UzkfFno5X1ofIhugCPus2R.jpg', voteAverage: 7.0, releaseDate: '2023-07-19'),
    RemoteMovie(id: 866398, title: 'The Brutalist', overview: 'A visionary architect escapes the horrors of post-war Europe for the promise of America.', posterPath: '/gPbM0MK8CP8A174kI2PGjGVdWHN.jpg', backdropPath: '/6DYFBb8Rf3Z7OqBCqtdzgFbEpxR.jpg', voteAverage: 7.6, releaseDate: '2024-12-20'),
    RemoteMovie(id: 1064028, title: 'Anora', overview: 'A young sex worker from Brooklyn gets her chance at a Cinderella story.', posterPath: '/d5NXSklXo0qyIYkgV94XAgMIckC.jpg', backdropPath: '/4cp40IyTpFfsT2IKpl0YlUkMBIR.jpg', voteAverage: 7.5, releaseDate: '2024-10-18'),
    RemoteMovie(id: 913209, title: 'Anatomy of a Fall', overview: 'A woman is suspected of her husband\'s murder, and their blind son faces a moral dilemma.', posterPath: '/kQs6gmBuYM2v7MuqGfnlAMFYasA.jpg', backdropPath: '/7uv7PsMbSEgTBkYQce9N0m2Gsps.jpg', voteAverage: 7.7, releaseDate: '2023-08-23'),
    RemoteMovie(id: 507089, title: 'Five Nights at Freddy\'s', overview: 'A troubled security guard begins working at Freddy Fazbear\'s Pizza.', posterPath: '/7WsyChQLEftFiDhRDpZFHSunFD2.jpg', backdropPath: '/t5zCBSB5xMDKcDqe91qahCOUYVV.jpg', voteAverage: 7.0, releaseDate: '2023-10-25'),
    RemoteMovie(id: 609681, title: 'The Beekeeper', overview: 'One man\'s brutal campaign for vengeance takes on national stakes.', posterPath: '/A7EByudX0eOzlkQ2FEBabMP1hTp.jpg', backdropPath: '/cedbbhXosPuEfkrq8cjWcnKFnjK.jpg', voteAverage: 7.1, releaseDate: '2024-01-08'),
    RemoteMovie(id: 940551, title: 'Migration', overview: 'A family of ducks try to convince their overprotective father to go on the vacation of a lifetime.', posterPath: '/ldfCF9RhR40l1UkalFtyBDeJtAC.jpg', backdropPath: '/2KGxQFV9Wp1MshPBf8BuqWUgVAz.jpg', voteAverage: 7.4, releaseDate: '2023-12-22'),
    RemoteMovie(id: 753342, title: 'Napoleon', overview: 'An epic that details the checkered rise and fall of French Emperor Napoleon Bonaparte.', posterPath: '/vcZWJGvB5xydWuMm3sBBALbYDgJ.jpg', backdropPath: '/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg', voteAverage: 6.5, releaseDate: '2023-11-22'),
    RemoteMovie(id: 558449, title: 'Animal', overview: 'The son of a wealthy family confronts his father\'s enemies with explosive consequences.', posterPath: '/hr9rEgnCnJZgpFhYKeCnoMRhGeY.jpg', backdropPath: '/ekRbpPVwfXHwRqVMPqxGa5A44mU.jpg', voteAverage: 6.8, releaseDate: '2023-12-01'),
    RemoteMovie(id: 848538, title: 'Argylle', overview: 'When the plots of a spy novelist begin to mirror real-life events, she is thrust into the world of espionage.', posterPath: '/95VlSEfLMqeX36UVcHafYMYmfnG.jpg', backdropPath: '/6lE2e6j8qbtQR8aHxQNJlUxpGGO.jpg', voteAverage: 6.1, releaseDate: '2024-01-31'),
    RemoteMovie(id: 763215, title: 'Damsel', overview: 'A young woman agrees to marry a prince, only to discover that the royal family has recruited her as a sacrifice.', posterPath: '/sMp34cNKjIb18UBOCoAv4DpCkQY.jpg', backdropPath: '/hzxGaOap8Kz3wLDqzVsVPT50yAw.jpg', voteAverage: 7.1, releaseDate: '2024-03-08'),
    RemoteMovie(id: 634492, title: 'Madame Web', overview: 'Cassandra Webb develops the power to see the future and must protect three young women from a deadly threat.', posterPath: '/rULWuutDcN5NvtiZi4FRPzRYWSh.jpg', backdropPath: '/4woSOUD0equAYzvwhWBHIJDCM88.jpg', voteAverage: 5.6, releaseDate: '2024-02-14'),
    RemoteMovie(id: 1011985, title: 'Kung Fu Panda 4', overview: 'Po must train a new warrior when he is chosen to become the Spiritual Leader of the Valley of Peace.', posterPath: '/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg', backdropPath: '/hF8MqFJ9eTRFRkJFqpjhgqPsCeC.jpg', voteAverage: 7.0, releaseDate: '2024-03-08'),
    RemoteMovie(id: 823464, title: 'Godzilla x Kong: The New Empire', overview: 'Two ancient titans, Godzilla and Kong, clash in an epic battle as humans unravel their origins.', posterPath: '/z1p34vh7dEOnLDmyCrlUVLuoDzd.jpg', backdropPath: '/xRd1eJIDe7JHO5u4gtEYwGn5wtf.jpg', voteAverage: 7.2, releaseDate: '2024-03-27'),
    RemoteMovie(id: 929590, title: 'Civil War', overview: 'A journey across a dystopian future America following a team of military-embedded journalists.', posterPath: '/sh7Rg8Er3tFcN9BpKIPOMvALgZd.jpg', backdropPath: '/z121dSTR7PY9KxKuvwiIFSYW8cf.jpg', voteAverage: 7.0, releaseDate: '2024-04-11'),
    RemoteMovie(id: 1096197, title: 'No Way Up', overview: 'Characters trapped in an underwater plane wreckage must fight for survival as sharks close in.', posterPath: '/hu40Iq2mShFNXRq1X2m1eTzqmJa.jpg', backdropPath: '/4woSOUD0equAYzvwhWBHIJDCM88.jpg', voteAverage: 6.3, releaseDate: '2024-01-18'),
    RemoteMovie(id: 786892, title: 'Furiosa: A Mad Max Saga', overview: 'The origin story of the mighty warrior Furiosa before she joined forces with Mad Max.', posterPath: '/iADOJ8Zymht2JPMoy3R7xceZprc.jpg', backdropPath: '/shrwC6U8Bkst9V9IKPmGMof8aS5.jpg', voteAverage: 7.6, releaseDate: '2024-05-22'),
    RemoteMovie(id: 1022789, title: 'Inside Out 2', overview: 'A new set of emotions join Riley\'s mind as she enters her teenage years.', posterPath: '/vpnVM9B6NMmQpWeZvzLbVd9dTSA.jpg', backdropPath: '/xg27NrXi7VXCGUr7MN75UqLl6Vg.jpg', voteAverage: 7.6, releaseDate: '2024-06-11'),
    RemoteMovie(id: 945961, title: 'Alien: Romulus', overview: 'A group of young space colonists come face to face with the most terrifying life form in the universe.', posterPath: '/b33nnKl1GSFbao4l3fZDDqsMail.jpg', backdropPath: '/9SSEUrSqhljBMzRe4aBTh17wUjd.jpg', voteAverage: 7.2, releaseDate: '2024-08-14'),
    RemoteMovie(id: 533535, title: 'Deadpool & Wolverine', overview: 'Deadpool is offered a place in the Marvel Cinematic Universe by the TVA.', posterPath: '/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg', backdropPath: '/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg', voteAverage: 7.7, releaseDate: '2024-07-24'),
    RemoteMovie(id: 573435, title: 'Bad Boys: Ride or Die', overview: 'Miami detectives Mike and Marcus uncover a conspiracy involving their late captain.', posterPath: '/nP6RliHjxsz4irTKsxe8FRhKZYl.jpg', backdropPath: '/tncbMvfV0V07UZozXdBEfKTvCe2.jpg', voteAverage: 7.4, releaseDate: '2024-06-05'),
    RemoteMovie(id: 653346, title: 'Kingdom of the Planet of the Apes', overview: 'Generations after Caesar, a young ape embarks on a journey that will determine the future of both apes and humans.', posterPath: '/gKkl37BQuKTanygYQG1pyYgLVgf.jpg', backdropPath: '/fqv8v6AycXKsivp1T5yKtLbGXce.jpg', voteAverage: 7.1, releaseDate: '2024-05-08'),
  ];

  static const _mockedListTags = {
    1: ['cozy', 'weekend', 'feel-good', 'family'],
    2: ['thriller', 'mind-bending', 'suspense', 'twist'],
    3: ['classic', 'feel-good', 'comfort', 'rom-com'],
    4: ['foreign', 'subtitles', 'world-cinema', 'festival'],
    5: ['auteur', 'masterpiece', 'cinema-history'],
    6: ['underrated', '2024', 'hidden-gem'],
    7: ['sci-fi', 'space', 'dystopia', 'future'],
    8: ['romance', 'date-night', 'comedy'],
    9: ['rewatch', 'comfort', 'nostalgia', 'all-time'],
    10: ['awards', 'oscar', 'best-picture', 'performance'],
  };

  static const int _pageSize = 4;
  static const int _listDetailPageSize = 6;

  @override
  Future<Result<RemoteTrendingMovieListing>> getTrendingMovieList({
    required int page,
  }) async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      'trending/movie/week',
      queryParams: {'page': page},
    );

    return switch (result) {
      Success<Map<String, dynamic>>(:final data) =>
        Success(RemoteTrendingMovieListing.fromJson(data)),
      Failure<Map<String, dynamic>>(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<RemoteMovieDetail>> getMovieDetail({
    required int movieId,
  }) async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      'movie/$movieId',
    );

    return switch (result) {
      Success<Map<String, dynamic>>(:final data) =>
        Success(RemoteMovieDetail.fromJson(data)),
      Failure<Map<String, dynamic>>(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<RemoteMovieReviewListing>> getMovieReviews({
    required int page,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final totalPages = (_mockedReviews.length / _pageSize).ceil();
    final startIndex = (page - 1) * _pageSize;
    final endIndex = startIndex + _pageSize;
    final pageReviews = _mockedReviews.sublist(
      startIndex.clamp(0, _mockedReviews.length),
      endIndex.clamp(0, _mockedReviews.length),
    );

    return Success(RemoteMovieReviewListing(
      totalPages: totalPages,
      totalResults: _mockedReviews.length,
      reviews: pageReviews,
    ));
  }

  @override
  Future<Result<RemoteMovieCollectionListing>> getMovieCollections({
    required int page,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final totalPages = (_mockedCollections.length / _pageSize).ceil();
    final startIndex = (page - 1) * _pageSize;
    final endIndex = startIndex + _pageSize;
    final pageCollections = _mockedCollections.sublist(
      startIndex.clamp(0, _mockedCollections.length),
      endIndex.clamp(0, _mockedCollections.length),
    );

    return Success(RemoteMovieCollectionListing(
      totalPages: totalPages,
      totalResults: _mockedCollections.length,
      collections: pageCollections,
    ));
  }

  @override
  Future<Result<RemoteMovieListListing>> getMovieLists({
    required int page,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final totalPages = (_mockedLists.length / _pageSize).ceil();
    final startIndex = (page - 1) * _pageSize;
    final endIndex = startIndex + _pageSize;
    final pageLists = _mockedLists.sublist(
      startIndex.clamp(0, _mockedLists.length),
      endIndex.clamp(0, _mockedLists.length),
    );

    return Success(RemoteMovieListListing(
      totalPages: totalPages,
      totalResults: _mockedLists.length,
      lists: pageLists,
    ));
  }

  @override
  Future<Result<RemoteMovieListDetail>> getMovieListDetail({
    required int listId,
    required int page,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final list = _mockedLists.firstWhere(
      (l) => l.id == listId,
      orElse: () => _mockedLists.first,
    );

    final totalPages = (_mockedListMovies.length / _listDetailPageSize).ceil();
    final startIndex = (page - 1) * _listDetailPageSize;
    final endIndex = startIndex + _listDetailPageSize;
    final pageMovies = _mockedListMovies.sublist(
      startIndex.clamp(0, _mockedListMovies.length),
      endIndex.clamp(0, _mockedListMovies.length),
    );

    return Success(RemoteMovieListDetail(
      id: list.id,
      name: list.name,
      creator: list.creator,
      description: list.description,
      movies: pageMovies,
      totalMovies: _mockedListMovies.length,
      totalPages: totalPages,
      commentsCount: (listId * 7 + 3) % 50,
      likesCount: (listId * 13 + 11) % 200,
      isLiked: listId % 3 == 0,
      tags: _mockedListTags[listId] ?? ['movies'],
    ));
  }

  @override
  Future<Result<RemoteTrendingMovieListing>> searchMovies({
    required String query,
    required int page,
  }) async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      'search/movie',
      queryParams: {'query': query, 'page': page},
    );

    return switch (result) {
      Success<Map<String, dynamic>>(:final data) =>
        Success(RemoteTrendingMovieListing.fromJson(data)),
      Failure<Map<String, dynamic>>(:final error) => Failure(error),
    };
  }
}
