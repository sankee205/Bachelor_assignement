import 'package:digitalt_application/Permanent%20services/BaseAppBar.dart';
import 'package:digitalt_application/Permanent%20services/BaseAppDrawer.dart';
import 'package:digitalt_application/Permanent%20services/BaseCarouselSlider.dart';
import 'package:digitalt_application/Permanent%20services/BaseCaseBox.dart';
import 'package:digitalt_application/Permanent%20services/BaseCaseItem.dart';
import 'package:digitalt_application/casePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/*
 * This is the main page of the flutter application and this is the window that will
 * open when you open the app. At the top it has an appbar with a drawer, then below 
 * the appbar a slider for newest/top X images, and at the end a gridview for all 
 * images in the list of items; _listItem.
 * 
 * @Sander Keedklang
 * 
 */

//creates a stateful widget
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

// this class represents a home page with a grid layout
class HomePageState extends State<HomePage> {
  //example list for the grid layout
  List<CaseItem> caseList = [
    CaseItem(
        image: 'assets/images/artikkel_1.jpg',
        title: 'Oslo gjør noen lettelser – men holder på skjenkestoppen',
        author: 'Lars Hægeland',
        publishedDate: '12.01.2021',
        description:
            'Byrådsleder Raymond Johansen viser til at smitten igjen stiger i hovedstaden. – Selv med svært strenge tiltak står vi i en situasjon der smitten stiger, sier han – og peker blant annet på utbruddet i Norges største barnehage. LES OGSÅ: Smitteutbrudd i Oslo: Stenger Norges største barnehage Når regjeringen nå har opphevet de nasjonale ring-tiltakene som hovedstaden har vært omfattet av, velger imidlertid Oslo fortsatt å holde igjen noe. De nye endringene i Oslo-reglene skal vare i to uker før det blir gjort en ny vurdering. Dette er endringene i Oslo Dette er lettelsene som nå gjøres i hovedstaden: Barn og unge opp til 19 år får igjen drive med fritidsaktiviteter både innendørs og utendørs. Lesesaler og bibliotek på universiteter og høgskoler åpner for studenter. Oslo åpner også for utendørs aktivitet og idrett for voksne, i grupper på maks 10 personer og med krav om at de må holde minst en meters avstand. Tidligere denne uken gikk videregående skoler over til gult nivå.'),
    CaseItem(
        image: 'assets/images/artikkel_2.jpg',
        title: 'TV 2 bekrefter: Stian Blipp slutter i «Senkveld»',
        author: 'Heidi Gundersen',
        publishedDate: '12.01.2021',
        description:
            'Helene Olafsen og Stian Blipp har sammen ledet «Senkveld» på TV 2 siden høsten 2018. Blipp var på det tidspunktet kjent som programleder for «Norske Talenter», «Gullruten», «Idol», «Mitt Dansecrew» og «Stian Blipp Show». Nå nærmer det seg slutten for Stian Blipp i «Senkveld». Etter denne sesongen forlater han programmet. Det bekrefter både Blipp og TV 2 overfor VG. Samtidig gleder han seg til å begynne sitt soloshow. Det er på scenen han hører hjemme, forklarer han, likevel er det nok ikke siste gang man ser Blipp på TV-skjermen. Nå er han innstilt på å lage en god «Senkveld»-sesong. – Jeg har bevisst inntatt en sånn posisjon hvor jeg skal gjøre alt jeg kan for å lage en helsikens deilig sesong seks. Ellers har jeg på en måte ikke blandet meg inn for mye, sier Blipp videre.'),
    CaseItem(
        image: 'assets/images/artikkel_3.jpg',
        title: 'Ekspertenes kritiske corona-dom: − Alvorlig bekymret',
        author: 'Ådne Husby Sadnes',
        publishedDate: '12.01.2021',
        description:
            'VG har intervjuet eksperter i helse og medisin, jus, økonomi, barneombudet og helsesjefen i hardt coronarammede Oslo. De har fått spørsmål om hva de tenker om dagens coronastrategi, hva som kan være problematisk med den og hva som er konsekvensene av dagens tiltak.Ekspertene kommer også med sine forslag til hvordan myndighetene kunne ha løst ulike utfordringer på en bedre måte.MEDISIN-EKSPERTEN:Mette Kalager, professor i medisin ved Universitetet i Oslo, mener det er fint at smittetiltakene er spisset mot områder der risikoen er størst. Det er likevel noe uklart for henne hva som er strategien nå:– Er det å redusere død, er det å redusere sykdom eller redusere smitte? Dette hører sammen, men vil kreve ulike tiltak og ha ulike konsekvenser for befolkningen. Derfor savner jeg en redegjørelse fra myndighetene der de veier fordeler av å stenge ned; for eksempel hvor mye lidelse og død har vi unngått, versus ulemper; som for eksempel hvor mye lidelse og eventuell død har vi hatt som følge av tiltakene, sier Kalager.'),
    CaseItem(
        image: 'assets/images/artikkel_4.jpg',
        title: 'Falsk informasjon',
        author: 'Synne Eggum',
        publishedDate: '12.01.2021',
        description:
            'Forfatter av innlegget hevder å komme med fakta, der mediene angivelig presenterer tøv. Stortingspolitiker Christian Tybring-Gjedde (Frp) gjenga innlegget mandag kveld. – Det er farlig at stortingsrepresentanter deler falsk informasjon, sier Marian Hussein (SV). At Tybring-Gjedde skriver at han personlig ikke kjenner detaljene i saken om den somaliske familien på syv, mener hun er til liten hjelp. – Vi kan ikke fraskrive oss ansvar og samtidig dele falsk informasjon, sier vernepleieren som er vara til Stortinget og nominert på sikker plass for SV.'),
    CaseItem(
        image: 'assets/images/artikkel_5.jpg',
        title: 'GLIMT-TRENDEN SOM BØR SKREMME ROSENBORG',
        author: 'Arilas Berg',
        publishedDate: '12.01.2021',
        description:
            'Ifølge VGs opplysninger nærmer Botheim seg en overgang til den regjerende seriemesteren etter å ha terminert kontrakten med Rosenborg mandag. 21-åringen trente onsdag formiddag for første gang med Bodø/Glimt etter å ha gjennomført den medisinske testen tirsdag. Det forhandles fortsatt om detaljer i kontrakten, men spissen forventes å signere innen kort tid.'),
    CaseItem(
        image: 'assets/images/artikkel_6.jpg',
        title: '15 tights til trening',
        author: 'Heidi Haraldsen',
        publishedDate: '12.01.2021',
        description:
            'En tights skal være behagelig, følge kroppen, gi deg full bevegelsesfrihet – i tillegg til å se fin ut. Tightsen er tross alt plagget du har på under all type trening – fra styrke til yoga. Man har alltid plass til en ny tights i treningsgarderoben, og nå som vi nærmer oss våren kan du ta en titt på nyhetene som har ankommet butikkene'),
    CaseItem(
        image: 'assets/images/artikkel_7.jpg',
        title: 'Trump raser mot McConnell: − Mutt, gretten gamp',
        author: 'Sven Arne Buggeland',
        publishedDate: '16.02.2021',
        description:
            '– Mitch er en mutt, gretten, smilløs politisk gamp. Hvis republikanske senatorer holder seg til ham, kommer de ikke til å vinne igjen, sier Trump tirsdag. McConnell – den mektigste republikaneren i Senatet – sa etter avstemningen i riksrettssaken at han mener Donald Trump er ansvarlig for hendelsene 6. januar, da opprørere stormet kongressbygningen. Like før hadde senator McConnell selv stemt for å frikjenne Trump. – Demokratene og Chuck Schumer spiller McConnell som en fele. De har aldri hatt det bedre, og de ønsker å bevare det slik, heter det i uttalelsen fra Donald Trump. Den tidligere presidenten skriver følgende om sin tidligere, nære støttespiller: – McConnells entusiasme for status quo-politikk, sammen med hans mangel på politisk innsikt, klokskap, dyktighet og personlighet, har raskt drevet ham fra majoritetsleder til minoritetsleder. Og det kommer bare til å bli verre, skriver Trump.'),
    CaseItem(
        image: 'assets/images/artikkel_1.jpg',
        title: 'Oslo gjør noen lettelser – men holder på skjenkestoppen',
        author: 'Lars Hægeland',
        publishedDate: '12.01.2021',
        description:
            'Byrådsleder Raymond Johansen viser til at smitten igjen stiger i hovedstaden. – Selv med svært strenge tiltak står vi i en situasjon der smitten stiger, sier han – og peker blant annet på utbruddet i Norges største barnehage. LES OGSÅ: Smitteutbrudd i Oslo: Stenger Norges største barnehage Når regjeringen nå har opphevet de nasjonale ring-tiltakene som hovedstaden har vært omfattet av, velger imidlertid Oslo fortsatt å holde igjen noe. De nye endringene i Oslo-reglene skal vare i to uker før det blir gjort en ny vurdering. Dette er endringene i Oslo Dette er lettelsene som nå gjøres i hovedstaden: Barn og unge opp til 19 år får igjen drive med fritidsaktiviteter både innendørs og utendørs. Lesesaler og bibliotek på universiteter og høgskoler åpner for studenter. Oslo åpner også for utendørs aktivitet og idrett for voksne, i grupper på maks 10 personer og med krav om at de må holde minst en meters avstand. Tidligere denne uken gikk videregående skoler over til gult nivå.'),
    CaseItem(
        image: 'assets/images/artikkel_2.jpg',
        title: 'TV 2 bekrefter: Stian Blipp slutter i «Senkveld»',
        author: 'Heidi Gundersen',
        publishedDate: '12.01.2021',
        description:
            'Helene Olafsen og Stian Blipp har sammen ledet «Senkveld» på TV 2 siden høsten 2018. Blipp var på det tidspunktet kjent som programleder for «Norske Talenter», «Gullruten», «Idol», «Mitt Dansecrew» og «Stian Blipp Show». Nå nærmer det seg slutten for Stian Blipp i «Senkveld». Etter denne sesongen forlater han programmet. Det bekrefter både Blipp og TV 2 overfor VG. Samtidig gleder han seg til å begynne sitt soloshow. Det er på scenen han hører hjemme, forklarer han, likevel er det nok ikke siste gang man ser Blipp på TV-skjermen. Nå er han innstilt på å lage en god «Senkveld»-sesong. – Jeg har bevisst inntatt en sånn posisjon hvor jeg skal gjøre alt jeg kan for å lage en helsikens deilig sesong seks. Ellers har jeg på en måte ikke blandet meg inn for mye, sier Blipp videre.'),
    CaseItem(
        image: 'assets/images/artikkel_3.jpg',
        title: 'Ekspertenes kritiske corona-dom: − Alvorlig bekymret',
        author: 'Ådne Husby Sadnes',
        publishedDate: '12.01.2021',
        description:
            'VG har intervjuet eksperter i helse og medisin, jus, økonomi, barneombudet og helsesjefen i hardt coronarammede Oslo. De har fått spørsmål om hva de tenker om dagens coronastrategi, hva som kan være problematisk med den og hva som er konsekvensene av dagens tiltak.Ekspertene kommer også med sine forslag til hvordan myndighetene kunne ha løst ulike utfordringer på en bedre måte.MEDISIN-EKSPERTEN:Mette Kalager, professor i medisin ved Universitetet i Oslo, mener det er fint at smittetiltakene er spisset mot områder der risikoen er størst. Det er likevel noe uklart for henne hva som er strategien nå:– Er det å redusere død, er det å redusere sykdom eller redusere smitte? Dette hører sammen, men vil kreve ulike tiltak og ha ulike konsekvenser for befolkningen. Derfor savner jeg en redegjørelse fra myndighetene der de veier fordeler av å stenge ned; for eksempel hvor mye lidelse og død har vi unngått, versus ulemper; som for eksempel hvor mye lidelse og eventuell død har vi hatt som følge av tiltakene, sier Kalager.'),
    CaseItem(
        image: 'assets/images/artikkel_4.jpg',
        title: 'Falsk informasjon',
        author: 'Synne Eggum',
        publishedDate: '12.01.2021',
        description:
            'Forfatter av innlegget hevder å komme med fakta, der mediene angivelig presenterer tøv. Stortingspolitiker Christian Tybring-Gjedde (Frp) gjenga innlegget mandag kveld. – Det er farlig at stortingsrepresentanter deler falsk informasjon, sier Marian Hussein (SV). At Tybring-Gjedde skriver at han personlig ikke kjenner detaljene i saken om den somaliske familien på syv, mener hun er til liten hjelp. – Vi kan ikke fraskrive oss ansvar og samtidig dele falsk informasjon, sier vernepleieren som er vara til Stortinget og nominert på sikker plass for SV.'),
    CaseItem(
        image: 'assets/images/artikkel_5.jpg',
        title: 'GLIMT-TRENDEN SOM BØR SKREMME ROSENBORG',
        author: 'Arilas Berg',
        publishedDate: '12.01.2021',
        description:
            'Ifølge VGs opplysninger nærmer Botheim seg en overgang til den regjerende seriemesteren etter å ha terminert kontrakten med Rosenborg mandag. 21-åringen trente onsdag formiddag for første gang med Bodø/Glimt etter å ha gjennomført den medisinske testen tirsdag. Det forhandles fortsatt om detaljer i kontrakten, men spissen forventes å signere innen kort tid.'),
    CaseItem(
        image: 'assets/images/artikkel_6.jpg',
        title: '15 tights til trening',
        author: 'Heidi Haraldsen',
        publishedDate: '12.01.2021',
        description:
            'En tights skal være behagelig, følge kroppen, gi deg full bevegelsesfrihet – i tillegg til å se fin ut. Tightsen er tross alt plagget du har på under all type trening – fra styrke til yoga. Man har alltid plass til en ny tights i treningsgarderoben, og nå som vi nærmer oss våren kan du ta en titt på nyhetene som har ankommet butikkene'),
    CaseItem(
        image: 'assets/images/artikkel_7.jpg',
        title: 'Trump raser mot McConnell: − Mutt, gretten gamp',
        author: 'Sven Arne Buggeland',
        publishedDate: '16.02.2021',
        description:
            '– Mitch er en mutt, gretten, smilløs politisk gamp. Hvis republikanske senatorer holder seg til ham, kommer de ikke til å vinne igjen, sier Trump tirsdag. McConnell – den mektigste republikaneren i Senatet – sa etter avstemningen i riksrettssaken at han mener Donald Trump er ansvarlig for hendelsene 6. januar, da opprørere stormet kongressbygningen. Like før hadde senator McConnell selv stemt for å frikjenne Trump. – Demokratene og Chuck Schumer spiller McConnell som en fele. De har aldri hatt det bedre, og de ønsker å bevare det slik, heter det i uttalelsen fra Donald Trump. Den tidligere presidenten skriver følgende om sin tidligere, nære støttespiller: – McConnells entusiasme for status quo-politikk, sammen med hans mangel på politisk innsikt, klokskap, dyktighet og personlighet, har raskt drevet ham fra majoritetsleder til minoritetsleder. Og det kommer bare til å bli verre, skriver Trump.'),
    CaseItem(
        image: 'assets/images/artikkel_8.jpg',
        title:
            '«Game of Thrones»-par har fått sitt første barn: − De er veldig lykkelige',
        author: 'Ingrid Hovda Storaas',
        publishedDate: '12.01.2021',
        description:
            'Det bekrefter Haringtons talsperson Marianna Shafran overfor nyhetsbyrået AP.– De er veldig, veldig lykkelige, sier hun – uten å røpe flere detaljer. Nyheten om fødselen ble først meldt av New York Post sin Page Six, som tirsdag publiserte et bilde av paret gående med en barnevogn i London. Rose Leslie og Kit Harrington møtte hverandre på innspillingen til HBO-serien «Game of Thrones» i 2011. På skjermen var de i et intenst kjærlighetsforhold som Ygritte og Jon Snow.'),
  ];
  List<CaseItem> sisteNyttList = [
    CaseItem(
        image: 'assets/images/artikkel_3.jpg',
        title: 'Ekspertenes kritiske corona-dom: − Alvorlig bekymret',
        author: 'Ådne Husby Sadnes',
        publishedDate: '12.01.2021',
        description:
            'VG har intervjuet eksperter i helse og medisin, jus, økonomi, barneombudet og helsesjefen i hardt coronarammede Oslo. De har fått spørsmål om hva de tenker om dagens coronastrategi, hva som kan være problematisk med den og hva som er konsekvensene av dagens tiltak.Ekspertene kommer også med sine forslag til hvordan myndighetene kunne ha løst ulike utfordringer på en bedre måte.MEDISIN-EKSPERTEN:Mette Kalager, professor i medisin ved Universitetet i Oslo, mener det er fint at smittetiltakene er spisset mot områder der risikoen er størst. Det er likevel noe uklart for henne hva som er strategien nå:– Er det å redusere død, er det å redusere sykdom eller redusere smitte? Dette hører sammen, men vil kreve ulike tiltak og ha ulike konsekvenser for befolkningen. Derfor savner jeg en redegjørelse fra myndighetene der de veier fordeler av å stenge ned; for eksempel hvor mye lidelse og død har vi unngått, versus ulemper; som for eksempel hvor mye lidelse og eventuell død har vi hatt som følge av tiltakene, sier Kalager.'),
    CaseItem(
        image: 'assets/images/artikkel_4.jpg',
        title: 'Falsk informasjon',
        author: 'Synne Eggum',
        publishedDate: '12.01.2021',
        description:
            'Forfatter av innlegget hevder å komme med fakta, der mediene angivelig presenterer tøv. Stortingspolitiker Christian Tybring-Gjedde (Frp) gjenga innlegget mandag kveld. – Det er farlig at stortingsrepresentanter deler falsk informasjon, sier Marian Hussein (SV). At Tybring-Gjedde skriver at han personlig ikke kjenner detaljene i saken om den somaliske familien på syv, mener hun er til liten hjelp. – Vi kan ikke fraskrive oss ansvar og samtidig dele falsk informasjon, sier vernepleieren som er vara til Stortinget og nominert på sikker plass for SV.'),
    CaseItem(
        image: 'assets/images/artikkel_5.jpg',
        title: 'GLIMT-TRENDEN SOM BØR SKREMME ROSENBORG',
        author: 'Arilas Berg',
        publishedDate: '12.01.2021',
        description:
            'Ifølge VGs opplysninger nærmer Botheim seg en overgang til den regjerende seriemesteren etter å ha terminert kontrakten med Rosenborg mandag. 21-åringen trente onsdag formiddag for første gang med Bodø/Glimt etter å ha gjennomført den medisinske testen tirsdag. Det forhandles fortsatt om detaljer i kontrakten, men spissen forventes å signere innen kort tid.'),
    CaseItem(
        image: 'assets/images/artikkel_6.jpg',
        title: '15 tights til trening',
        author: 'Heidi Haraldsen',
        publishedDate: '12.01.2021',
        description:
            'En tights skal være behagelig, følge kroppen, gi deg full bevegelsesfrihet – i tillegg til å se fin ut. Tightsen er tross alt plagget du har på under all type trening – fra styrke til yoga. Man har alltid plass til en ny tights i treningsgarderoben, og nå som vi nærmer oss våren kan du ta en titt på nyhetene som har ankommet butikkene'),
    CaseItem(
        image: 'assets/images/artikkel_7.jpg',
        title: 'Trump raser mot McConnell: − Mutt, gretten gamp',
        author: 'Sven Arne Buggeland',
        publishedDate: '16.02.2021',
        description:
            '– Mitch er en mutt, gretten, smilløs politisk gamp. Hvis republikanske senatorer holder seg til ham, kommer de ikke til å vinne igjen, sier Trump tirsdag. McConnell – den mektigste republikaneren i Senatet – sa etter avstemningen i riksrettssaken at han mener Donald Trump er ansvarlig for hendelsene 6. januar, da opprørere stormet kongressbygningen. Like før hadde senator McConnell selv stemt for å frikjenne Trump. – Demokratene og Chuck Schumer spiller McConnell som en fele. De har aldri hatt det bedre, og de ønsker å bevare det slik, heter det i uttalelsen fra Donald Trump. Den tidligere presidenten skriver følgende om sin tidligere, nære støttespiller: – McConnells entusiasme for status quo-politikk, sammen med hans mangel på politisk innsikt, klokskap, dyktighet og personlighet, har raskt drevet ham fra majoritetsleder til minoritetsleder. Og det kommer bare til å bli verre, skriver Trump.'),
  ];

