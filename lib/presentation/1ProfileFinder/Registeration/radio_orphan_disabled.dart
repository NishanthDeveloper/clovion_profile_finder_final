import 'package:flutter/material.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/CustomClAll.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RadioOrphanAndDisabled extends StatefulWidget {
  const RadioOrphanAndDisabled({super.key});

  @override
  State<RadioOrphanAndDisabled> createState() => _RadioOrphanAndDisabledState();
}

class _RadioOrphanAndDisabledState extends State<RadioOrphanAndDisabled> {
  int? _valueOrphan; // Set initial value to null
  bool _showOrganTextField = false;
  int? _valueDisable; // Set initial value to null

  saveToSharedPrefferences(String nameOfID, String valueToSave) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(nameOfID, valueToSave);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        D10HCustomClSizedBoxWidget(),
        Text(
          "Are you an orphan?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: _valueOrphan,
                  onChanged: (value) {
                    setState(() {
                      _valueOrphan = value as int?;
                    });
                    saveToSharedPrefferences("orphan",
                        _valueOrphan == 1 ? "Yes" : "No");
                  },
                ),
                const SizedBox(width: 2),
                const Text("Yes")
              ],
            ),
            const SizedBox(width: 40),
            Row(
              children: [
                Radio(
                  value: 2,
                  groupValue: _valueOrphan,
                  onChanged: (value) {
                    setState(() {
                      _valueOrphan = value as int?;
                    });
                    saveToSharedPrefferences("orphan",
                        _valueOrphan == 2 ? "No" : "Yes");
                  },
                ),
                const SizedBox(width: 2),
                const Text("No")
              ],
            ),
          ],
        ),
        Text(
          "Are you disabled?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: _valueDisable,
                  onChanged: (value) {
                    setState(() {
                      _valueDisable = value as int?;
                      _showOrganTextField = _valueDisable == 1;
                    });
                    saveToSharedPrefferences("disable", "Yes");
                  },
                ),
                const SizedBox(width: 2),
                const Text("Yes")
              ],
            ),
            const SizedBox(width: 40),
            Row(
              children: [
                Radio(
                  value: 2,
                  groupValue: _valueDisable,
                  onChanged: (value) {
                    setState(() {
                      _valueDisable = value as int?;
                      _showOrganTextField = _valueDisable == 1;
                    });
                    saveToSharedPrefferences("disable", "No");
                  },
                ),
                const SizedBox(width: 2),
                const Text("No")
              ],
            ),
          ],
        ),
        if (_showOrganTextField)
          TextField(
            decoration: InputDecoration(
              labelText: "Which organ?",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              saveToSharedPrefferences("whichorgan", value);
            },
          ),
      ],
    );
  }
}
