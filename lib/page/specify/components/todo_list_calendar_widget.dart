import 'package:flutter/material.dart';
import 'package:flutter_app_todo_app/model/todo.dart';
import 'package:flutter_app_todo_app/page/dayly/provider/todos.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TodoListCalendarWidget extends StatefulWidget {
  @override
  _TodoListCalendarWidgetState createState() => _TodoListCalendarWidgetState();
}

class _TodoListCalendarWidgetState extends State<TodoListCalendarWidget> {

  CalendarController _calendarController;

  Map<DateTime, List<dynamic>> _events = {};
  List<Todo> _data = [];
  DateTime _selectedDay = DateTime.now();

  List<dynamic> _selectedEvents = [];

  List<Widget> get _eventWidgets =>
      _selectedEvents.map((e) => events(e)).toList();

  void _onDaySelected(DateTime day, List events, List holidays) {
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
  }


  void _create(BuildContext context) {
    String _name = '';
    var content = TextField(
      style: GoogleFonts.montserrat(
          color: Color.fromRGBO(105, 105, 108, 1), fontSize: 16),
      autofocus: true,
      decoration: InputDecoration(
        labelStyle: GoogleFonts.montserrat(
            color: Color.fromRGBO(59, 57, 60, 1),
            fontSize: 18,
            fontWeight: FontWeight.normal),
        labelText: 'Workout Name',
      ),
      onChanged: (value) {
        _name = value;
      },
    );
    var btn = FlatButton(
      onPressed: () {
        // _addEvent(_name);
      },
      child: Text(
        'Save',
        style: GoogleFonts.montserrat(
          color: Color.fromRGBO(59, 57, 60, 1),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    var cancelButton = FlatButton(
      onPressed: () => Navigator.of(context).pop(false), child: Text('Cancel',
      style: GoogleFonts.montserrat(
          color: Color.fromRGBO(59, 57, 60, 1),
          fontSize: 16,
          fontWeight: FontWeight.bold
      ),),
    );
    showDialog(context: context,
        builder: (BuildContext context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: const Offset(0.0,10.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 16.0,
                    ),
                    Text('Add Event',style: GoogleFonts.montserrat(
                        color: Color.fromRGBO(59, 57, 60, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),),
                    Container(padding: EdgeInsets.all(20),child: content,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [btn,cancelButton],
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
  Widget events(var d) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
        decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Theme.of(context).dividerColor),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              d,
              style: Theme.of(context).primaryTextTheme.bodyText1,
            ),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.trashAlt,
                color: Colors.redAccent,
                size: 15,
              ),
              onPressed: () {
                // _deleteEvent(d);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget calendar() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(colors: [Colors.red[600], Colors.red[400]]),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: new Offset(0.0, 5),
            ),
          ]),
      child: TableCalendar(
        calendarStyle: CalendarStyle(
          canEventMarkersOverflow: true,
          markersColor: Colors.white,
          weekdayStyle: TextStyle(color: Colors.white),
          todayColor: Colors.white54,
          todayStyle: TextStyle(
            color: Colors.redAccent,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          selectedColor: Colors.red[900],
          outsideWeekendStyle: TextStyle(color: Colors.white60),
          outsideStyle: TextStyle(color: Colors.white60),
          weekendStyle: TextStyle(color: Colors.white),
          renderDaysOfWeek: false,
        ),
        onDaySelected: _onDaySelected,
        calendarController: _calendarController,
        events: _events,
        headerStyle: HeaderStyle(
            leftChevronIcon: Icon(
              Icons.arrow_back_ios,
              size: 15,
              color: Colors.white,
            ),
            rightChevronIcon: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Colors.white,
            ),
            titleTextStyle:
            GoogleFonts.montserrat(color: Colors.white, fontSize: 16),
            formatButtonDecoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(20),
            ),
            formatButtonTextStyle: GoogleFonts.montserrat(
              color: Colors.red,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
  Widget eventTitle() {
    if (_selectedEvents.length == 0) {
      return Container(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
        child: Text(
          'No events',
          style: TextStyle(color: Colors.white,fontSize: 20),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
      child: Text(
        "Events",
        style: TextStyle(color: Colors.white,fontSize: 20),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    // TODO: implement dispose]
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Calendar',
                  style: TextStyle(color: Colors.white,fontSize: 20),
                ),
              ],
            ),
          ),
          calendar(),
          eventTitle(),
          Column(
            children: _eventWidgets,
          ),
          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
