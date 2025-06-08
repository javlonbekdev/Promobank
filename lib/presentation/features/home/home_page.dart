import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:promobank/presentation/features/home/qr_code/qr_code_page.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3c4bdc),
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.home, size: 33),
          Icon(Icons.list, size: 33),
          Icon(Icons.compare_arrows, size: 33),
          Icon(Icons.settings, size: 33),
          Icon(Icons.person_outlined, size: 33),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: IndexedStack(
        index: _page,
        children: [
          PromoListPage(),
          Center(
            child: Text("Aksiya ro'yxati", style: TextStyle(fontSize: 24)),
          ),
          QRScannerPage(),
          Center(child: Text("Sozlamalar", style: TextStyle(fontSize: 24))),
          Center(child: Text("Profil", style: TextStyle(fontSize: 24))),
        ],
      ),
    );
  }
}

class PromoListPage extends StatelessWidget {
  final List<Map<String, String>> promos = [
    {
      "title": "50% Chegirma",
      "subtitle": "Bugun yakunlanadi!",
      "image": "https://picsum.photos/id/1011/600/400",
    },
    {
      "title": "1+1 Aksiya",
      "subtitle": "Do‘stingizga ulashing!",
      "image": "https://picsum.photos/id/1012/600/400",
    },
    {
      "title": "Yangi kolleksiya",
      "subtitle": "Faqat 1 hafta davomida!",
      "image": "https://picsum.photos/id/1013/600/400",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // appBar: AppBar(
      //   title: Text("Aksiya kartalari"),
      //   backgroundColor: Colors.deepPurple,
      // ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: promos.length,
        itemBuilder: (context, index) {
          final promo = promos[index];
          return Padding(
            padding: const EdgeInsets.all(30),
            child: OpenContainer(
              transitionDuration: Duration(milliseconds: 400),
              transitionType: ContainerTransitionType.fade,
              closedElevation: 6,
              closedColor: Colors.transparent,
              closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              openBuilder: (context, _) => PromoDetailPage(promo: promo),
              closedBuilder: (context, openContainer) => GestureDetector(
                onTap: openContainer,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                      image: NetworkImage(promo['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            promo['title']!,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            promo['subtitle']!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PromoDetailPage extends StatelessWidget {
  final Map<String, String> promo;

  const PromoDetailPage({required this.promo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            promo['image']!,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
          ),
          SafeArea(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: BackButton(color: Colors.white),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          promo['title']!,
                          style: TextStyle(fontSize: 36, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          promo['subtitle']!,
                          style: TextStyle(fontSize: 20, color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 40),
                        ElevatedButton.icon(
                          icon: Icon(Icons.shopping_cart),
                          label: Text("Foydalanish"),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
