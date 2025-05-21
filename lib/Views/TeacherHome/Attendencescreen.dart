import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedClass = 'All Classes';
  final List<String> _classes = [
    'All Classes',
    '12th',
    '11th',
    '10th',
    '9th',
    '8th',
    '7th',
    '6th'
  ];
  DateTime _selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  bool _showCalendar = false;

  // Sample attendance data
  final Map<String, Map<String, dynamic>> _attendanceData = {
    '2023-05-15': {
      'present': 42,
      'absent': 8,
      'leave': 5,
      'total': 55,
    },
    '2023-05-16': {
      'present': 45,
      'absent': 7,
      'leave': 3,
      'total': 55,
    },
    '2023-05-17': {
      'present': 40,
      'absent': 10,
      'leave': 5,
      'total': 55,
    },
  };

  // Sample students data
  final List<Map<String, dynamic>> _students = [
    {
      'id': 'ST-1001',
      'name': 'John Smith',
      'class': '10th',
      'rollNo': '101',
      'avatar': 'https://i.pravatar.cc/150?img=1',
      'attendance': 'present', // present, absent, leave
    },
    {
      'id': 'ST-1002',
      'name': 'Emily Johnson',
      'class': '12th',
      'rollNo': '201',
      'avatar': 'https://i.pravatar.cc/150?img=5',
      'attendance': 'present',
    },
    {
      'id': 'ST-1003',
      'name': 'Michael Brown',
      'class': '11th',
      'rollNo': '301',
      'avatar': 'https://i.pravatar.cc/150?img=3',
      'attendance': 'absent',
    },
    {
      'id': 'ST-1004',
      'name': 'Sarah Davis',
      'class': '10th',
      'rollNo': '102',
      'avatar': 'https://i.pravatar.cc/150?img=4',
      'attendance': 'present',
    },
    {
      'id': 'ST-1005',
      'name': 'David Wilson',
      'class': '9th',
      'rollNo': '401',
      'avatar': 'https://i.pravatar.cc/150?img=6',
      'attendance': 'leave',
    },
    {
      'id': 'ST-1006',
      'name': 'Jessica Taylor',
      'class': '8th',
      'rollNo': '501',
      'avatar': 'https://i.pravatar.cc/150?img=7',
      'attendance': 'present',
    },
    {
      'id': 'ST-1007',
      'name': 'Robert Martinez',
      'class': '10th',
      'rollNo': '103',
      'avatar': 'https://i.pravatar.cc/150?img=8',
      'attendance': 'present',
    },
    {
      'id': 'ST-1008',
      'name': 'Lisa Anderson',
      'class': '12th',
      'rollNo': '202',
      'avatar': 'https://i.pravatar.cc/150?img=9',
      'attendance': 'absent',
    },
    {
      'id': 'ST-1009',
      'name': 'Daniel Thomas',
      'class': '11th',
      'rollNo': '302',
      'avatar': 'https://i.pravatar.cc/150?img=10',
      'attendance': 'present',
    },
    {
      'id': 'ST-1010',
      'name': 'Jennifer White',
      'class': '9th',
      'rollNo': '402',
      'avatar': 'https://i.pravatar.cc/150?img=11',
      'attendance': 'present',
    },
  ];

  List<Map<String, dynamic>> get _filteredStudents {
    return _students.where((student) {
      final name = student['name'].toString().toLowerCase();
      final id = student['id'].toString().toLowerCase();
      final rollNo = student['rollNo'].toString().toLowerCase();
      final query = _searchController.text.toLowerCase();

      // Filter by search query
      final matchesSearch =
          name.contains(query) || id.contains(query) || rollNo.contains(query);

      // Filter by class
      final matchesClass =
          _selectedClass == 'All Classes' || student['class'] == _selectedClass;

      return matchesSearch && matchesClass;
    }).toList();
  }

  Map<String, dynamic> get _currentAttendanceSummary {
    final dateKey = DateFormat('yyyy-MM-dd').format(_selectedDate);
    return _attendanceData[dateKey] ??
        {
          'present': 0,
          'absent': 0,
          'leave': 0,
          'total': _filteredStudents.length,
        };
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateAttendance(int index, String status) {
    setState(() {
      _filteredStudents[index]['attendance'] = status;

      // Update attendance summary
      final dateKey = DateFormat('yyyy-MM-dd').format(_selectedDate);
      if (!_attendanceData.containsKey(dateKey)) {
        _attendanceData[dateKey] = {
          'present': 0,
          'absent': 0,
          'leave': 0,
          'total': _filteredStudents.length,
        };
      }

      // Recalculate attendance counts
      int present = 0;
      int absent = 0;
      int leave = 0;

      for (var student in _filteredStudents) {
        switch (student['attendance']) {
          case 'present':
            present++;
            break;
          case 'absent':
            absent++;
            break;
          case 'leave':
            leave++;
            break;
        }
      }

      _attendanceData[dateKey] = {
        'present': present,
        'absent': absent,
        'leave': leave,
        'total': _filteredStudents.length,
      };
    });
  }

  void _markAllAttendance(String status) {
    setState(() {
      for (var i = 0; i < _filteredStudents.length; i++) {
        _filteredStudents[i]['attendance'] = status;
      }

      // Update attendance summary
      final dateKey = DateFormat('yyyy-MM-dd').format(_selectedDate);
      _attendanceData[dateKey] = {
        'present': status == 'present' ? _filteredStudents.length : 0,
        'absent': status == 'absent' ? _filteredStudents.length : 0,
        'leave': status == 'leave' ? _filteredStudents.length : 0,
        'total': _filteredStudents.length,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Attendance',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=13'),
            ),
          ),
        ],
      ),
      // Wrap the body in a SafeArea to avoid system UI overlap
      body: SafeArea(
        // Use a SingleChildScrollView to handle overflow
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date selector
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showCalendar = !_showCalendar;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            DateFormat('EEEE, MMM d, yyyy').format(_selectedDate),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          _showCalendar
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // History button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showAttendanceHistoryDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.history, size: 20),
                    label: const Text('View Attendance History'),
                  ),
                ),

                // Calendar (collapsible)
                if (_showCalendar)
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TableCalendar(
                      firstDay: DateTime.utc(2023, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: _selectedDate,
                      calendarFormat: _calendarFormat,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDate, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDate = selectedDay;
                          _showCalendar = false;
                        });
                      },
                      onFormatChanged: (format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      },
                      calendarStyle: const CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Color(0xFF3B82F6),
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Color(0xFFFFC107),
                          shape: BoxShape.circle,
                        ),
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: true,
                        titleCentered: true,
                        formatButtonShowsNext: false,
                        titleTextStyle: TextStyle(fontSize: 16),
                        leftChevronMargin: EdgeInsets.zero,
                        rightChevronMargin: EdgeInsets.zero,
                        headerMargin: EdgeInsets.only(bottom: 8),
                      ),
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month',
                        CalendarFormat.week: 'Week',
                      },
                    ),
                  ),

               const SizedBox(height: 16),
