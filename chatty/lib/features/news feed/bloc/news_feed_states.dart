abstract class NewsFeedStates{}

class NewsFeedInitState extends NewsFeedStates{}

class NewsFeedLoadingState extends NewsFeedStates{}

class NewsFeedSuccessState extends NewsFeedStates{}

class NewsFeedErrorState extends NewsFeedStates{}

class NewsFeedLikesAddState extends NewsFeedStates{}

class NewsFeedLikesRemoveState extends NewsFeedStates{}

class NewsFeedCommentAddLoadingState extends NewsFeedStates{}

class NewsFeedCommentAddSuccessState extends NewsFeedStates{}

class NewsFeedCommentAddErrorState extends NewsFeedStates{}

class CommentsLoadingState extends NewsFeedStates{}

class CommentsSuccessState extends NewsFeedStates{}

class CommentsErrorState extends NewsFeedStates{}

