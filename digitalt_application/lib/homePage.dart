import 'package:digitalt_application/Permanent%20services/BaseAppBar.dart';
import 'package:digitalt_application/Permanent%20services/BaseAppDrawer.dart';
import 'package:digitalt_application/Permanent%20services/BaseCarouselSlider.dart';
import 'package:digitalt_application/Permanent%20services/BaseCaseBox.dart';
import 'package:digitalt_application/Permanent%20services/BaseCaseItem.dart';
import 'package:digitalt_application/casePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_grid/responsive_grid.dart';

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
        author: [
          'LARS HÆGELAND',
          'SYNNE EGGUM MYRVANG',
          'RUNA FJELLANGER',
          'OLINE BIRGITTE NAVE',
          'ENDRE ALSAKER-NØSTDAHL'
        ],
        publishedDate: '12.01.2021',
        introduction:
            'Oslo vil åpne campus for studenter og fritidsaktiviteter for at barn og unge kan drive med fritidsaktiviteter både innendørs og utendørs. Men stengte kjøpesenter, stengte treningssentre og skjenkestopp fortsetter.',
        description: [
          'Byrådsleder Raymond Johansen viser til at smitten igjen stiger i hovedstaden.',
          '– Selv med svært strenge tiltak står vi i en situasjon der smitten stiger, sier han – og peker blant annet på utbruddet i Norges største barnehage.',
          'Når regjeringen nå har opphevet de nasjonale ring-tiltakene som hovedstaden har vært omfattet av, velger imidlertid Oslo fortsatt å holde igjen noe. De nye endringene i Oslo-reglene skal vare i to uker før det blir gjort en ny vurdering.',
          'Dette er endringene i Oslo: Dette er lettelsene som nå gjøres i hovedstaden:',
          '-Barn og unge opp til 19 år får igjen drive med fritidsaktiviteter både innendørs og utendørs.',
          '-Lesesaler og bibliotek på universiteter og høgskoler åpner for studenter.'
              '-Oslo åpner også for utendørs aktivitet og idrett for voksne, i grupper på maks 10 personer og med krav om at de må holde minst en meters avstand.',
          'Oslo kommune vil imidlertid fortsatt ha begrensninger for kjøpesenter og ha skjenkestopp. Det betyr at det bare er noen få butikker på kjøpesenter som kan holde åpent, som apotek og matbutikker. Treningssenter vil også fortsatt være stengt.',
          '– Vi tar sikte på at kjøpesenter kan åpne i løpet av de neste ukene, sier byrådslederen.',
          'Han sier at det er et voldsomt press og pågang om spesielt å åpne treningssentrene. Det er derfor det nå åpnes for at de kan ha små gruppetimer utendørs for voksne, sier Johansen.'
        ]),
    CaseItem(
        image: 'assets/images/artikkel_2.jpg',
        title: 'TV 2 bekrefter: Stian Blipp slutter i «Senkveld»',
        author: ['JØRN PETTERSEN', 'MARIA STØRE'],
        publishedDate: '12.01.2021',
        introduction:
            'Stian Blipps tid i «Senkveld» nærmer seg slutten, opplyser TV 2 og Stian Blipp selv.',
        description: [
          'Helene Olafsen og Stian Blipp har sammen ledet «Senkveld» på TV 2 siden høsten 2018. Blipp var på det tidspunktet kjent som programleder for «Norske Talenter», «Gullruten», «Idol», «Mitt Dansecrew» og «Stian Blipp Show».',
          'Nå nærmer det seg slutten for Stian Blipp i «Senkveld». Etter denne sesongen forlater han programmet. Det bekrefter både Blipp og TV 2 overfor VG.',
          '– Stian Blipp skal slutte i «Senkveld». Hva som skjer til høsten er det ikke tatt noen avgjørelse på. Men Stian er en av TV 2s viktigste profiler og vi regner med at han blir å se på TV 2 i fremtiden også, sier pressesjef Jan-Petter Dahl i TV 2 til VG.',
          'Programlederen vil forsvinne fra «Senkveld» i løpet av 2021. Hvem som tar over for ham vites ikke. Men Blipp har annet spennende i vente dette året. Til høsten, akkurat tre år etter han begynte i «Senkveld», skal han ha sitt eget soloshow. Stand-up-showet skal starte i Bergen og heter «Cirque du Blipp». Slik presenterte han nyheten på sin instagram-profil for to uker siden:',
          '– Dette var en kjempevanskelig avgjørelse og følelse, for den gjengen som jeg jobber med, vi har blitt en liten familie på kort tid, sier Blipp til VG, og legger til:',
          '– Så det er veldig veldig vemodig og skulle si takk og farvel til det miljøet der, og alt vi har gjort sammen, men samtidig fint, for jeg gjør noe jeg har hatt veldig lyst til å gjøre en god stund.',
          'Samtidig gleder han seg til å begynne sitt soloshow. Det er på scenen han hører hjemme, forklarer han, likevel er det nok ikke siste gang man ser Blipp på TV-skjermen. Nå er han innstilt på å lage en god «Senkveld»-sesong.',
          '– Jeg har bevisst inntatt en sånn posisjon hvor jeg skal gjøre alt jeg kan for å lage en helsikens deilig sesong seks. Ellers har jeg på en måte ikke blandet meg inn for mye, sier Blipp videre.',
        ]),
    CaseItem(
        image: 'assets/images/artikkel_3.jpg',
        title: 'Ekspertenes kritiske corona-dom: − Alvorlig bekymret',
        author: ['Ådne Husby Sadnes'],
        publishedDate: '12.01.2021',
        introduction:
            'Ekspertene peker på at smittetiltakene fører til store konsekvenser, usikkerhet, fare for svekket tillit – og at vi skulle vært bedre rustet og må lære av det.',
        description: [
          'VG har intervjuet eksperter i helse og medisin, jus, økonomi, barneombudet og helsesjefen i hardt coronarammede Oslo. De har fått spørsmål om hva de tenker om dagens coronastrategi, hva som kan være problematisk med den og hva som er konsekvensene av dagens tiltak.Ekspertene kommer også med sine forslag til hvordan myndighetene kunne ha løst ulike utfordringer på en bedre måte.MEDISIN-EKSPERTEN:Mette Kalager, professor i medisin ved Universitetet i Oslo, mener det er fint at smittetiltakene er spisset mot områder der risikoen er størst. Det er likevel noe uklart for henne hva som er strategien nå:– Er det å redusere død, er det å redusere sykdom eller redusere smitte? Dette hører sammen, men vil kreve ulike tiltak og ha ulike konsekvenser for befolkningen. Derfor savner jeg en redegjørelse fra myndighetene der de veier fordeler av å stenge ned; for eksempel hvor mye lidelse og død har vi unngått, versus ulemper; som for eksempel hvor mye lidelse og eventuell død har vi hatt som følge av tiltakene, sier Kalager.'
        ]),
    CaseItem(
        image: 'assets/images/artikkel_4.jpg',
        title: 'Falsk informasjon',
        author: ['SYNNE EGGUM MYRVANG', 'SVEN ARNE BUGGELAND'],
        publishedDate: '12.01.2021',
        introduction:
            'Et Facebook-innlegg med kritiske påstander om familien som mistet sin kommunale bolig på Tøyen i Oslo, spres i sosiale medier. – Farlig, mener Marian Hussein (SV).',
        description: [
          'Forfatter av innlegget hevder å komme med fakta, der mediene angivelig presenterer tøv. Stortingspolitiker Christian Tybring-Gjedde (Frp) gjenga innlegget mandag kveld. – Det er farlig at stortingsrepresentanter deler falsk informasjon, sier Marian Hussein (SV). At Tybring-Gjedde skriver at han personlig ikke kjenner detaljene i saken om den somaliske familien på syv, mener hun er til liten hjelp. – Vi kan ikke fraskrive oss ansvar og samtidig dele falsk informasjon, sier vernepleieren som er vara til Stortinget og nominert på sikker plass for SV.'
        ]),
    CaseItem(
        image: 'assets/images/artikkel_5.jpg',
        title: 'GLIMT-TRENDEN SOM BØR SKREMME ROSENBORG',
        author: ['Arilas Berg Ould-Saada'],
        publishedDate: '12.01.2021',
        introduction:
            'Erik Botheim (21) ble aldri en Rosenborg-suksess. Men Bodø/Glimt har vist gang på gang at de kan lage gull av gråstein med spisser.',
        description: [
          'Ifølge VGs opplysninger nærmer Botheim seg en overgang til den regjerende seriemesteren etter å ha terminert kontrakten med Rosenborg mandag. 21-åringen trente onsdag formiddag for første gang med Bodø/Glimt etter å ha gjennomført den medisinske testen tirsdag. Det forhandles fortsatt om detaljer i kontrakten, men spissen forventes å signere innen kort tid.'
        ]),
    CaseItem(
        image: 'assets/images/artikkel_6.jpg',
        title: '15 tights til trening',
        author: ['Heidi Haraldsen'],
        publishedDate: '12.01.2021',
        introduction: 'Her er tightsene som kan motivere deg til trening.',
        description: [
          'En tights skal være behagelig, følge kroppen, gi deg full bevegelsesfrihet – i tillegg til å se fin ut. Tightsen er tross alt plagget du har på under all type trening – fra styrke til yoga. Man har alltid plass til en ny tights i treningsgarderoben, og nå som vi nærmer oss våren kan du ta en titt på nyhetene som har ankommet butikkene'
        ]),
    CaseItem(
        image: 'assets/images/artikkel_7.jpg',
        title: 'Trump raser mot McConnell: − Mutt, gretten gamp',
        author: ['Sven Arne Buggeland'],
        publishedDate: '16.02.2021',
        introduction:
            'Donald Trump langer ut: – Det republikanske partiet vil aldri igjen bli respektert eller sterkt med politiske «ledere» som senator Mitch McConnell ved roret.',
        description: [
          '– Mitch er en mutt, gretten, smilløs politisk gamp. Hvis republikanske senatorer holder seg til ham, kommer de ikke til å vinne igjen, sier Trump tirsdag.',
          'McConnell – den mektigste republikaneren i Senatet – sa etter avstemningen i riksrettssaken at han mener Donald Trump er ansvarlig for hendelsene 6. januar, da opprørere stormet kongressbygningen.'
              'Like før hadde senator McConnell selv stemt for å frikjenne Trump.',
          '– Demokratene og Chuck Schumer spiller McConnell som en fele. De har aldri hatt det bedre, og de ønsker å bevare det slik, heter det i uttalelsen fra Donald Trump.',
          'Den tidligere presidenten skriver følgende om sin tidligere, nære støttespiller:',
          '– McConnells entusiasme for status quo-politikk, sammen med hans mangel på politisk innsikt, klokskap, dyktighet og personlighet, har raskt drevet ham fra majoritetsleder til minoritetsleder. Og det kommer bare til å bli verre, skriver Trump.',
          'Han legger skylden på McConnell for «katastrofen i Georgia». Republikanerne tapte begge sine to senatsseter fra delstaten. Resultatet var at demokratene med visepresident Kamala Harris’ dobbeltstemme fikk flertall i Senatet.',
          'Ifølge Politico og New York Times hadde den tidligere presidenten planer om å ordlegge seg langt verre, men skal ha blitt overtalt av sine rådgivere til å utelate noen av de verste personkarakteristikkene.',
          'Trump mener det var avgjørende at republikanerne under Mitch McConnell bare ville gi coronarammede amerikanere en sjekk på 600 dollar, mens demokratene tilbød 2000 dollar.',
        ]),
    CaseItem(
        image: 'assets/images/artikkel_8.jpg',
        title:
            '«Game of Thrones»-par har fått sitt første barn: − De er veldig lykkelige',
        author: ['Ingrid Hovda Storaas'],
        publishedDate: '12.01.2021',
        introduction:
            'Skuespillerparet Rose Leslie (34) og Kit Harington (34) har fått en sønn.',
        description: [
          'Det bekrefter Haringtons talsperson Marianna Shafran overfor nyhetsbyrået AP.',
          '– De er veldig, veldig lykkelige, sier hun – uten å røpe flere detaljer.',
          'Nyheten om fødselen ble først meldt av New York Post sin Page Six, som tirsdag publiserte et bilde av paret gående med en barnevogn i London.',
          'Rose Leslie og Kit Harrington møtte hverandre på innspillingen til HBO-serien «Game of Thrones» i 2011. På skjermen var de i et intenst kjærlighetsforhold som Ygritte og Jon Snow.',
          'De to giftet seg i Skottland i 2018, og nyheten om at de ventet sitt første barn ble kjent i september. Da stilte Rose Leslie opp i britiske Make Magazine med sin gravide mage.',
          'Til magasinet fortalte hun at hun og Kit Harington tilbrakte mye tid sammen i det nye huset deres på landsbygda i England, som hun fleipete kaller «huset som Jon Snow bygget».',
          '– Det er et stort privilegium å være omgitt av grøntområder, fuglesang, hekker og våre herlige naboer. Det er så fredelig, sa hun blant annet da.',
        ]),
  ];
  List<CaseItem> sisteNyttList = [
    CaseItem(
        image: 'assets/images/artikkel_9.jpg',
        title: 'Frp-politikere ut mot Listhaug: − Det siste vi trenger',
        author: ['RUNA FJELLANGER', 'SARAH BRENNSÆTER', 'EIRIK RØSVIK'],
        publishedDate: '19.02.2021 kl. 11:16',
        introduction:
            'Sylvi Listhaug vil bli en splittende partileder, mener Frp-politiker Silje Flaten Haugli. Hun frykter masseutmelding av partiets liberalistiske medlemmer.',
        description: [
          '«Det er ikke akkurat hurramegrundt-stemning i Fremskrittspartiet om dagen, og vi er mange som opplever partiet som splittet og med en trykkende, klein stemning som ingen helt tørr å gjøre noe med i frykt for og gjøre seg selv upopulær», skriver Silje Flaten Haugli i en kronikk i VG.',
          '«I et allerede splittet Frp er det siste vi da trenger en ny, splittende partileder med navn Sylvi Listhaug», skriver hun videre.',
          'Haugli er 2. vara til Stortinget for Frp i Aust-Agder, lokallagsleder i Tvedestrand Frp og har vært tillitsvalgt i partiet i nesten 11 år.',
          'Hun får støtte fra Tommy Skatland, fylkesleder i Trøndelag Frp.',
          '– Partiet trenger en samlende leder som har bredest mulig støtte i partiet, sier han til Adresseavisen.',
          'Og det er ikke Listhaug, sier Skatland.',
          '– Båret på gullstol av de nasjonalkonservative',
          'Torsdag kom Siv Jensen sjokknyheten om sin egen avgang som leder i Fremskrittspartiet. Samtidig pekte hun på nåværende nestleder Sylvi Listhaug som ny partileder etter landsmøtet i mai.',
          '– Jeg er veldig ydmyk på at Siv har pekt på meg som arvtager. Sammen med mannen min Espen har jeg besluttet å takke ja til å bli leder i Frp, hvis partiet og landsmøtet ønsker det, sa Sylvi Listhaug på en pressekonferanse fredag formiddag.',
          'Landsmøtet bør ikke gi den jobben til Listhaug, mener Haugli.',
          '– Vi er avhengig av å ha en samlende leder, og hittil er det mangel på dette av ledelsen. Mange innrømmer ikke engang den pågående "fløykrigen", sier Haugli til VG.',
          '«Selv om hun erklærer seg selv som liberalist og tilhenger av frihet for folk flest har hun ofte stått opp for verdier og holdninger vi som liberalister ikke kan vedkjenne oss og blitt nærmest båret på gullstol av de nasjonalkonservative», skriver hun i kronikken.',
          '– Vi som er liberalistiske vil ikke stå inne for det Sylvi gjør og sier, dette nasjonalkonservative ønskes ikke av oss, kommenterer hun.',
          'Haugli sier til VG at hun ble veldig overrasket over Sivs avskjed',
          '–Selv om det har vært forventet fra tidligere at hun før eller siden kom til å gå, var det veldig uventet at det skulle skje så plutselig, også før en valgkamp. Det er leit: – Men jeg forstår at Siv må få være Siv nå, og respekterer det',
        ]),
    CaseItem(
        image: 'assets/images/artikkel_10.jpg',
        title: 'Billie Eilish hevder «stalker» truer henne på livet',
        author: ['CATHERINE GONSHOLT IGHANIAN'],
        publishedDate: '19.02.21 kl. 12:10',
        introduction:
            'Popstjernen (19) krever beskyttelse mot en mann som angivelig camper utenfor huset hennes og sender truende, håndskrevne brev.',
        description: [
          '«Du kan ikke få det du ønsker deg, hvis ikke det du ønsker er å dø for meg. Så fort vannet stiger, vil du innse det. Og det er mye mulig at du dør. Du skal dø», skriver mannen i ett av de mange brevene ifølge TMZ.',
          'Nettstedet viser til rettsdokumenter der Billie Eilish hevder at mannen siden august i fjor har campet utenfor en skole med innsyn til hennes inngangsparti i Los Angeles, og at han overvåker når hun kommer og går.',
          '19-åringen skriver i anmeldelsen at mannen enten roper eller gestikulerer hver gang han ser henne, og at det kan dreie seg om å late som han kutter strupen.',
          'Situasjonen skal ha gjort at Eilish ikke føler seg trygg hverken i eller utenfor sitt eget hjem.',
          '«Hver gang jeg ser ham, får jeg lyst til å skrike», skal Eilish ha uttalt ifølge dokumentene, som også er omtalt av The Blast.',
          'Pålagt å holde avstand',
          'Popstjernen frykter både for egen sikkerhet samt for familiens.',
          'Retten skal ha gitt artisten medhold i å ilegge personen rettslig forbud mot å nærme seg henne og foreldrene. Vedkommende er ikke arrestert, men må ifølge TMZ holde seg på 200 meters avstand.',
          'Skjedd før',
          'Det er ikke første gang Eilish har gått rettens vei for å stoppe en «stalker». Også i fjor sommer fikk hun rettens medhold i å gi en mann forbud mot å komme nærmere enn 100 meter. Forbudet ble besluttet å gjelde i tre år.',
          'Angivelig er det ikke snakk om samme mann.'
        ]),
    CaseItem(
        image: 'assets/images/artikkel_1.jpg',
        title: 'Oslo gjør noen lettelser – men holder på skjenkestoppen',
        author: [
          'LARS HÆGELAND',
          'SYNNE EGGUM MYRVANG',
          'RUNA FJELLANGER',
          'OLINE BIRGITTE NAVE',
          'ENDRE ALSAKER-NØSTDAHL'
        ],
        publishedDate: '12.01.2021',
        introduction:
            'Oslo vil åpne campus for studenter og fritidsaktiviteter for at barn og unge kan drive med fritidsaktiviteter både innendørs og utendørs. Men stengte kjøpesenter, stengte treningssentre og skjenkestopp fortsetter.',
        description: [
          'Byrådsleder Raymond Johansen viser til at smitten igjen stiger i hovedstaden.',
          '– Selv med svært strenge tiltak står vi i en situasjon der smitten stiger, sier han – og peker blant annet på utbruddet i Norges største barnehage.',
          'Når regjeringen nå har opphevet de nasjonale ring-tiltakene som hovedstaden har vært omfattet av, velger imidlertid Oslo fortsatt å holde igjen noe. De nye endringene i Oslo-reglene skal vare i to uker før det blir gjort en ny vurdering.',
          'Dette er endringene i Oslo: Dette er lettelsene som nå gjøres i hovedstaden:',
          '-Barn og unge opp til 19 år får igjen drive med fritidsaktiviteter både innendørs og utendørs.',
          '-Lesesaler og bibliotek på universiteter og høgskoler åpner for studenter.'
              '-Oslo åpner også for utendørs aktivitet og idrett for voksne, i grupper på maks 10 personer og med krav om at de må holde minst en meters avstand.',
          'Oslo kommune vil imidlertid fortsatt ha begrensninger for kjøpesenter og ha skjenkestopp. Det betyr at det bare er noen få butikker på kjøpesenter som kan holde åpent, som apotek og matbutikker. Treningssenter vil også fortsatt være stengt.',
          '– Vi tar sikte på at kjøpesenter kan åpne i løpet av de neste ukene, sier byrådslederen.',
          'Han sier at det er et voldsomt press og pågang om spesielt å åpne treningssentrene. Det er derfor det nå åpnes for at de kan ha små gruppetimer utendørs for voksne, sier Johansen.'
        ]),
    CaseItem(
        image: 'assets/images/artikkel_2.jpg',
        title: 'TV 2 bekrefter: Stian Blipp slutter i «Senkveld»',
        author: ['JØRN PETTERSEN', 'MARIA STØRE'],
        publishedDate: '12.01.2021',
        introduction:
            'Stian Blipps tid i «Senkveld» nærmer seg slutten, opplyser TV 2 og Stian Blipp selv.',
        description: [
          'Helene Olafsen og Stian Blipp har sammen ledet «Senkveld» på TV 2 siden høsten 2018. Blipp var på det tidspunktet kjent som programleder for «Norske Talenter», «Gullruten», «Idol», «Mitt Dansecrew» og «Stian Blipp Show».',
          'Nå nærmer det seg slutten for Stian Blipp i «Senkveld». Etter denne sesongen forlater han programmet. Det bekrefter både Blipp og TV 2 overfor VG.',
          '– Stian Blipp skal slutte i «Senkveld». Hva som skjer til høsten er det ikke tatt noen avgjørelse på. Men Stian er en av TV 2s viktigste profiler og vi regner med at han blir å se på TV 2 i fremtiden også, sier pressesjef Jan-Petter Dahl i TV 2 til VG.',
          'Programlederen vil forsvinne fra «Senkveld» i løpet av 2021. Hvem som tar over for ham vites ikke. Men Blipp har annet spennende i vente dette året. Til høsten, akkurat tre år etter han begynte i «Senkveld», skal han ha sitt eget soloshow. Stand-up-showet skal starte i Bergen og heter «Cirque du Blipp». Slik presenterte han nyheten på sin instagram-profil for to uker siden:',
          '– Dette var en kjempevanskelig avgjørelse og følelse, for den gjengen som jeg jobber med, vi har blitt en liten familie på kort tid, sier Blipp til VG, og legger til:',
          '– Så det er veldig veldig vemodig og skulle si takk og farvel til det miljøet der, og alt vi har gjort sammen, men samtidig fint, for jeg gjør noe jeg har hatt veldig lyst til å gjøre en god stund.',
          'Samtidig gleder han seg til å begynne sitt soloshow. Det er på scenen han hører hjemme, forklarer han, likevel er det nok ikke siste gang man ser Blipp på TV-skjermen. Nå er han innstilt på å lage en god «Senkveld»-sesong.',
          '– Jeg har bevisst inntatt en sånn posisjon hvor jeg skal gjøre alt jeg kan for å lage en helsikens deilig sesong seks. Ellers har jeg på en måte ikke blandet meg inn for mye, sier Blipp videre.',
        ]),
  ];

  // example list for the carousel slider
  List<CaseItem> popularCases = [
    CaseItem(
        image: 'assets/images/artikkel_7.jpg',
        title: 'Trump raser mot McConnell: − Mutt, gretten gamp',
        author: ['Sven Arne Buggeland'],
        publishedDate: '16.02.2021',
        introduction:
            'Donald Trump langer ut: – Det republikanske partiet vil aldri igjen bli respektert eller sterkt med politiske «ledere» som senator Mitch McConnell ved roret.',
        description: [
          '– Mitch er en mutt, gretten, smilløs politisk gamp. Hvis republikanske senatorer holder seg til ham, kommer de ikke til å vinne igjen, sier Trump tirsdag.',
          'McConnell – den mektigste republikaneren i Senatet – sa etter avstemningen i riksrettssaken at han mener Donald Trump er ansvarlig for hendelsene 6. januar, da opprørere stormet kongressbygningen.'
              'Like før hadde senator McConnell selv stemt for å frikjenne Trump.',
          '– Demokratene og Chuck Schumer spiller McConnell som en fele. De har aldri hatt det bedre, og de ønsker å bevare det slik, heter det i uttalelsen fra Donald Trump.',
          'Den tidligere presidenten skriver følgende om sin tidligere, nære støttespiller:',
          '– McConnells entusiasme for status quo-politikk, sammen med hans mangel på politisk innsikt, klokskap, dyktighet og personlighet, har raskt drevet ham fra majoritetsleder til minoritetsleder. Og det kommer bare til å bli verre, skriver Trump.',
          'Han legger skylden på McConnell for «katastrofen i Georgia». Republikanerne tapte begge sine to senatsseter fra delstaten. Resultatet var at demokratene med visepresident Kamala Harris’ dobbeltstemme fikk flertall i Senatet.',
          'Ifølge Politico og New York Times hadde den tidligere presidenten planer om å ordlegge seg langt verre, men skal ha blitt overtalt av sine rådgivere til å utelate noen av de verste personkarakteristikkene.',
          'Trump mener det var avgjørende at republikanerne under Mitch McConnell bare ville gi coronarammede amerikanere en sjekk på 600 dollar, mens demokratene tilbød 2000 dollar.',
        ]),
    CaseItem(
        image: 'assets/images/artikkel_8.jpg',
        title:
            '«Game of Thrones»-par har fått sitt første barn: − De er veldig lykkelige',
        author: ['Ingrid Hovda Storaas'],
        publishedDate: '12.01.2021',
        introduction:
            'Skuespillerparet Rose Leslie (34) og Kit Harington (34) har fått en sønn.',
        description: [
          'Det bekrefter Haringtons talsperson Marianna Shafran overfor nyhetsbyrået AP.',
          '– De er veldig, veldig lykkelige, sier hun – uten å røpe flere detaljer.',
          'Nyheten om fødselen ble først meldt av New York Post sin Page Six, som tirsdag publiserte et bilde av paret gående med en barnevogn i London.',
          'Rose Leslie og Kit Harrington møtte hverandre på innspillingen til HBO-serien «Game of Thrones» i 2011. På skjermen var de i et intenst kjærlighetsforhold som Ygritte og Jon Snow.',
          'De to giftet seg i Skottland i 2018, og nyheten om at de ventet sitt første barn ble kjent i september. Da stilte Rose Leslie opp i britiske Make Magazine med sin gravide mage.',
          'Til magasinet fortalte hun at hun og Kit Harington tilbrakte mye tid sammen i det nye huset deres på landsbygda i England, som hun fleipete kaller «huset som Jon Snow bygget».',
          '– Det er et stort privilegium å være omgitt av grøntområder, fuglesang, hekker og våre herlige naboer. Det er så fredelig, sa hun blant annet da.',
        ]),
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
      body: SingleChildScrollView(
          child: Center(
        child: Container(
          width: 800,
          color: Colors.grey.shade300,
          child: Column(
            children: [
              ResponsiveGridRow(
                children: [
                  ResponsiveGridCol(
                    lg: 8,
                    xs: 12,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(color: Colors.white),
                            height: 320,
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
                  ),
                  ResponsiveGridCol(
                    lg: 4,
                    xs: 12,
                    child: Container(
                      height: 325,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Siste Nytt',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
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
                                                builder: (context) => CasePage(
                                                      caseItem: caseObject,
                                                    )));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 500,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3),
                                                  spreadRadius: 5)
                                            ]),
                                        margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
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
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
              ResponsiveGridRow(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: caseList.map((e) {
                  return ResponsiveGridCol(
                      lg: 4,
                      md: 6,
                      xs: 12,
                      child: Container(
                          margin: EdgeInsets.all(5),
                          height: 250,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CasePage(
                                              caseItem: e,
                                            )));
                              },
                              child: BaseCaseBox(e))));
                }).toList(),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
