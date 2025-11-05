import 'package:get/get.dart';
import 'package:flutter/material.dart';
class Animationcontroller  extends GetxController{
  void navigateWithCustomTransition(BuildContext context, Widget destinationPage) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start from the right
        const end = Offset.zero;       // End at the center
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation, // Fade the page as it slides
            child: child,
          ),
        );
      },
    ),
  );
}
void navigateWithFadeTransition(BuildContext context, Widget destinationPage) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation, // Fade in/out the page
          child: child,
        );
      },
    ),
  );
}
void navigateWithScaleTransition(BuildContext context, Widget destinationPage) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var scaleTween = Tween(begin: 0.0, end: 1.0);
        var scaleAnimation = animation.drive(scaleTween);

        return ScaleTransition(
          scale: scaleAnimation,
          child: child,
        );
      },
    ),
  );
}
void navigateWithSlideFromBottom(BuildContext context, Widget destinationPage) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // Start from the bottom
        const end = Offset.zero;         // End at the center
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    ),
  );
}
void navigateWithDiagonalSlide(BuildContext context, Widget destinationPage) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 1.0); // Start from bottom-left
        const end = Offset.zero;         // End at center
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    ),
  );
}
void navigateWith3DRotateScale(BuildContext context, Widget destinationPage) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var rotateTween = Tween(begin: 0.0, end: 1.0); // 3D rotation
        var scaleTween = Tween(begin: 0.8, end: 1.0);  // Scaling

        var rotateAnimation = animation.drive(rotateTween);
        var scaleAnimation = animation.drive(scaleTween);

        return ScaleTransition(
          scale: scaleAnimation,
          child: RotationTransition(
            turns: rotateAnimation,
            child: child,
          ),
        );
      },
    ),
  );
}
void navigateWithSlideAndOvershoot(BuildContext context, Widget destinationPage) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start from the right
        const end = Offset.zero;         // End at the center
        const curve = Curves.easeOutBack; // Bounce/overshoot effect

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    ),
  );
}
void navigateWithSlideLeftFadeScale(BuildContext context, Widget destinationPage) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0); // Start from the left
        const end = Offset.zero;          // End at the center
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        var scaleTween = Tween(begin: 0.8, end: 1.0);  // Scale effect
        var scaleAnimation = animation.drive(scaleTween);

        return SlideTransition(
          position: offsetAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        );
      },
    ),
  );
}
void navigateWithSmoothBounceInTop(BuildContext context, Widget destinationPage) {
  Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 600), // Adjusted for smoothness
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.2); // Start slightly higher
        const end = Offset.zero;          
        const curve = Curves.easeOutBack; // Smoother and bouncy feel

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        var fadeTween = Tween(begin: 0.0, end: 1.0); // Fade effect
        var fadeAnimation = animation.drive(CurveTween(curve: Curves.easeIn));

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: child,
          ),
        );
      },
    ),
  );
}
 void navigateWithSmoothBounceRightToLeft(BuildContext context, Widget destinationPage) {
  Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 600), // Adjusted for smoothness
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.2, 0.0); // Start from right
        const end = Offset.zero;          
        const curve = Curves.easeOutBack; // Smoother bounce effect

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        var fadeTween = Tween(begin: 0.0, end: 1.0); // Fade effect
        var fadeAnimation = animation.drive(CurveTween(curve: Curves.easeIn));

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: child,
          ),
        );
      },
    ),
  );
}
void navigateWithParallax(BuildContext context, Widget destinationPage) {
  Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var slideAnimation = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
            .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));

        var scaleAnimation = Tween<double>(begin: 1.2, end: 1.0)
            .animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

        return SlideTransition(
          position: slideAnimation,
          child: ScaleTransition(scale: scaleAnimation, child: child),
        );
      },
    ),
  );
}
void navigateWithHeroZoom(BuildContext context, Widget destinationPage) {
  Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var scaleAnimation = Tween<double>(begin: 0.9, end: 1.0)
            .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));

        var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(parent: animation, curve: Curves.easeIn));

        return ScaleTransition(
          scale: scaleAnimation,
          child: FadeTransition(opacity: fadeAnimation, child: child),
        );
      },
    ),
  );
}
void navigateWithCardModal(BuildContext context, Widget destinationPage) {
  Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var slideAnimation = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
            .animate(CurvedAnimation(parent: animation, curve: Curves.easeOutQuad));

        return SlideTransition(
          position: slideAnimation,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            child: child,
          ),
        );
      },
    ),
  );
}


}