  // example list for the carousel slider
  List<CaseItem> popularCases = [
    CaseItem(
        image: 'assets/images/artikkel_7.jpg',
        title: 'Trump raser mot McConnell: − Mutt, gretten gamp',
        author: 'Sven Arne Buggeland',
        publishedDate: '16.02.2021',
        description:
            '– Mitch er en mutt, gretten, smilløs politisk gamp. Hvis republikanske senatorer holder seg til ham, kommer de ikke til å vinne igjen, sier Trump tirsdag. McConnell – den mektigste republikaneren i Senatet – sa etter avstemningen i riksrettssaken at han mener Donald Trump er ansvarlig for hendelsene 6. januar, da opprørere stormet kongressbygningen. Like før hadde senator McConnell selv stemt for å frikjenne Trump. – Demokratene og Chuck Schumer spiller McConnell som en fele. De har aldri hatt det bedre, og de ønsker å bevare det slik, heter det i uttalelsen fra Donald Trump. Den tidligere presidenten skriver følgende om sin tidligere, nære støttespiller: – McConnells entusiasme for status quo-politikk, sammen med hans mangel på politisk innsikt, klokskap, dyktighet og personlighet, har raskt drevet ham fra majoritetsleder til minoritetsleder. Og det kommer bare til å bli verre, skriver Trump.'),
    CaseItem(
        image: 'assets/images/artikkel_8.jpg',
        title:
            '«Game of Thrones»-par har fått sitt første barn: − De er veldig lykkelige',
        author: 'Ingrid Hovda Storaas',
        publishedDate: '12.01.2021',
        description:
            'Det bekrefter Haringtons talsperson Marianna Shafran overfor nyhetsbyrået AP.– De er veldig, veldig lykkelige, sier hun – uten å røpe flere detaljer. Nyheten om fødselen ble først meldt av New York Post sin Page Six, som tirsdag publiserte et bilde av paret gående med en barnevogn i London. Rose Leslie og Kit Harrington møtte hverandre på innspillingen til HBO-serien «Game of Thrones» i 2011. På skjermen var de i et intenst kjærlighetsforhold som Ygritte og Jon Snow.'),
  ];

