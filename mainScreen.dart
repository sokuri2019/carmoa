import 'package:carmoa/activity/carmoa_home.dart';
import 'package:carmoa/config/assist_util.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/provider/cycle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  bool isCycleCheck = true;

  @override
  Widget build(BuildContext context) {
    // WillPopScope => 뒤로가기 종료 이벤트를 처리하기 위한 위젯
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: moaHomeStart(context),
    );
  }

  Widget moaHomeStart(BuildContext context) {
    cycleLoad(context);
    return MoaHome();
  }

  // 교환주기 불러오기
  Future<void> cycleLoad(BuildContext context) async {
    final p = Provider.of<Cycle>(context, listen: false);

    int eng = await loadPreferenceInt(saveTitle: partType[0], initValue: 6000);
    int air = await loadPreferenceInt(saveTitle: partType[1], initValue: 7000);
    int wiper = await loadPreferenceInt(saveTitle: partType[2], initValue: 7000);
    int tire = await loadPreferenceInt(saveTitle: partType[3], initValue: 60000);
    int breakPad = await loadPreferenceInt(saveTitle: partType[4], initValue: 40000);
    int breakOil = await loadPreferenceInt(saveTitle: partType[5], initValue: 40000);
    int battery = await loadPreferenceInt(saveTitle: partType[6], initValue: 60000);
    int plug = await loadPreferenceInt(saveTitle: partType[7], initValue: 50000);
    int antifreeze = await loadPreferenceInt(saveTitle: partType[8], initValue: 50000);

    if (isCycleCheck) {
      isCycleCheck = false;
      p.setEng(eng);
      p.setAir(air);
      p.setWiper(wiper);
      p.setTire(tire);
      p.setBreak(breakPad);
      p.setBreakOil(breakOil);
      p.setBattery(battery);
      p.setPlug(plug);
      p.setAntifreeze(antifreeze);
    }
  }

  // 뒤로가기 버튼 종료 처리
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 4,
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.exit_to_app,
              color: Colors.indigo,
            ),
            SizedBox(width: 10),
            Text('프로그램을 종료 합니다.')
          ],
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('취소'),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('종료'),
          ),
        ],
      ),
    );
  }
}
