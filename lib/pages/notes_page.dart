import 'package:flutter/material.dart';
import 'package:lab13/models/note_model.dart';
import '../repo/notes_repo.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage>{

 List<Note> notes = [];
  bool isLoading = false;
  final textController = TextEditingController();
 final _formKey = GlobalKey<FormState>();

 @override
 void initState(){
   super.initState();
   refreshNotes();
 }

 Future refreshNotes() async{
    setState(() {
      isLoading = true;
    });
    notes = await NotesRepo().getNotes();
    setState(() {
      isLoading = false;
    });

 }

 Future addNote() async {
   if (_formKey.currentState!.validate()) {
     final newNote = Note(
         text: textController.text,
         dateTime: DateTime.now(),
     );

     await NotesRepo().addNote(newNote);
     
     textController.clear();
     FocusScope.of(context).unfocus();
     refreshNotes();
   }
 }

 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text('Нотатки'),
       backgroundColor: Colors.deepPurple[100],
     ),
     body: Column(
       children: [
         Padding(
           padding: const EdgeInsets.all(16.0),
           child: Form(
             key: _formKey,
           child: Row(
             children: [
               Expanded(
                 child: TextFormField(
                   controller: textController,
                   decoration: const InputDecoration(
                     hintText: 'Введіть нотатку...',
                     border: OutlineInputBorder(),
                   ),
                   validator: (value){
                     if(value == null || value.isEmpty){
                       return 'Value is required';
                     }
                     return null;
                   },
                 ),
               ),

               const SizedBox(width: 10),

               ElevatedButton(
                 onPressed: addNote,
                 child: const Text('Add'),
               ),
             ],
           ),
           ),
         ),

         Expanded(
           child: isLoading
               ? Center(
             child: CircularProgressIndicator())
                 : notes.isEmpty
               ?Center(child: Text('Списoк порожній...'))
               :ListView.builder(
             itemCount: notes.length,
               itemBuilder: (context, index){
               final note = notes[index];
               return Card(
                 child: ListTile(
                   title: Text(note.text),
                     subtitle: Text(note.formatDate())
                 ),
               );
               }
           )
         ),
       ],
     ),
   );
 }
}