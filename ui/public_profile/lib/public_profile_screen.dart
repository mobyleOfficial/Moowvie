import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_ui/favorite_movies/favorite_movies_router.dart';
import 'package:movies_ui/movie_detail/movie_detail_router.dart';
import 'package:movies_ui/tabs/lists/movies_lists_bloc.dart';
import 'package:movies_ui/tabs/lists/movies_lists_screen.dart';
import 'package:movies_ui/watch_list/watch_list_router.dart';
import 'package:profile/profile.dart';
import 'package:public_profile/public_profile_bloc.dart';
import 'package:public_profile/public_profile_state.dart';
import 'package:public_profile/user_review/user_reviews_screen.dart';

class _MockUser {
  final String displayName;
  final String initials;
  final String bio;
  final int moviesWatched;
  final int following;
  final int followers;
  final Color avatarColor;

  const _MockUser({
    required this.displayName,
    required this.initials,
    required this.bio,
    required this.moviesWatched,
    required this.following,
    required this.followers,
    required this.avatarColor,
  });
}

const _defaultUser = _MockUser(
  displayName: 'Unknown User',
  initials: '??',
  bio: '',
  moviesWatched: 0,
  following: 0,
  followers: 0,
  avatarColor: Color(0xFFE0E0E0),
);

const _mockUsers = <String, _MockUser>{
  'Alice Martins': _MockUser(
    displayName: 'Alice Martins',
    initials: 'AM',
    bio: 'Drama & romance fan. Always crying at the cinema 🎭',
    moviesWatched: 312,
    following: 48,
    followers: 204,
    avatarColor: Color(0xFFFFD1DC),
  ),
  'Bruno Carvalho': _MockUser(
    displayName: 'Bruno Carvalho',
    initials: 'BC',
    bio: 'Horror & thriller lover. The scarier the better 🎃',
    moviesWatched: 187,
    following: 22,
    followers: 95,
    avatarColor: Color(0xFFF7E07E),
  ),
  'Camila Torres': _MockUser(
    displayName: 'Camila Torres',
    initials: 'CT',
    bio: 'Cinephile. Arthouse & world cinema devotee 🌍',
    moviesWatched: 540,
    following: 76,
    followers: 413,
    avatarColor: Color(0xFFFFD1DC),
  ),
  'Diego Ferreira': _MockUser(
    displayName: 'Diego Ferreira',
    initials: 'DF',
    bio: 'Just getting into movies. Learning every day 🎬',
    moviesWatched: 95,
    following: 14,
    followers: 32,
    avatarColor: Color(0xFFF7E07E),
  ),
  'Elena Souza': _MockUser(
    displayName: 'Elena Souza',
    initials: 'ES',
    bio: 'Sci-fi & action aficionado. Blockbusters are my thing 🚀',
    moviesWatched: 228,
    following: 33,
    followers: 167,
    avatarColor: Color(0xFFFFD1DC),
  ),
  'Felipe Lima': _MockUser(
    displayName: 'Felipe Lima',
    initials: 'FL',
    bio: 'Film critic & list maker. Check out my top 10s 📝',
    moviesWatched: 413,
    following: 58,
    followers: 340,
    avatarColor: Color(0xFFF7E07E),
  ),
  'Gabriela Nunes': _MockUser(
    displayName: 'Gabriela Nunes',
    initials: 'GN',
    bio: 'Animated films fan & aspiring director 🎨',
    moviesWatched: 76,
    following: 10,
    followers: 43,
    avatarColor: Color(0xFFFFD1DC),
  ),
  'Henrique Costa': _MockUser(
    displayName: 'Henrique Costa',
    initials: 'HC',
    bio: 'Film festival regular. Cannes, Sundance, you name it 🏆',
    moviesWatched: 601,
    following: 92,
    followers: 589,
    avatarColor: Color(0xFFF7E07E),
  ),
};


