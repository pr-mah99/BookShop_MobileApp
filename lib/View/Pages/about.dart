import 'package:flutter/material.dart';

class about extends StatefulWidget {
  const about({Key? key}) : super(key: key);

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: const Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'نبذة عن الموقع',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'متجر الكتب (BookStore):',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'مرحبًا بك في متجر الكتب (BookStore)! نحن نفخر بتقديم تجربة تسوق فريدة لمحبي الكتب من جميع أنحاء العالم. في BookStore، نسعى جاهدين لتوفير مجموعة واسعة ومتنوعة من الكتب التي تلبي جميع الاهتمامات والأذواق. مجموعة متنوعة: تتميز مكتبتنا الافتراضية بتنوع واسع في العروض، حيث نقدم الكتب في مختلف الأنواع والمواضيع. سواء كنت تبحث عن رواية مثيرة، كتاب تعليمي، دليل سفر، كتاب تنمية شخصية، أو حتى كتب أطفال، فإننا نضمن لك أن تجد ما تبحث عنه لدينا.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'تجربة تسوق ممتعة: نحن نولي اهتمامًا كبيرًا لراحة عملائنا، ولذلك قمنا بتصميم موقعنا بطريقة سهلة الاستخدام ومستجيبة لجميع الأجهزة. يمكنك بسهولة تصفح مكتبتنا الواسعة، وقراءة استعراضات الكتب، ومشاهدة العروض الخاصة، وإتمام عملية الشراء ببضع خطوات بسيطة.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'خدمة عملاء متميزة: نحن نؤمن بأهمية تجربة العميل، ولذلك فإن فريق خدمة العملاء لدينا متاح دائمًا لمساعدتك في حال واجهتك أي مشكلة أو كانت لديك استفسارات. نحن نهتم بتلبية احتياجاتك وضمان رضاك التام.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'مبادئنا: في BookStore، نؤمن بقيم الجودة، والتنوع، والرضا العملاء. نحن نسعى جاهدين لتوفير تجربة تسوق فريدة تتيح لك اكتشاف العالم من خلال صفحات الكتب.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'انضم إلينا: نحن دائمًا في طور التحديث والتطوير، ونحن نرحب بكل محبي الكتب للانضمام إلى عائلتنا في BookStore. اكتشف معنا عوالم جديدة، وامتلك نسختك من الكتب التي تشد انتباهك. استكشف مجموعتنا اليوم واستمتع بتجربة تسوق لا مثيل لها في BookStore!',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
