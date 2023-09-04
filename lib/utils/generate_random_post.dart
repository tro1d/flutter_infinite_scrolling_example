import 'dart:math';

import 'package:infinite_scrolling_example/models/post.dart';

class HiImFay {
  // :)

  final listString = [
    'Link: https://github.com/tro1d\nAlternative link: https://flutter.dev\n\nEmail: helloword@email.com\nPhone: 0808080889',
    'When compiling to JavaScript, https://linkdemo.com/xyz integers are restricted to values that can be represented exactly by double-precision floating point values. ffourydb@gmail.com The available integer values include all integers between -2^53 and 2^53, and some integers with larger magnitude. https://linkdemo.com/zyx That includes some integers larger than 2^63. The behavior of the operators and methods in the [int] class therefore sometimes differs between the Dart VM and Dart code compiled to JavaScript. For example, the bitwise operators truncate their operands to 32-bit integers when compiled to JavaScript.',
    'The [textDirection] argument defaults to the ambient [Directionality], if any. If there is no ambient directionality, and a text direction is going to be necessary to disambiguate start or end values for the [crossAxisAlignment], the [textDirection] must not be null.',
    'The default growable list, as created by [], keeps an internal buffer, and grows that buffer when necessary. This guarantees that a sequence of [add] operations will each execute in amortized constant time. Setting the length directly may take time proportional to the new length, and may change the internal capacity so that a following add operation will need to immediately increase the buffer capacity. Other list implementations may have different performance behavior.',
    'Generates a non-negative random integer uniformly distributed in the range from 0, inclusive, to [max], exclusive. Implementation note: The default implementation supports [max] values between 1 and (1<<32) inclusive.',
    'When compiling to JavaScript, integers are restricted to values that can be represented exactly by double-precision floating point values. The available integer values include all integers between -2^53 and 2^53, and some integers with larger magnitude. That includes some integers larger than 2^63. The behavior of the operators and methods in the [int] class therefore sometimes differs between the Dart VM and Dart code compiled to JavaScript. For example, the bitwise operators truncate their operands to 32-bit integers when compiled to JavaScript.',
    'The optional parameter [seed] is used to initialize the internal state of the generator. The implementation of the random stream can change between releases of the library.',
    'The created list is fixed-length if [growable] is set to false.\nThe [length] must be non-negative.',
    'The [mainAxisAlignment], [mainAxisSize], [crossAxisAlignment], and [verticalDirection] arguments must not be null. If [crossAxisAlignment] is [CrossAxisAlignment.baseline], then [textBaseline] must not be null.',
    'Creates insets with symmetrical vertical and horizontal offsets.',
    'This triggers when the tap gesture wins. If the tap gesture did not win, [onTapCancel] is called instead.',
    'To use this class, make sure you add a dependency on cupertino_icons in your project\'s pubspec.yaml file. This ensures that the CupertinoIcons font is included in your application. This font is used to display the icons.',
    'Creates a fixed size box. The [width] and [height] parameters can be null to indicate that the size of the box should not be constrained in the corresponding dimension.',
    'The [textDirection] argument defaults to the ambient [Directionality], if any. If there is no ambient directionality, and a text direction is going to be necessary to determine the layout order (which is always the case unless the row has no children or only one child) or to disambiguate start or end values for the [mainAxisAlignment], the [textDirection] must not be null.',
    'This Demo\n yuhuuuuu\n i\'m hereeee\n ok\n last line\n end',
  ];

  final listName = [
    'Nina Bobo',
    'Jessica Balon Meletus',
    'Beby Pelangi Dimatamu',
    'Andi Daun Hijau',
    'Budi Kucing Hitam',
    'Aurora Malam Ini',
    'Devil Siang Nanti',
    'Alisa Besok Lusa',
    'Firefly Angle',
    'Im Stack Jr',
    'Steven Berisik Banget',
    'William Bisa Diam',
    'Lily Butuh Konsentrasi',
    'Richard Ganggu Saja',
    'Jhony Ngapain',
  ];

  List<String> listProfilePicture(int count) {
    return List.generate(count, (i) {
      final number = Random().nextInt(29) + 1;
      return 'assets/profiles/profile-$number.jpeg';
    });
  }

  List<String> listLightBoxPicture(int count) {
    return List.generate(count, (i) {
      final number = Random().nextInt(6) + 1;
      return 'assets/images/lightbox-$number.jpeg';
    });
  }

  List<Post> listPost(int count) {
    return List.generate(count, (i) {
      final imagePost = i.isOdd ? '' : 'assets/images/lightbox-${Random().nextInt(6) + 1}.jpeg';
      return Post(
        id: i,
        userName: listName[Random().nextInt(14)],
        userImage: 'assets/profiles/profile-${Random().nextInt(29) + 1}.jpeg',
        textPost: listString[Random().nextInt(14)],
        imagePost: imagePost,
        likePost: List.generate(Random().nextInt(99) + 1, (_) => 'Fay'),
        commentPost: List.generate(Random().nextInt(99) + 1, (_) => 'Fay'),
        createAt: DateTime.now().subtract(Duration(minutes: i + 1)),
      );
    });
  }
}
