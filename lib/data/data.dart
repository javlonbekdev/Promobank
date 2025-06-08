class UnboardingContent {
  String image;
  String title;
  String description;
  UnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<UnboardingContent> unboardingContents = [
  UnboardingContent(
    image: 'assets/images/one.json',
    title: 'Assalomu alaykum',
    description: 'Ilovamizning qulay va foydali imkoniyatlarini kashf eting.',
  ),
  UnboardingContent(
    image: 'assets/images/two.json',
    title: 'Bogʻlanish oson',
    description: 'Do‘stlaringiz va yaqinlaringiz bilan osongina aloqada bo‘ling.',
  ),
  UnboardingContent(
    image: 'assets/images/three.json',
    title: 'Yangi narsalarni kashf qiling',
    description: 'Qiziqishlaringizga mos yangi mashg‘ulotlarni toping.',
  ),
  UnboardingContent(
    image: 'assets/images/four.json',
    title: 'Yana ko‘proq imkoniyatlar',
    description: 'Ilova orqali hayotingizni yanada qiziqarli qiling.',
  ),
];