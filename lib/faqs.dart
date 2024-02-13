import 'package:flutter/material.dart';

class FAQsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQs',
          style: TextStyle(
            color: Color(0xFF16666B),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FAQItem(
              question: 'What triggers migraine headache?',
              answer: 'Many day-to-day things can trigger a migraine headache. Some examples are foods, soft and aerated drinks, lack of or excess exercise, certain medications, stress, too much or too little sleep, bright lights, hunger, smells, and hormones etc. the triggers are different for everybody. Hence they are encouraged to keep a headache diary.',
            ),
            SizedBox(height: 20),
            FAQItem(
              question: 'Should I note down in diary when I get headache?',
              answer: 'Patients should write down the date and time of the headache. Then they should write down the activities, which has happened 24 hours prior to that which includes all the triggers. So when next time also they get headaches they can compare the common triggers from the diary.',
            ),
            SizedBox(height: 20),
            FAQItem(
              question: 'Are any tablets responsible for headache such as birth control pills?',
              answer: 'Headaches can become more frequent in patients taking oral contraceptives. However the dose and type of hormone in the pill affects the headache. Hence patients should inform their gynecologist about migraine.',
            ),
            SizedBox(height: 20),
            FAQItem(
              question: 'Can hypnosis help in treating migraine?',
              answer: 'You need to consult and talk to your doctor about it.',
            ),
            SizedBox(height: 20),
            FAQItem(
              question: 'Can migraine be prevented?',
              answer: 'Migraine can be prevented if you identify your migraine triggers. Certain medications are advised by your doctor if your migraine attacks are too many in a month or the attacks are severe.',
            ),
            SizedBox(height: 20),
            FAQItem(
              question: 'Are there different kinds of migraines?',
              answer: 'There are two major categories of migraines. They are migraine with aura and migraine without aura. "Aura" usually includes visual symptoms like seeing lines, shapes, or flashes. You may even lose some of your vision for few minutes.',
            ),
            SizedBox(height: 20),
            FAQItem(
              question: 'How does migraine affect my life?',
              answer: 'Frequent migraine attacks can lead to loss of work and school days and can lead to poor quality of life.',
            ),
            SizedBox(height: 20),
            FAQItem(
              question: 'Should I follow any diet?',
              answer: 'Prefer fresh fruits, plenty of water, fresh green vegetables, brown rice, and fiber rich vegetables. Certain foods can trigger headaches in migraine patients. This happens in only migraine patients only. Certain things -- aged cheese, some fruits and nuts, alcohol, fermented or pickled items, and additives like nitrates and MSG -- can lead to migraines in some people. Every patient should be able to find which food item triggers his or her migraine as it is different for every individual.',
            ),
            SizedBox(height: 20),
            FAQItem(
              question: 'Is migraine more dangerous than normal headache? When should I consult a doctor?',
              answer: 'Migraine headache can be very severe and disabling and lead to absenteeism from work and school. Certain symptoms should prompt a person to consult a neurologist: a) Sudden, intense thunderbolt headache. b) A new headache that is different from any other previous headache, or an increase in frequency or intensity, or poor response to previously effective therapies. c) Headache that wakes you up at night. d) Headache, which increases on lying down coughing, sneezing or weight bearing. e) Headache accompanied by any symptoms such as: weakness; numbness or balance impairment; visual impairment; language or speech problems; vertigo; confusion; altered wakefulness; or seizures.',
            ),
            SizedBox(height: 20),
            FAQItem(
              question: 'Why do I get headache only in weekends?',
              answer: 'Usually the migraine triggers due to changed life style in weekends. Oversleeping during weekends should be avoided. If sleep is a problem seek medical help.',
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF16666B),
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            answer,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