// Attendance summary cards
Container(
  height: 110,
  child: ListView(
    scrollDirection: Axis.horizontal,
    children: [
      _buildAttendanceCard(
        'Present',
        _currentAttendanceSummary['present'],
        _currentAttendanceSummary['total'],
        Colors.green,
        Icons.check_circle,
      ),
      const SizedBox(width: 12),
      _buildAttendanceCard(
        'Absent',
        _currentAttendanceSummary['absent'],
        _currentAttendanceSummary['total'],
        Colors.red,
        Icons.cancel,
      ),
      const SizedBox(width: 12),
      _buildAttendanceCard(
        'Leave',
        _currentAttendanceSummary['leave'],
        _currentAttendanceSummary['total'],
        Colors.orange,
        Icons.schedule,
      ),
    ],
  ),
),

                const SizedBox(height: 16),

                // Search
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search students...',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Class filter
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedClass,
                      isExpanded: true,
                      hint: const Text('Select Class'),
                      items: _classes.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedClass = newValue!;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Mark all buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _markAllAttendance('present'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.withOpacity(0.1),
                          foregroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.check_circle, size: 18),
                        label: const Text('Mark All Present'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _markAllAttendance('absent'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.withOpacity(0.1),
                          foregroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.cancel, size: 18),
                        label: const Text('Mark All Absent'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Students list header
                const Text(
                  'Students',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 8),

                // Students list - Instead of Expanded, use a sized Container with ListView
                Container(
                  height: 350, // Fixed height for student list - adjust as needed
                  child: _filteredStudents.isEmpty
                      ? const Center(
                          child: Text(
                            'No students found',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.builder(
                          // Remove the physics to allow nested scrolling
                          physics: const ClampingScrollPhysics(),
                          itemCount: _filteredStudents.length,
                          itemBuilder: (context, index) {
                            final student = _filteredStudents[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ExpansionTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(student['avatar']),
                                ),
                                title: Text(
                                  student['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text('Roll: ${student['rollNo']}'),
                                    const SizedBox(width: 8),
                                    Text('Class: ${student['class']}'),
                                  ],
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildAttendanceButton(
                                          index,
                                          'present',
                                          'Present',
                                          Colors.green,
                                          Icons.check_circle,
                                        ),
                                        _buildAttendanceButton(
                                          index,
                                          'absent',
                                          'Absent',
                                          Colors.red,
                                          Icons.cancel,
                                        ),
                                        _buildAttendanceButton(
                                          index,
                                          'leave',
                                          'Leave',
                                          Colors.orange,
                                          Icons.schedule,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                trailing: _getAttendanceStatusIcon(student['attendance']),
                              ),
                            );
                          },
                        ),
                ),

                const SizedBox(height: 16),

                // Save button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Attendance saved successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Save Attendance',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                // Add padding at the bottom to ensure the last item is fully visible
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getAttendanceStatusIcon(String status) {
    switch (status) {
      case 'present':
        return const Icon(Icons.check_circle, color: Colors.green);
      case 'absent':
        return const Icon(Icons.cancel, color: Colors.red);
      case 'leave':
        return const Icon(Icons.schedule, color: Colors.orange);
      default:
        return const Icon(Icons.help_outline, color: Colors.grey);
    }
  }

  Widget _buildAttendanceCard(
      String title, int count, int total, Color color, IconData icon) {
    final percentage =
        total > 0 ? (count / total * 100).toStringAsFixed(1) : '0.0';

    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '$percentage% of total',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: total > 0 ? count / total : 0,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceButton(
      int index, String value, String label, Color color, IconData icon) {
    final isSelected = _filteredStudents[index]['attendance'] == value;

    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () => _updateAttendance(index, value),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? color : Colors.grey[200],
          foregroundColor: isSelected ? Colors.white : Colors.grey[700],
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        icon: Icon(icon, size: 16),
        label: Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  void _showAttendanceHistoryDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Attendance History',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Filter by month
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: 'May 2023',
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                          value: 'May 2023', child: Text('May 2023')),
                      DropdownMenuItem(
                          value: 'April 2023', child: Text('April 2023')),
                      DropdownMenuItem(
                          value: 'March 2023', child: Text('March 2023')),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // History list
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: _attendanceData.length,
                  itemBuilder: (context, index) {
                    final dateKey = _attendanceData.keys.elementAt(index);
                    final data = _attendanceData[dateKey]!;
                    final date = DateTime.parse(dateKey);
                    
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('MMM d, yyyy').format(date),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.visibility,
                                      color: Color(0xFF3B82F6), size: 20),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      _selectedDate = date;
                                    });
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _buildAttendanceCountChip(
                                  Icons.check_circle, 
                                  Colors.green, 
                                  '${data['present']}'
                                ),
                                const SizedBox(width: 8),
                                _buildAttendanceCountChip(
                                  Icons.cancel, 
                                  Colors.red, 
                                  '${data['absent']}'
                                ),
                                const SizedBox(width: 8),
                                _buildAttendanceCountChip(
                                  Icons.schedule, 
                                  Colors.orange, 
                                  '${data['leave']}'
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Export attendance logic
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Attendance exported successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Export'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceCountChip(IconData icon, Color color, String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 4),
          Text(
            count,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}