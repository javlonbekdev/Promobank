import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:promobank/data/data.dart';
import 'package:promobank/presentation/features/home/home_page.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController? _pageController;
  int _currentIndex = 0;
  double percentage = 1 / 3;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: PageView.builder(
                controller: _pageController,
                itemCount: unboardingContents.length,
                onPageChanged: (int index) {
                  if (index >= _currentIndex) {
                    setState(() {
                      _currentIndex = index;
                      percentage += 1 / 3;
                    });
                  } else {
                    setState(() {
                      _currentIndex = index;
                      percentage -= 1 / 3;
                    });
                  }
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: LottieBuilder.asset(
                              unboardingContents[index].image,
                              width: double.infinity,
                              height: 500,
                            ),
                          ),
                          Text(
                            unboardingContents[index].title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            unboardingContents[index].description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: List.generate(
                            unboardingContents.length,
                            (index) => buildDot(index, context),
                          ),
                        ),
                        const SizedBox(height: 10),
                        (_currentIndex == unboardingContents.length - 1)
                            ? SizedBox()
                            : CupertinoButton(
                                child: const Text(
                                  'O\'tkazib yuborish',
                                  style: TextStyle(color: Color(0xFF3c4bdc)),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => BottomNavbar()),
                                  );
                                },
                              ),
                      ],
                    ),
                    (_currentIndex == unboardingContents.length - 1)
                        ? PulsingStartButton()
                        : CupertinoButton(
                            onPressed: () {
                              if (_currentIndex ==
                                  unboardingContents.length - 1) {}
                              _pageController!.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 55,
                                  width: 55,
                                  child: CircularProgressIndicator(
                                    value: percentage,
                                    backgroundColor: const Color(0xDD605A5A),
                                    valueColor: AlwaysStoppedAnimation(
                                      Color(0xFF3c4bdc),
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: Icon(
                                    _currentIndex ==
                                            unboardingContents.length - 1
                                        ? Icons.backspace
                                        : Icons.arrow_forward_ios_outlined,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.only(right: 8.0),
      height: 8,
      width: _currentIndex == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentIndex == index ? const Color(0xFF3c4bdc) : Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class PulsingStartButton extends StatefulWidget {
  @override
  _PulsingStartButtonState createState() => _PulsingStartButtonState();
}

class _PulsingStartButtonState extends State<PulsingStartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat(reverse: true); // doimiy pulsatsiya

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _colorAnimation = ColorTween(
      begin: Color.fromARGB(142, 60, 76, 220),
      end: Color(0xFF3c4bdc),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomNavbar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedBuilder(
        animation: _colorAnimation,
        builder: (context, child) {
          return GestureDetector(
            onTap: _onTap,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _colorAnimation.value!.withOpacity(0.6),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Text(
                "Boshlash",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
