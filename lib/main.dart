import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/event_bloc.dart';
import 'bloc/bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: EventsPage(),
    );
  }
}

 class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events app"),
      ),
      body: BlocProvider(
        create: (context) => EventBloc(),
        child: EventsPageChild(),
      )
    );
  }
}

class EventsPageChild extends StatelessWidget { 
var context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    final bloc = BlocProvider.of<EventBloc>(context);
    bloc.add(GetEvents());
    return Container(child:
    BlocListener<EventBloc, EventState>(
      listener: (context, state) {
        if (state is EventInitial) {
          print("EventInitial");
        } else if (state is EventsLoading) {
          print("EventsLoading");
        } else if (state is EventsLoaded) {
          print("EventsLoaded");
        }
      },
      child: BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is EventsLoaded) {
          return RefreshIndicator(
            child: ListView.builder(
            itemCount: state.events.length,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                height: 99,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Positioned(
                      left: 5,
                      top: 9,
                      right: 0,
                      bottom: 9,
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 80,
                              height: 80,
                              child: Image.network(state.events[index].image),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 110,
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      state.events[index].getTime(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 7,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 110,
                                    margin: EdgeInsets.only(bottom: 3),
                                    child: Text(
                                      state.events[index].name,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 110,
                                    child: Text(
                                      state.events[index].place,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 110,
                                    child: Text(
                                      state.events[index].getTags(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              );
            }),
            onRefresh: _getEvents,
            );
        } else {
          return Container();
        }
        
      },
    )
    )
    );
  }
  Future<void> _getEvents() async {
    final bloc = BlocProvider.of<EventBloc>(context);
    bloc.add(GetEvents());
  }

}