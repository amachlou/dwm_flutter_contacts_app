import 'package:dwm_flutter_contact_app/bloc/contact/contacts.actions.dart';
import 'package:dwm_flutter_contact_app/bloc/contact/contacts.bloc.dart';
import 'package:dwm_flutter_contact_app/bloc/contact/contacts.state.dart';
import 'package:dwm_flutter_contact_app/bloc/message/message.bloc.dart';
import 'package:dwm_flutter_contact_app/bloc/message/message.state.dart';
import 'package:dwm_flutter_contact_app/enums/request.state.bloc.dart';
import 'package:dwm_flutter_contact_app/repositories/contacts.repository.dart';
import 'package:dwm_flutter_contact_app/repositories/messages.repository.dart';
import 'package:dwm_flutter_contact_app/ui/pages/contacts/contacts.page.dart';
import 'package:dwm_flutter_contact_app/ui/pages/messages/messages.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main(){
  GetIt.instance.registerLazySingleton(() => new ContactsRepository());
  GetIt.instance.registerLazySingleton(() => new MessageRepository());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ContactsBloc(
        // required this.contacts,required this.requestState, required this.errorMessage, required this.currentEvent
          initialState: ContactsState(
              contacts: [], errorMessage: '', requestState: RequestState.NONE, currentEvent: new LoadStudentsEvent()
          ),
          contactsRepository: GetIt.instance<ContactsRepository>(),),),
        BlocProvider(create: (context) => MessageBloc(initialeState: MessageState.initialeState(), messageRepository: GetIt.instance<MessageRepository>()))
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.cyan),
        routes: {
          '/contacts': (context) => ContactPage(),
          '/messages': (context) => MessagesPage()
        },
        initialRoute: '/contacts',
      ),
    );
  }
}
