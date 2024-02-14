import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voco/controller/controller.dart';
import 'package:voco/screens/login.dart';
import 'package:voco/widgets/centered_button.dart';
import 'package:voco/widgets/loading_widget.dart';

final controller = ChangeNotifierProvider((ref) => Controller());

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(controller).getData();
  }

  final _appbarTitle = "Anasayfa";
  final _exitButton = "Çıkış Yap";

  @override
  Widget build(BuildContext context) {
    var read = ref.read(controller);
    var watch = ref.read(controller);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(_appbarTitle),
      ),
      body: LoadingWidget(
        isLoading: watch.isLoading ?? true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20) +
              const EdgeInsets.symmetric(vertical: 5),
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(watch.users[index]!.avatar!),
                        radius: 20,
                      ),
                      title: Text(
                        "${watch.users[index]?.firstName ?? ""} ${watch.users[index]?.lastName ?? ""} ",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      subtitle: Text(
                        "${watch.users[index]?.email ?? ""} ",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemCount: watch.users.length),
            const Spacer(),
            CenteredButton(
                onPress: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setInt('userStatus', 0);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );
                },
                text: _exitButton),
                const SizedBox(height: 50,)
          ]),
        ),
      ),
    );
  }
}
