ENTRA ID
AD
service d'annuaire managé
Abonnement Azure inclut un locataire/annuaire par défaut
Certaines fonctionnalités de gestion d'identités nécessitent des versions payantes de MS Entra ID

AD DS axé sur applications locales
Entra ID axé sur gestion identités et app web
Contrairement à AD DS, Microsoft Entra ID est multilocataire par conception
Le terme « locataire » représente une instance Microsoft Entra individuelle
Dans un abonnement Azure, vous pouvez créer plusieurs locataires Microsoft Entra
À un moment donné, un abonnement Azure doit être associé à un et un seul locataire Microsoft Entra. C'est ce qui permet le RBAC.
Un seul locataire Microsoft Entra peut prendre en charge plusieurs abonnements Azure.
Entra ID ne permet pas la gestion matériel via GPO (comme AD ferait)
L'atout d'Entra ID réside dans la fourniture de services d’annuaire, le stockage et la publication de données utilisateur, d’appareil et d’application, ainsi que la gestion de l’authentification et de l’autorisation des utilisateurs, des appareils et des applications.
Entra ID n’inclut pas la classe d’unité d’organisation (UO), donc pas d'organisation dans une hiérarchie de conteneurs personnalisés.

Application Object : C'est le modèle global (Unique, dans le tenant d'origine).
Service Principal : C'est l'identité locale pour l'exécution (Une par tenant où l'application est utilisée).

ActiveDirectory =
Active Direct Domain Services (AD DS) 
Active Directory Certificate Services (AD CS)
Active Directory Lightweight Directory Services (AD LDS)
Active Directory Federation Services (AD FS)
Active Directory Rights Management Services (AD RMS)

Les utilisateurs et les groupes Microsoft Entra sont créés dans une structure plate, et il n’existe pas d’unités d’organisation ni d’objets de stratégie de groupe.
Vous ne pouvez pas interroger Microsoft Entra ID en utilisant LDAP ; au lieu de cela, Microsoft Entra ID utilise l’API REST sur HTTP et HTTPS.
Microsoft Entra ID n’utilise pas l’authentification Kerberos ; au lieu de cela, il utilise des protocoles HTTP et HTTPS comme SAML, WS-Federation et OpenID Connect pour l’authentification, et OAuth pour l’autorisation.