  @override
  Widget build(BuildContext context) {
    //returns a material design
    return Scaffold(
      //this is the appbar for the home page
      appBar: BaseAppBar(
        title: Text('DIGI-TALT'),
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.more_vert)],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        selectedItemColor: Colors.red,
      ),

      //creates the menu in the appbar(drawer)
      drawer: BaseAppDrawer(),

      //here comes the body of the home page
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade300,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.white),
                      height: 310,
                      child: ListView(
                        children: <Widget>[
                          //should we add a play and stop button?
                          BaseCarouselSlider(this.popularCases)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: 800,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Siste Nytt',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25),
                              ),
                              Column(
                                children: sisteNyttList.map((caseObject) {
                                  return Builder(builder: (
                                    BuildContext context,
                                  ) {
                                    //makes the onclick available
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CasePage(
                                                        caseItem: caseObject,
                                                      )));
                                        },
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          margin: EdgeInsets.all(1),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            caseObject.title,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontStyle: FontStyle.normal),
                                          ),
                                        ));
                                  });
                                }).toList(),
                              )
                            ]),
                      ),
                      StaggeredGridView.countBuilder(
                        primary: false,
                        crossAxisCount: 4,
                        itemCount: caseList.length,
                        itemBuilder: (BuildContext context, int index) =>
                            InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CasePage(
                                  caseItem: caseList[index],
                                ),
                              ),
                            );
                          },
                          child: BaseCaseBox(caseList[index]),
                        ),
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.count(2, index.isEven ? 2 : 1),
                        mainAxisSpacing: 6.0,
                        crossAxisSpacing: 12.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
