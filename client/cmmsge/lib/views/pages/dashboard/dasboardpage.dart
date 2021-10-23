import 'package:cmmsge/services/models/dashboard/dashboardModel.dart';
import 'package:cmmsge/services/utils/apiService.dart';
import 'package:cmmsge/utils/ReusableClasses.dart';
import 'package:cmmsge/utils/warna.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // ! INITIALIZE VARIABLE
  ApiService _apiService = ApiService();
  late SharedPreferences sp;
  String? token = "", username = "", jabatan = "";
  var jml_masalah = "", jml_selesai = 0, belum_selesai = 0;

  // * ceking token and getting dashboard value from api
  cekToken() async {
    sp = await SharedPreferences.getInstance();
    setState(() {
      token = sp.getString("access_token");
      username = sp.getString("username");
      jabatan = sp.getString("jabatan");
    });
    _apiService.getDashboard(token!).then((value) {
      // DashboardModel dashboardModel = DashboardModel();
      print("Jumlah Masalah? " + value.toString());
      // jml_masalah = value as String.toList();
      // jml_selesai = dashboardModel.jml_selesai;
      // belum_selesai = jml_masalah - jml_selesai;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cekToken();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _apiService.client.close();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildTextHeader(screenHeight),
          _buildBanner(screenHeight),
          _buildContent(screenHeight)
        ],
      ),
    );
  }

  // * code for design text header
  SliverToBoxAdapter _buildTextHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 55, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'PT. Sinar Indogreen Kencana.',
                      style: TextStyle(fontSize: 12),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, ' +
                              username!.toUpperCase() +
                              belum_selesai.toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(GetSharedPreference().tokens)
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // * code for banner header
  SliverToBoxAdapter _buildBanner(double screenHeight) {
    return SliverToBoxAdapter(
        child: Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(color: primarycolor, height: 150, width: 200),
      ),
    ));
  }

  // * code for setting dashboard value api to ui
  SliverToBoxAdapter _buildContent(double screenHeight) {
    return SliverToBoxAdapter();
  }
}
