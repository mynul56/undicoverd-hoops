import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../pipeline/views/pipeline_screen.dart';
import '../../stories/views/widgets/stories_ribbon.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('MESSAGES', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2)),
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Color(0xFFE4FF00),
            labelColor: Color(0xFFE4FF00),
            unselectedLabelColor: Colors.white54,
            tabs: [
              Tab(text: 'INBOX'),
              Tab(text: 'PIPELINE'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _InboxView(),
            PipelineScreen(),
          ],
        ),
      ),
    );
  }
}

class _InboxView extends StatelessWidget {
  const _InboxView();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: StoriesRibbon(),
        ),
        const Divider(color: Colors.white12, height: 1),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: 5,
            separatorBuilder: (context, index) => const Divider(color: Colors.white12, height: 32),
      itemBuilder: (context, index) {
        final isUnread = index == 0;
        final userName = 'Coach Mike';
        final userImage = 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=200&auto=format&fit=crop';
        
        return ListTile(
          onTap: () {
            context.push('/chat', extra: {
              'userName': userName,
              'userImage': userImage,
            });
          },
          contentPadding: EdgeInsets.zero,
          leading: Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.grey.shade800,
                backgroundImage: NetworkImage(userImage),
              ),
              if (isUnread)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE4FF00),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          title: Text(
            userName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              'When can you hop on a call?',
              style: TextStyle(
                color: isUnread ? Colors.white : Colors.white54,
                fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '2m ago',
                style: TextStyle(
                  color: isUnread ? const Color(0xFFE4FF00) : Colors.white54,
                  fontSize: 12,
                  fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (isUnread)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE4FF00),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '1',
                    style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        );
      },
    ),
        ),
      ],
    );
  }
}
