import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/user_session_view_model.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../locator.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  HomeViewModel homeViewModel = getIt<HomeViewModel>();
  @override
  void initState() {
    // TODO: implement initState
    homeViewModel.fetchPhotos(context);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final userPref = Provider.of<UserSessionViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Home"),
        actions: [
          InkWell(
            onTap: (){
              userPref.removeUser().then((value){
                Navigator.pushNamed(context, RoutesName.login);
              });
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 24.0),
                child: Center(child: Text(
                    "Logout",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                  ),
                ))),
          )
        ],
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (context) => homeViewModel,
        child: Consumer<HomeViewModel>(
          builder: (context, viewModel, _){
            debugPrint("on builder");
            switch (viewModel.photoList.status){
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Center(child: Text(viewModel.photoList.message.toString()));
              case Status.COMPLETED:
                return ListView.builder(
                  itemCount: viewModel.photoList.data.length,
                    itemBuilder: (context, index){
                    return Card(
                      child: ListTile(
                        leading: Image.network(viewModel.photoList.data[index].thumbnailUrl.toString()),
                        title: Text(viewModel.photoList.data[index].title.toString()),
                        subtitle: Text(viewModel.photoList.data[index].url.toString()),
                        trailing: Text(viewModel.photoList.data[index].id.toString()),
                      ),
                    );
                    });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
