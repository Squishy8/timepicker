import 'package:flutter/material.dart';
import 'package:timepicker/contact_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class Persona {
  String _name;
  String _email;
  String _photo;
  String _phoneNumber;
  int? _id; //El signo de interrogación nos permite hacer que ese atributo acepte nulos
  bool _bestFriend;
  String? _sexo;
  DateTime? _fechaNacimiento;

  Persona(this._name, this._email, this._photo, this._phoneNumber, this._bestFriend);

  String get phoneNumber => _phoneNumber;

  String get photo => _photo;

  String get email => _email;

  bool get bestFriend => _bestFriend;

  DateTime? get fechaNacimiento => _fechaNacimiento;

  set fechaNacimiento(DateTime? value) {
    _fechaNacimiento = value;
  }

  set sexo(String? value) {
    _sexo = value;
  }

  String? get sexo => _sexo;

  set id(int? value) {
    _id = value;
  }

  int? get id => _id;

  set name(String value) {
    _name = value;
  }

  String get name => _name;

  set email(String value) {
    _email = value;
  }

  set photo(String value) {
    _photo = value;
  }

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  set bestFriend(bool value){
    _bestFriend = value;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Persona> lsPersonas = [];
  List<Widget> lsCards = [];
  bool loaded = false;
  bool isNew = false;

  void buildCards(BuildContext ctx){
    lsCards = [];
    int i = 1;
    Card item;
    for(Persona p in lsPersonas){
      p.id = i;
      i++;
      item = Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(p.photo),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(p.name),
                    Text(p.email),
                    Text(p.phoneNumber),
                    Text(p.fechaNacimiento == null ? "": p.fechaNacimiento.toString()),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: null, icon: Icon(Icons.place_outlined)),
                IconButton(onPressed: null, icon: Icon(Icons.mail)),
                IconButton(onPressed: (){phonePerson(p, ctx);}, icon: Icon(Icons.phone)),
                IconButton(onPressed: null, icon: Icon(Icons.delete_forever)),
                IconButton(onPressed: (){gotoContactoDetails(context, p);}, icon: Icon(Icons.edit)), //Aquí indicamos que queremos llamar al metodo goto... cuando le hagamos click a este icono
              ],
            ),
          ],
        ),
      );
      lsCards.add(item);
    }
  }

  //Esta es la parte donde se aplica lo nuevo. Sin el setState no podríamos ver el cambio aplicado
  void gotoContactoDetails(BuildContext context, Persona persona){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => ContactoDetailView(persona)
        )
    ).then((item){
      Persona p = item;
      //lsPersonas[p.id ?? 1 - 1 ] = p; //Los ?? indican que si p.id es nulo, entonces se le asigna un valor de 1 - 1
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(p.name +  ". sexo: " + (p.sexo ?? "") + ' guardado'))
      );
      setState((){
        Persona p = item;
        if(isNew){
          lsPersonas.add(p);
          isNew = false;
        }
      });
    });
  }
  //Este metodo nos permite navegar de una pantalla a otra

  void buildContacts(){
    lsPersonas = [];
    Persona item = Persona("Jhon Connor", "jconnor@empresa.com",
        "https://upload.wikimedia.org/wikipedia/en/thumb/7/7f/John_Connor_%28Terminator_Dark_Fate%29.jpg/170px-John_Connor_%28Terminator_Dark_Fate%29.jpg",
        "789988", false);
    lsPersonas.insert(lsPersonas.length, item);
    item = Persona("Marie Taylor", "mtaylor@empresa.com",
        "https://i0.wp.com/www.diarlu.com/wp-content/uploads/2019/09/rostro-mujer-adulta.jpg?resize=500%2C500&ssl=1",
        "6521757712", false);
    //lsPersonas.add(item);
    lsPersonas.insert(lsPersonas.length, item);
    item = Persona("John Doe", "johndoe@example.com",
        "https://static.vecteezy.com/system/resources/previews/001/131/187/large_2x/serious-man-portrait-real-people-high-definition-grey-background-photo.jpg",
        "6521757712", false);
    //lsPersonas.add(item);
    lsPersonas.insert(lsPersonas.length, item);
    item = Persona("Jhon Connor", "jconnor@empresa.com",
        "https://upload.wikimedia.org/wikipedia/en/thumb/7/7f/John_Connor_%28Terminator_Dark_Fate%29.jpg/170px-John_Connor_%28Terminator_Dark_Fate%29.jpg",
        "789988", false);
    lsPersonas.insert(lsPersonas.length, item);
    item = Persona("Marie Taylor", "mtaylor@empresa.com",
        "https://i0.wp.com/www.diarlu.com/wp-content/uploads/2019/09/rostro-mujer-adulta.jpg?resize=500%2C500&ssl=1",
        "6521757712", false);
    //lsPersonas.add(item);
    lsPersonas.insert(lsPersonas.length, item);
    item = Persona("John Doe", "johndoe@example.com",
        "https://static.vecteezy.com/system/resources/previews/001/131/187/large_2x/serious-man-portrait-real-people-high-definition-grey-background-photo.jpg",
        "6521757712", false);
    //lsPersonas.add(item);
    lsPersonas.insert(lsPersonas.length, item);
    item = Persona("Jhon Connor", "jconnor@empresa.com",
        "https://upload.wikimedia.org/wikipedia/en/thumb/7/7f/John_Connor_%28Terminator_Dark_Fate%29.jpg/170px-John_Connor_%28Terminator_Dark_Fate%29.jpg",
        "789988", false);
    lsPersonas.insert(lsPersonas.length, item);
    item = Persona("Marie Taylor", "mtaylor@empresa.com",
        "https://i0.wp.com/www.diarlu.com/wp-content/uploads/2019/09/rostro-mujer-adulta.jpg?resize=500%2C500&ssl=1",
        "6521757712", false);
    //lsPersonas.add(item);
    lsPersonas.insert(lsPersonas.length, item);
    item = Persona("John Doe", "johndoe@example.com",
        "https://static.vecteezy.com/system/resources/previews/001/131/187/large_2x/serious-man-portrait-real-people-high-definition-grey-background-photo.jpg",
        "6521757712", false);
    //lsPersonas.add(item);
    lsPersonas.insert(lsPersonas.length, item);
  }

  void phonePerson(Persona p, BuildContext ctx){
    ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Llamando a ' + p.name))
    );
  }

  @override
  Widget build(BuildContext context) {
    if(!loaded) {
      buildContacts();
      loaded = true;
    }
    buildCards(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: ListView(
            children: lsCards,
          )
      ),
      //Este action button nos permite agregar nuevas personas a nuestra lista
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Persona newPersona = Persona("", "", "", "", false);
          gotoContactoDetails(context, newPersona);
          isNew = true;
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
