import 'package:flutter/material.dart';
import 'package:timepicker/main.dart';

class ContactoDetailView extends StatefulWidget{
  Persona p;

  ContactoDetailView(this.p);
  @override
  State<StatefulWidget> createState(){
    return _ContactoDetailState(p);
  }
}

class _ContactoDetailState extends State<ContactoDetailView>{

  Persona persona;
  bool _obscureText = true;

  _ContactoDetailState(this.persona);

  TimeOfDay? selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime)    {
      setState(() {
        selectedTime = picked;

        if(persona.fechaNacimiento != null){
          DateTime value = persona.fechaNacimiento ?? DateTime.now();
          TimeOfDay time = selectedTime ?? TimeOfDay.now();
          persona.fechaNacimiento = new DateTime(value.year, value.month, value.day, time.hour, time.minute);
        }
      });
    }
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: persona.fechaNacimiento ?? DateTime.now(),
      firstDate: DateTime(2000), //Año mínimo para seleccionar
      lastDate: DateTime(2100), //Año máximo para seleccionar
    );
    if (picked != null && picked != persona.fechaNacimiento) {
      setState(() {
        persona.fechaNacimiento = picked;
        ScaffoldMessenger.of(context).showSnackBar(
          //Checa si la fecha de nacimiento esta en null, si es null le pone la fecha y hora dd ahorita, pero si no es null me da la fecha y hora establecida
            SnackBar(content: Text(persona.fechaNacimiento == null ? DateTime.now().toString() : persona.fechaNacimiento.toString()))
        );
      });
    }
  }

  @override
  Widget build(BuildContext contect) {
    return Scaffold(
      appBar: AppBar(
        title: Text(persona.name),
        actions: [
          IconButton(onPressed: () => _selectDate(context), icon: Icon(Icons.calendar_month)),
          IconButton(onPressed: () => _selectTime(context), icon: Icon(Icons.timer))
        ],
      ),
      body: Form(
        child: Center(
          child: Column (
            children: [
              SizedBox(
                  width: 200,
                  height: 300,
                  child: Image.network(persona.photo)
              ),
              TextFormField(
                //La propiedad obscureText nos permite recibir información que no sea visible, como contraseñas
                  obscureText: true,
                  initialValue: persona.name,
                  decoration: InputDecoration(
                    label: Text("Nombre"),
                    hintText: "Teclea el nombre de la persona",
                    //Para ver el ícono de visibilidad apagada. Cuando está en false no se ve el ojito, pero cuando está en true si se ve
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState((){
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "El nombre es obligatorio.";
                    }
                    return null;
                  },
                  onChanged: (value){
                    setState(() {
                      persona.name = value;
                    });
                  }
              ),
              Checkbox(
                value: persona.bestFriend,
                onChanged: (bool? value){
                  setState((){
                    persona.bestFriend = value ?? false;
                  });
                },
              ),
              Text(persona.name),
              Text(persona.phoneNumber),
              Text(persona.email),
              //El dropdown nos permite hacer un dropdown de los elementos, en este caso sexo
              DropdownButton<String>(
                value: persona.sexo,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurple,
                ),
                onChanged: (String? newValue) {
                  setState((){
                    persona.sexo = newValue;
                  });
                },
                items: <String>['Hombre', 'Mujer']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: (){
            Navigator.pop(context, persona);
          }
      ),

    );
  }

}