class PublicProfileScreen extends StatefulWidget {
  final PublicProfileCubit cubit;
  final String userId;
  final GetUserReviews getUserReviews;
  final MoviesListsCubit listsCubit;

  const PublicProfileScreen({
    super.key,
    required this.cubit,
    required this.userId,
    required this.getUserReviews,
    required this.listsCubit,
  });

  @override
  State<PublicProfileScreen> createState() => _PublicProfileScreenState();
}

class _PublicProfileScreenState extends State<PublicProfileScreen> {
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = _mockUsers[widget.userId] ?? _defaultUser;

    final inTabContext = TabIndexScope.find(context) != null;

    return BlocProvider.value(
      value: widget.cubit,
      child: Scaffold(
        appBar: inTabContext ? null : AppBar(title: Text(user.displayName)),
        body: BlocBuilder<PublicProfileCubit, PublicProfileState>(
          builder: (context, state) => switch (state) {
            PublicProfileLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            PublicProfileError() => Center(child: Text(state.message)),
            PublicProfileSuccess() => DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  MoovieTabBar(tabs: [
                    l10n?.profileTabProfile ?? '',
                    l10n?.profileTabReviews ?? '',
                    l10n?.profileTabLists ?? '',
                  ]),
                  Expanded(
                    child: TabBarView(
                      children: [
                        MoovieKeepAliveTab(
                          child: _ProfileInfoTab(
                            user: user,
                            userId: widget.userId,
                            isFollowing: _isFollowing,
                            onFollowToggle: () =>
                                setState(() => _isFollowing = !_isFollowing),
                          ),
                        ),
                        MoovieKeepAliveTab(
                          child: UserReviewsScreen(
                            getUserReviews: widget.getUserReviews,
                          ),
                        ),
                        MoovieKeepAliveTab(
                          child: MoviesListsScreen(
                            cubit: widget.listsCubit,
                            showPopularHeader: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          },
        ),
      ),
    );
  }
}


class _ProfileInfoTab extends StatelessWidget {
  final _MockUser user;
  final String userId;
  final bool isFollowing;
  final VoidCallback onFollowToggle;

  const _ProfileInfoTab({
    required this.user,
    required this.userId,
    required this.isFollowing,
    required this.onFollowToggle,
  });

  static const _favoriteMovies = [
    (title: 'Interstellar', id: 157336),
    (title: 'The Godfather', id: 238),
    (title: 'Parasite', id: 496243),
    (title: 'Spirited Away', id: 129),
    (title: 'The Dark Knight', id: 155),
  ];

  static const _recentActivities = [
    (action: 'Watched', movie: 'Dune: Part Two', time: '2h ago'),
    (action: 'Reviewed', movie: 'Oppenheimer', time: '1d ago'),
    (action: 'Added to watchlist', movie: 'The Brutalist', time: '2d ago'),
    (action: 'Liked review of', movie: 'Anora', time: '3d ago'),
    (action: 'Watched', movie: 'Poor Things', time: '4d ago'),
  ];

  static const _watchlist = [
    (title: 'Nosferatu', id: 426063),
    (title: 'The Substance', id: 933260),
    (title: 'A Real Pain', id: 1084199),
    (title: 'Emilia Pérez', id: 1064028),
    (title: 'Nickel Boys', id: 974453),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    final posterColors = [
      colorScheme.primaryContainer,
      colorScheme.secondaryContainer,
      colorScheme.tertiaryContainer,
      colorScheme.surfaceContainerHighest,
      colorScheme.primaryContainer,
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          Semantics(
            label: user.displayName,
            image: true,
            child: CircleAvatar(
              radius: 52,
              backgroundColor: user.avatarColor,
              child: ExcludeSemantics(
                child: Text(
                  user.initials,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            user.displayName,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.bio,
            style: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Semantics(
            label:
            '${user.moviesWatched} ${l10n?.profileMoviesWatched ?? ''}, ${user.following} ${l10n?.profileFollowing ?? ''}, ${user.followers} ${l10n?.profileFollowers ?? ''}',
            excludeSemantics: true,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ProfileStat(
                    value: '${user.moviesWatched}',
                    label: l10n?.profileMoviesWatched ?? '',
                  ),
                  VerticalDivider(
                    color: colorScheme.outlineVariant,
                    width: 1,
                  ),
                  _ProfileStat(
                    value: '${user.following}',
                    label: l10n?.profileFollowing ?? '',
                  ),
                  VerticalDivider(
                    color: colorScheme.outlineVariant,
                    width: 1,
                  ),
                  _ProfileStat(
                    value: '${user.followers}',
                    label: l10n?.profileFollowers ?? '',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onFollowToggle,
              style: isFollowing
                  ? OutlinedButton.styleFrom(
                foregroundColor: colorScheme.onSurfaceVariant,
                side: BorderSide(color: colorScheme.outlineVariant),
              )
                  : OutlinedButton.styleFrom(
                foregroundColor: colorScheme.onSecondaryContainer,
                side:
                BorderSide(color: colorScheme.onSecondaryContainer),
              ),
              child: Text(
                isFollowing ? (l10n?.profileFollowing ?? '') : (l10n?.profileFollow ?? ''),
              ),
            ),
          ),
          const SizedBox(height: 28),
          _SectionHeader(
            title: l10n?.profileFavoriteMovies ?? '',
            seeAllLabel: l10n?.profileSeeAll ?? '',
            onSeeAll: () => context.router.push(
              FavoriteMoviesRoute(
                userId: userId,
                userName: user.displayName,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _favoriteMovies.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) => Semantics(
                label: _favoriteMovies[index].title,
                button: true,
                child: InkWell(
                  onTap: () => context.router.push(
                    MovieDetailRoute(
                      movieId: _favoriteMovies[index].id,
                      movieTitle: _favoriteMovies[index].title,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: posterColors[index],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
          _SectionHeader(
            title: l10n?.profileRecentActivity ?? '',
            seeAllLabel: l10n?.profileSeeAll ?? '',
            onSeeAll: () {},
          ),
          const SizedBox(height: 12),
          ...List.generate(_recentActivities.length, (index) {
            final activity = _recentActivities[index];
            return Semantics(
              label: '${activity.action} ${activity.movie}, ${activity.time}',
              child: ExcludeSemantics(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        _activityIcon(activity.action),
                        size: 18,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                            children: [
                              TextSpan(text: '${activity.action} '),
                              TextSpan(
                                text: activity.movie,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        activity.time,
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 28),
          _SectionHeader(
            title: l10n?.profileWatchlistSection ?? '',
            seeAllLabel: l10n?.profileSeeAll ?? '',
            onSeeAll: () => context.router.push(
              WatchListRoute(
                userId: userId,
                userName: user.displayName,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _watchlist.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) => Semantics(
                label: _watchlist[index].title,
                button: true,
                child: InkWell(
                  onTap: () => context.router.push(
                    MovieDetailRoute(
                      movieId: _watchlist[index].id,
                      movieTitle: _watchlist[index].title,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: posterColors[index],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  static IconData _activityIcon(String action) => switch (action) {
    'Watched' => Icons.visibility,
    'Reviewed' => Icons.rate_review,
    'Added to watchlist' => Icons.bookmark_add,
    'Liked review of' => Icons.favorite,
    _ => Icons.movie,
  };
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String seeAllLabel;
  final VoidCallback onSeeAll;

  const _SectionHeader({
    required this.title,
    required this.seeAllLabel,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.titleSmall?.copyWith(color: colorScheme.onSurface),
        ),
        Semantics(
          button: true,
          label: '$seeAllLabel $title',
          child: GestureDetector(
            onTap: onSeeAll,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                seeAllLabel,
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          value,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSecondaryContainer,
          ),
        ),
        Text(
          label,
          style:
          textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
