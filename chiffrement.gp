\\ Génération d'une suite super croissante :
\\ len est la taille de la suite qu'on souhaite
geneCroissante(len) = {
    my(a, somme);
    a = vector(len);
    somme = 0;
    for(i = 1, len,
        a[i] = random() + somme;
        somme += a[i];
    );
    return(a);
}


\\ Calcul de la clef privée

\\ a est une suite super croissante
\\ Cette fonction sert à calculer les clef privée
clefPrivee(a) = {
    my(somme = 0);
    for(i = 1, #a,
        somme += a[i];
    );
    my(N = random(somme));  \\ J'en ai pris un random mais on fait comme on veut
    N +=somme; \\ 2*somme> N >somme   ==> c'est juste pour pas qu'il soit trop grand

    my(d = 0);
    my(A = 0);
    while(d != 1,
        A = random(N);
        d = gcd(A, N);
    );
    \\ On a bien pgcd(A, N) = 1

    my(privee = [a, N, A]);
    return(privee);
}



\\ Calcul de la clef Publique

\\ privee est la clef privee
clefPublique(privee) = {
    publique = vector(#privee[1]);
    for(i = 1, #publique,
        publique[i] = Mod(privee[1][i] * privee[3], privee[2]);
    );
    return(publique);
}




\\ w est le mot de longueur n qu'on veut envoyer
\\ publique est la clef publique
chiffrement(w, publique) = {
    my(c = 0);
    for(i = 1, #w,
        c+ = w[i]*publique[i];
    );
    return(c);
};



\\ c est le chiffré
\\ privee est la clef privée
dechiffrement(c, privee) = {
    my(invA = Mod(privee[3], privee[2])^-1);
    my(p = invA * c);
    p = lift(p);

    \\ on a aussi que p = somme(ai * bi)
    \\ comme ai est une suite super croissante, on peut retrouver les bi facilement

    x = vector(#privee[1]);

    my(n= #privee[1]); \\ le cardinal
    forstep(i=n, 1, -1,
        if(p >= privee[1][i],
            x[i] = 1; p-= privee[1][i],
            x[i] = 0;
        );
    );
    return (x);
}



main() = {
    \\ test chiffrement/ dechiffrement
    my(privee, b, w, c, m);
    privee = [[1,3,7,19,41,72,183,333], 732, 587];
    b = clefPublique(privee);
    w = [0,1,0,0,1,1,0,0];
    c = chiffrement(w, b);

    m = dechiffrement(c, privee);

    print(w);
    print(m);


    \\ test génaration de clef privée
    my(a, priveeTest);
    a = geneCroissante(5);
    priveeTest = clefPrivee(a);
    print(priveeTest);

}

main();
