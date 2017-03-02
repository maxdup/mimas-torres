app = angular.module('folio.Locale', ['pascalprecht.translate'])

app.config(['$translateProvider', ($translateProvider) ->
  $translateProvider.translations('en', {
    #nav
    'nav-title': 'Level Designer'
    'nav-commercial': 'Commercial work'
    'nav-hobby': 'Hobby projects'
    'nav-code': '++'
    'nav-contact': 'Contact'
    #frontpage
    'welcome': 'Welcome to my portfolio!'
    'intro' : "Hi, I'm Maxime. Some will say I'm a designer, others will call me a software developer. Truth is, I'm just a builder; I like to make things. My favorite thing is when I get to make things that other people can experience. This is what I'm all about. My infatuation with crafting experiences is what got me into level design. The Team Fortress 2 community has been my testbed of choice for many different design experiments but also a phenomenal place to iterate on gameplay ideas and develop great experiences. It's where I got my start as a level designer... it's where the story began!"
    #maps
    'wanttoplay': 'Want to play it?'
    'instructions': 'Instructions'
    'install-1': 'Install and log into the Steam client'
    'install-2': 'Install Team Fortress 2 (free to play)'
    'install-3': 'Get the map by subscribing on the workshop'
    'install-3-warn': "It's only to make sure the link opens in the steam client."
    'install-3-alt': '-Alternatively, subscribe'
    'install-3-alt2': 'from your bowser.'
    'install-4': 'Load the map ingame'
    'install-4-warn': '-This link might not work if the game client is already open'
    'install-4-alt': '-Alternatively, you can load the map from the main menu with "Start playing", and then "Create server". Find the map you\'re looking for in the dropdown menu and proceed forward.'
    'install-warn': "-This link may be reported as potentially harmful by your browser. These types of links can indeed be dangerous but there's nothing fishy hidden in this one."
    'loading': 'Loading...'
    #blurbs
    'vanguard': 'Initially designed as a control point map for competitive play, Vanguard was an attempt at making a map focused on fast paced gameplay. The design of the map allows it to perform nicely in public play as well as in competitive environments. The goal was to make a map that rewards aggressive gameplay and good positioning. The result is a fast paced and punishing map that often results in a great back and forth game between the opposing teams.'
    'occult': 'Featuring a completely new visual theme, the control point of this map is an old relic with unknown powers. We don’t know why Blue and Red are fighting over it but it looks important! They have no idea what that thing has in store for them, however. I consider this map to be one of my finest work for the technical achievement it represents. It\'s definitely not an ambitious level in terms of its scale, but it is very polished and features many special effects of my own such as complex animations, particle systems, and textures that use source’s shaders to their fullest.'
    'hadal': "Hadal is the result of a collaboration with another talented level designer. It was interesting to have a project where we would share all the design responsibilities and ultimately, I feel like the level has benefited from it. It was also a great opportunity to prototype a new workflow in the level editor that allowed for a better integration of version control technologies with the project. Hadal lays the foundation and serves as a proof of concept for future collaborations in the source engine. There are many factors at play, but I'm happy to be able to say that hadal was part of making the modding community more mature."
    'effigy': "Effigy is a spin on TF2's payload game mode. Normally you'd have a team trying to push the payload to the enemy base and the other team would try to defend against that attack. Here, both teams are trying to push the same cart to each other's base, resulting in some sort of tug of war. It started as a simple twist on a classic but the game mode came with its own set of challenges. Coming up an adequate layout for the game mode and figuring out a set of mechanics to resolve stalemates was anything but straightforward. In the end, however, the map ended up delivering pretty successfully on its design goals."
    #quotes
    'toughbreak': 'Added to Team Fortress 2 as part of the '
    'toughbreak2': '"Tough Break" update'
    'pcgamer': '"Great TF2 community map"'
    #code
    'code-title': 'Did anyone say scripting?'
    'code-intro': "You get to wear a lot of hats when you design levels and as it turns out, I'm very well versed in programming. It has helped me a lot in scripting some of the more complicated levels but there was no reason to stop there. I've been able to apply my knowledge on improving an engine's toolset for everyone and it was just as useful. To be the best, you need the best tools! Here are some of the tools I've been working on to assist me in my level design adventures."
    'code-cpal': "CompilePal is one of those tools that asks a simple question. \"What if, we could automate most of the tasks required to compile and publish a level?\". Well, the answer would be CompilePal. It seemed impossible at first but we've taken every step of the process, steps that had been done by hand for over a decade, and figured out ways to completely automate them. That includes building navigation meshes, baking reflections and most of all, a system that automatically builds a dependency tree of a level's interdependent assets and packages them neatly for distribution. To top it off we even automated compression, your level is now ready to ship. We have automated to a single click a process that, in some cases, could take up to a whole day. We've come a long way and now level designers are able to iterate faster than ever. We're very proud to be able to say that There's the Source engine before CompilePal, and then there's Source after CompilePal."
    'code-vrad': "Source's static lighting has been known to have weird issues. You can end up with lighting bleeding into areas where it shouldn't be or maybe you'll end up with weird artifacts, you never know. The bad part is that often times, there's no real solution to fixing it. For those special times when you're out of options, I've developed a lightmap editor. For any given surface, the tool enables you to edit the color and brightness on its lightmap."
    'code-vmmc-st':'Or the Valve Map Manifest Collapser'
    'code-vmmc': "Source is a weird engine, The level editor is chock full of features but sometimes, those features are simply not supported by the level compiler. VMMC aims to add support for some those features by preprocessing files for the compiler. In this case, we needed a tool to adds support for the editor's capability to chop levels into submaps and instances. As it turns out, being able to divide a level into smaller pieces is really crucial to achieving good version control. Having multiple smaller files means we can have better tracking of changes and allows us to have more concurrent designers working on the same level. This tool really needed to happen since the community is starting to team up to build bigger and better."
    'code-git': 'The project on GitHub'
    #contact
    'contact' : 'Want to get in touch?'
    'contactblurb': "There's a lot of places where you can reach me, you'll find most of them here."
    'contacttrue' : '(The only true way to my heart is via email tho)'
    'findme': 'Find me on the web!'
    'contactme': 'Contact me!'
    'languages': 'in french or english'
    'address' : '1981, Tillemont street'
    'status': 'Status:'
    'available': 'Available'
    'unavailable': 'Unavailable'
    'hire': 'for hire'
    'contract': 'for contract'
    'cv': 'Add this one to the pile!'
  })
  $translateProvider.translations('fr', {
    #nav
    'nav-title': 'Concepteur de niveau'
    'nav-commercial': 'Travail commercial'
    'nav-hobby': 'Projets personnels'
    'nav-code': '++'
    'nav-contact': 'Contact'
    #frontpage
    'welcome': 'Bienvenue sur mon portfolio!'
    'intro' : "Bonjour, je m'appelle Maxime. Certains diront que je suis un designer, d'autres diront que je suis un développeur. La vérité, je ne suis qu'un créatif; j'aime simplement bâtir. Ce que je préfère c'est bâtir des choses dont les gens peuvent faire expérience. C'est tout ce qui m'importe. C'est mon engouement pour la création d'expériences qui m'a guidé vers la conception de niveaux. La communauté de Team Fortress 2 a été mon banc d'essai pour plusieurs expérimentations de design, mais surtout un endroit phénoménal pour itérer sur différentes idées et développer des expériences hors du commun. C'est là où j'ai débuté en tant que concepteur de niveaux... C'est là où l'histoire a commencé!"
    #maps
    'wanttoplay': 'Vous voulez y jouer?'
    'instructions': 'Instructions'
    'install-1': 'Installez et connectez-vous dans le client Steam'
    'install-2': 'Installez Team Fortress 2 (gratuit)'
    'install-3': 'Installez le niveau en vous abonnant sur le workshop'
    'install-3-warn': 'I\'m only making sure the link opens in the steam client.'
    'install-3-alt': '-alternativement, abonnez-vous'
    'install-3-alt2': 'à partir de votre navigateur.'
    'install-4': 'Chargez le niveau dans le jeu'
    'install-4-warn': '-ce lien pourrait ne pas fonctionner si le client de jeu est déjà ouvert.'
    'install-4-alt': '-alternativement, vous pouvez charger le niveau à partir du menu principal avec "Start playing", puis "Create server". Trouvez le niveau dans le menu déroulant et chargez la partie.'
    'install-warn': "-Ce lien pourrait être reporté comme dangereux par votre navigateur. Ce type de lien peut effectivement être dangereux, mais rien ne se cache dans celui-ci."
    'loading': 'Chargement...'
    #blurbs
    'vanguard': 'Initialement conçu comme un niveau à point de contrôles pour la communauté compétitive, Vanguard était une tentative à créer un niveau avec un gameplay au rythme rapide. Sa conception lui permet de performer adéquatement autant dans les parties publiques que dans un environnement compétitif. Le but était de faire un niveau que récompense un style de jeu agressif avec une emphase sur le positionnement. Le résultat est un niveau rapide qui ne pardonne pas, donnant lieu à de grands va-et-vient entre les deux équipes.'
    'occult': "Un niveau avec un thème visuel complètement nouveau dont le point de contrôle est une ancienne relique avec des pouvoirs inconnus. Les mercenaires ne savent pas vraiment pourquoi ils se battent pour cette chose, mais on leur a assuré que c'était important! Ils n'ont aucune idée de ce qui les attende... Je considère ce niveau comme étant un de mes meilleurs pour la réussite technique qu'il représente. Ce n'est pas un niveau très ambitieux en terme de taille, mais il est très peaufiné et présentent plusieurs effets spéciaux faits par moi-même tels que des animations complexes, des systèmes de particule et des textures qui utilisent les shaders de Source à leur plein potentiel."
    'hadal': "Hadal est le résultat d'une collaboration avec un autre concepteur de niveaux très talentueux. C'était intéressant d'avoir un projet ou toutes les responsabilités en termes de design étaient partagées. Ultimement, je sens que le niveau en a beaucoup bénéficié. C'était un bon projet pour prototype une nouvelle méthodologie dans l'éditeur de niveau pour nous permettre une meilleure utilisation des logiciels de contrôle de version. Hadal sert d'une sorte de fondations et est une preuve de concept pour les collaborations futures dans l'engin Source. Il y a plusieurs facteurs en jeu, mais je suis content que Hadal puisse faire partie des facteurs qui contribuent à rendre la communauté de modding plus mature."
    'effigy': "Effigy crée une variante sur le mode \"Charge Utile\" de TF2. Normalement, une équipe essaie de pousser un chariot jusqu'à la base ennemie alors que l'autre équipe essaie de se défendre contre l'attaque. Ici, les deux équipes essaient de pousser l'objectif dans la base ennemie, comme un tir à la corde, mais à l'inverse. Le niveau avait commencé comme une simple variante d'un classique, mais le mode de jeu est arrivé avec ses propres défis en terme de design. Trouver une bonne disposition du niveau et trouver des mécanismes pour briser les impasses entre les équipes n'a pas été simple. Mais en fin de compte, le niveau a fini par atteindre ses objectifs avec succès."
    #quotes
    'toughbreak': 'Ajouté à Team Fortress 2 avec la mise à jour '
    'toughbreak2': '"Tough Break"'
    'pcgamer': '"Great TF2 community map"'
    #code
    'code-title': "Quelqu'un a parlé de scripting?"
    'code-intro': "On porte plusieurs chapeaux quand on conçoit un niveau. Parmi les différentes disciplines, l'un de mes points forts est la programmation. Ça a été très utile pour le scripting de certains niveaux plus complexes, mais il n'y avait aucune raison d'arrêter là. J'ai aussi été capable d'appliquer mes connaissances pour améliorer les outils de modding de la communauté et ce fut tout aussi utile. Pour être le meilleur, il faut avoir les meilleurs outils! Voici quelques'un des outils sur lesquels j'ai travaillé pour m'aider dans mes aventures de conception de niveaux."
    'code-cpal': "CompilePal est un de ces outils qui pose une question simple. \"Et si l'on pouvait automatiser la majorité des étapes requise pour compiler et publier un niveau?\" Bien, la réponse serait CompilePal. Ça semblait impossible à première vue, mais nous avons pris chaque étape du processus, des étapes qui avaient été faites à la main pour plus d'une décennie, et avons trouvé des moyens de les automatiser complètement. Incluant, la construction des meshs de navigation, le précalcule des reflets et par-dessus tout, un système qui permet de construire automatiquement un arbre de dépendances des assets d'un niveau et de les inclure a même le niveau pour être distribué. Ensuite, on a même automatisé la compression, le niveau est prêt à livrer. Nous avons réduit à un seul clique, un processus qui pouvait prendre une journée entière dans certains cas. Nous étions partis de loin, mais avons fait beaucoup de chemin depuis. Maintenant, les concepteurs de niveau sont capables d'itérer plus rapidement que jamais. Nous sommes très fiers de pouvoir dire qu'il y a l'engin Source avant CompilePal, puis il y'a Source après CompilePal."
    'code-vrad': "L'éclairage statique de Source est connu pour avoir . Il peut y avoir de la lumière qui passe à travers des endroits où elle ne devrait pas. Ou encore, il y aura des erreurs de calcul étrange qui colorent les surfaces inadéquatement, on ne sait jamais ce qui va arriver. La mauvaise nouvelle c'est que parfois, il n'y a aucune vraie solution pour remédier à ça. Pour ces moments où il n'y pas d'autres options, j'ai développé un éditeur de lightmap. Pour n'importe quelle surface donnée, l'outil permet de modifier la couleur et l'intensité du lightmap."
    'code-vmmc-st':'Ou le Valve Map Manifest Collapser'
    'code-vmmc': "Source est un engin étrange, l'éditeur de niveaux est plein de fonctionnalité, mais parfois, les fonctionnalités ne sont tout simplement pas supportées par le compilateur de niveau. Vmmc vise à ajouter du support pour ces fonctionnalités en s'ajoutant comme une étape préalables au compilateur. Dans ce cas-ci, nous avions besoin d'un outil pour supporter la capacité de l'éditeur à diviser un niveau en plusieurs parties. Parce qu'au final, pouvoir diviser un niveau en petites parties est très utile pour une bonne utilisation des logiciels de gestion de versions. Avoir de multiple fichier de petite taille nous permet d'avoir un meilleur suivi des modifications et d'avoir plus de designers travaillant en parallèle sur le niveau. Cet outil devait arriver parce que les gens de la communauté commencent à se réunir pour construire plus gros et plus solide."
    'code-git': 'Le projet sur GitHub'
    #contact
    'contact': 'Vous voulez me rejoindre?'
    'contactblurb': "Il y a plusieurs endroits pour me rejoindre, vous trouverez la majorité d'entre eux ici."
    'contacttrue' : "(Par contre, le vrai chemin vers mon coeur, c'est par courriel)"
    'findme': 'Trouvez-moi sur le web!'
    'contactme': 'Contactez-moi!'
    'languages': 'en français ou en anglais'
    'address' : '1981, rue Tillemont'
    'status': 'Statut:'
    'available': 'Disponible'
    'unavailable': 'Non Disponible'
    'hire': 'pour emplois'
    'contract': 'pour contrat'
    'cv': 'Un autre pour la pile!'
  })
  $translateProvider.preferredLanguage('en')
  $translateProvider.useSanitizeValueStrategy('escapeParameters')
])
