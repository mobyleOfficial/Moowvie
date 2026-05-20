import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:comments_data/datasources/comments_remote_data_source.dart';
import 'package:comments_data/models/comment_model.dart';

@injectable
class CommentsRemoteDataSourceImpl implements CommentsRemoteDataSource {
  // Mock comments organized by content ID
  static final Map<String, List<CommentModel>> _mockCommentsByContent = {
    'review-001': [
      CommentModel(
        id: 'comment-1',
        authorName: 'John Mitchell',
        authorAvatar: 'https://api.example.com/avatars/john-mitchell.jpg',
        content: 'This is an excellent and thoughtful review. Completely agree with your analysis of the character development.',
        createdAt: DateTime(2026, 5, 10, 14, 30),
        rating: 4.5,
      ),
      CommentModel(
        id: 'comment-2',
        authorName: 'Sarah Thompson',
        authorAvatar: 'https://api.example.com/avatars/sarah-thompson.jpg',
        content: 'Great breakdown of the cinematography. The director really showcased the landscapes beautifully.',
        createdAt: DateTime(2026, 5, 9, 10, 15),
        rating: 4.0,
      ),
      CommentModel(
        id: 'comment-3',
        authorName: 'Michael Chen',
        authorAvatar: 'https://api.example.com/avatars/michael-chen.jpg',
        content: 'I have to disagree with some of your points about the ending. Felt it was a bit rushed.',
        createdAt: DateTime(2026, 5, 8, 18, 45),
        rating: 3.0,
      ),
      CommentModel(
        id: 'comment-4',
        authorName: 'Emma Wilson',
        authorAvatar: 'https://api.example.com/avatars/emma-wilson.jpg',
        content: 'Loved the soundtrack choices throughout. Really enhanced the emotional impact of key scenes.',
        createdAt: DateTime(2026, 5, 7, 11, 20),
        rating: 5.0,
      ),
      CommentModel(
        id: 'comment-5',
        authorName: 'David Roberts',
        authorAvatar: 'https://api.example.com/avatars/david-roberts.jpg',
        content: 'The acting performances were outstanding. Each cast member brought depth to their roles.',
        createdAt: DateTime(2026, 5, 6, 9, 0),
        rating: 4.5,
      ),
      CommentModel(
        id: 'comment-6',
        authorName: 'Lisa Anderson',
        authorAvatar: 'https://api.example.com/avatars/lisa-anderson.jpg',
        content: 'Interesting perspective on the symbolism. Makes me want to rewatch it with fresh eyes.',
        createdAt: DateTime(2026, 5, 5, 15, 30),
        rating: 4.0,
      ),
      CommentModel(
        id: 'comment-7',
        authorName: 'James Martinez',
        authorAvatar: 'https://api.example.com/avatars/james-martinez.jpg',
        content: 'Very well written review. Covers all the important aspects without spoiling too much.',
        createdAt: DateTime(2026, 5, 4, 12, 45),
        rating: 4.5,
      ),
      CommentModel(
        id: 'comment-8',
        authorName: 'Rachel Green',
        authorAvatar: 'https://api.example.com/avatars/rachel-green.jpg',
        content: 'This review perfectly captures why this film is a masterpiece. Highly recommend watching it.',
        createdAt: DateTime(2026, 5, 3, 20, 10),
        rating: 5.0,
      ),
      CommentModel(
        id: 'comment-9',
        authorName: 'Christopher Lee',
        authorAvatar: 'https://api.example.com/avatars/christopher-lee.jpg',
        content: 'Great analysis of the director\'s techniques. Shows real film literacy.',
        createdAt: DateTime(2026, 5, 2, 13, 25),
        rating: 4.0,
      ),
      CommentModel(
        id: 'comment-10',
        authorName: 'Olivia Brown',
        authorAvatar: 'https://api.example.com/avatars/olivia-brown.jpg',
        content: 'Best review I\'ve read on this film. You captured the essence perfectly.',
        createdAt: DateTime(2026, 5, 1, 16, 0),
        rating: 5.0,
      ),
      CommentModel(
        id: 'comment-11',
        authorName: 'Thomas White',
        authorAvatar: 'https://api.example.com/avatars/thomas-white.jpg',
        content: 'Completely different take than mine. Your perspective is refreshing.',
        createdAt: DateTime(2026, 4, 30, 11, 35),
        rating: 3.5,
      ),
      CommentModel(
        id: 'comment-12',
        authorName: 'Victoria Garcia',
        authorAvatar: 'https://api.example.com/avatars/victoria-garcia.jpg',
        content: 'Outstanding critical thinking. This review elevated my appreciation for the film.',
        createdAt: DateTime(2026, 4, 29, 14, 20),
        rating: 4.5,
      ),
    ],
    'list-001': [
      CommentModel(
        id: 'comment-13',
        authorName: 'Andrew King',
        authorAvatar: 'https://api.example.com/avatars/andrew-king.jpg',
        content: 'Great curated selection. Discovering some hidden gems from this list.',
        createdAt: DateTime(2026, 5, 8, 10, 30),
        rating: 4.5,
      ),
      CommentModel(
        id: 'comment-14',
        authorName: 'Nicole Patel',
        authorAvatar: 'https://api.example.com/avatars/nicole-patel.jpg',
        content: 'Amazing recommendations! Already watched three of them and loved all of them.',
        createdAt: DateTime(2026, 5, 7, 18, 15),
        rating: 5.0,
      ),
      CommentModel(
        id: 'comment-15',
        authorName: 'Kevin Hayes',
        authorAvatar: 'https://api.example.com/avatars/kevin-hayes.jpg',
        content: 'Would have included a few different films, but overall solid list.',
        createdAt: DateTime(2026, 5, 6, 13, 45),
        rating: 3.5,
      ),
      CommentModel(
        id: 'comment-16',
        authorName: 'Amanda Foster',
        authorAvatar: 'https://api.example.com/avatars/amanda-foster.jpg',
        content: 'Perfect for film night with friends. Lots of variety here.',
        createdAt: DateTime(2026, 5, 5, 20, 0),
        rating: 4.0,
      ),
      CommentModel(
        id: 'comment-17',
        authorName: 'Brandon Scott',
        authorAvatar: 'https://api.example.com/avatars/brandon-scott.jpg',
        content: 'This list introduced me to some incredible indie films. Thank you!',
        createdAt: DateTime(2026, 5, 4, 15, 30),
        rating: 4.5,
      ),
      CommentModel(
        id: 'comment-18',
        authorName: 'Jessica Hart',
        authorAvatar: 'https://api.example.com/avatars/jessica-hart.jpg',
        content: 'Excellent taste in movies. Following your profile for more recommendations.',
        createdAt: DateTime(2026, 5, 3, 11, 20),
        rating: 4.5,
      ),
      CommentModel(
        id: 'comment-19',
        authorName: 'Ryan Murphy',
        authorAvatar: 'https://api.example.com/avatars/ryan-murphy.jpg',
        content: 'Surprised you included that one, but it grew on me after rewatching.',
        createdAt: DateTime(2026, 5, 2, 9, 45),
        rating: 3.5,
      ),
      CommentModel(
        id: 'comment-20',
        authorName: 'Lauren Cross',
        authorAvatar: 'https://api.example.com/avatars/lauren-cross.jpg',
        content: 'This is exactly the kind of list I was looking for. So helpful!',
        createdAt: DateTime(2026, 5, 1, 17, 10),
        rating: 4.5,
      ),
      CommentModel(
        id: 'comment-21',
        authorName: 'Marcus Bell',
        authorAvatar: 'https://api.example.com/avatars/marcus-bell.jpg',
        content: 'Great mix of classics and modern films. Very well balanced.',
        createdAt: DateTime(2026, 4, 30, 12, 25),
        rating: 4.0,
      ),
      CommentModel(
        id: 'comment-22',
        authorName: 'Megan Rivera',
        authorAvatar: 'https://api.example.com/avatars/megan-rivera.jpg',
        content: 'Already shared this with my book club. Great conversation starter.',
        createdAt: DateTime(2026, 4, 29, 14, 40),
        rating: 4.5,
      ),
      CommentModel(
        id: 'comment-23',
        authorName: 'Tyler Adams',
        authorAvatar: 'https://api.example.com/avatars/tyler-adams.jpg',
        content: 'Love how you organized this. Easy to navigate and pick what to watch.',
        createdAt: DateTime(2026, 4, 28, 19, 55),
        rating: 4.0,
      ),
      CommentModel(
        id: 'comment-24',
        authorName: 'Sophia Davis',
        authorAvatar: 'https://api.example.com/avatars/sophia-davis.jpg',
        content: 'This list has something for everyone. Definitely worth checking out.',
        createdAt: DateTime(2026, 4, 27, 10, 15),
        rating: 4.5,
      ),
    ],
    'review-002': [
      CommentModel(
        id: 'comment-25',
        authorName: 'Nathan Young',
        authorAvatar: 'https://api.example.com/avatars/nathan-young.jpg',
        content: 'Couldn\'t have said it better. This film really deserves more recognition.',
        createdAt: DateTime(2026, 5, 5, 16, 30),
        rating: 4.5,
      ),
      CommentModel(
        id: 'comment-26',
        authorName: 'Alexis Johnson',
        authorAvatar: 'https://api.example.com/avatars/alexis-johnson.jpg',
        content: 'Your analysis of the themes is spot on. Really well thought out.',
        createdAt: DateTime(2026, 5, 4, 12, 0),
        rating: 4.5,
      ),
      CommentModel(
        id: 'comment-27',
        authorName: 'Daniel Hall',
        authorAvatar: 'https://api.example.com/avatars/daniel-hall.jpg',
        content: 'Didn\'t expect to enjoy this film as much as I did. Your review convinced me to watch it.',
        createdAt: DateTime(2026, 5, 3, 20, 25),
        rating: 4.0,
      ),
      CommentModel(
        id: 'comment-28',
        authorName: 'Catherine Adams',
        authorAvatar: 'https://api.example.com/avatars/catherine-adams.jpg',
        content: 'One of the best reviews I\'ve read. Shows real passion for cinema.',
        createdAt: DateTime(2026, 5, 2, 15, 45),
        rating: 5.0,
      ),
      CommentModel(
        id: 'comment-29',
        authorName: 'Eric Powell',
        authorAvatar: 'https://api.example.com/avatars/eric-powell.jpg',
        content: 'Great job breaking down the narrative structure. Very insightful.',
        createdAt: DateTime(2026, 5, 1, 11, 10),
        rating: 4.5,
      ),
      CommentModel(
        id: 'comment-30',
        authorName: 'Monica Bennett',
        authorAvatar: 'https://api.example.com/avatars/monica-bennett.jpg',
        content: 'This film touched me deeply. Your review perfectly captures that emotional journey.',
        createdAt: DateTime(2026, 4, 30, 18, 35),
        rating: 5.0,
      ),
      CommentModel(
        id: 'comment-31',
        authorName: 'Philip Morris',
        authorAvatar: 'https://api.example.com/avatars/philip-morris.jpg',
        content: 'Excellent technical analysis. Loved learning about the cinematographic choices.',
        createdAt: DateTime(2026, 4, 29, 13, 50),
        rating: 4.0,
      ),
      CommentModel(
        id: 'comment-32',
        authorName: 'Rebecca Clarke',
        authorAvatar: 'https://api.example.com/avatars/rebecca-clarke.jpg',
        content: 'This review is a work of art itself. Beautifully written.',
        createdAt: DateTime(2026, 4, 28, 10, 20),
        rating: 4.5,
      ),
      CommentModel(
        id: 'comment-33',
        authorName: 'Steven Walker',
        authorAvatar: 'https://api.example.com/avatars/steven-walker.jpg',
        content: 'Appreciate the balanced perspective. Fair criticism of both strengths and weaknesses.',
        createdAt: DateTime(2026, 4, 27, 17, 5),
        rating: 4.0,
      ),
      CommentModel(
        id: 'comment-34',
        authorName: 'Jasmine Phillips',
        authorAvatar: 'https://api.example.com/avatars/jasmine-phillips.jpg',
        content: 'Your perspective really changed how I view this movie. Thank you for the insight!',
        createdAt: DateTime(2026, 4, 26, 14, 40),
        rating: 4.5,
      ),
      CommentModel(
        id: 'comment-35',
        authorName: 'Lucas Rodriguez',
        authorAvatar: 'https://api.example.com/avatars/lucas-rodriguez.jpg',
        content: 'Exactly what I was thinking! Great minds think alike.',
        createdAt: DateTime(2026, 4, 25, 12, 15),
        rating: 4.0,
      ),
      CommentModel(
        id: 'comment-36',
        authorName: 'Heather Taylor',
        authorAvatar: 'https://api.example.com/avatars/heather-taylor.jpg',
        content: 'This is the kind of thoughtful criticism cinema needs. Well done.',
        createdAt: DateTime(2026, 4, 24, 19, 30),
        rating: 4.5,
      ),
    ],
  };

  @override
  Future<Result<CommentsRemoteResponse>> getComments({
    required String contentId,
    required int page,
    required int pageSize,
  }) async =>
      _getCommentsForContent(contentId, page, pageSize);

  Result<CommentsRemoteResponse> _getCommentsForContent(
    String contentId,
    int page,
    int pageSize,
  ) {
    try {
      final allComments = _mockCommentsByContent[contentId] ?? [];
      final totalCount = allComments.length;
      final startIndex = page * pageSize;
      final endIndex = (startIndex + pageSize).clamp(0, totalCount);

      final paginatedComments = allComments.sublist(
        startIndex < totalCount ? startIndex : totalCount,
        endIndex,
      );

      final hasMore = endIndex < totalCount;

      return Success(
        CommentsRemoteResponse(
          comments: paginatedComments,
          totalCount: totalCount,
          hasMore: hasMore,
        ),
      );
    } catch (exception) {
      return const Failure(AppError.unknown);
    }
  }
}
