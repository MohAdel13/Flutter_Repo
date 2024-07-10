import 'package:chatty/features/comment/models/comment_model.dart';
import 'package:flutter/material.dart';

class CommentItemWidget extends StatelessWidget {
  final CommentModel comment;
  const CommentItemWidget({required this.comment});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: comment.userImage != ''? NetworkImage(
                    comment.userImage!,
                  ): null,
                ),

                const SizedBox(width: 20.0,),

                Text(
                  comment.userName!,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          const SizedBox(height: 20.0,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              comment.text!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        ],
      ),
    );
  }
}
