\\ b une clef publique donc un tableau
\\ c le dernier chiffre
base(b, c) = {
    my(base, i, n);
    n = #b + 1;
    base = matrix(n);
    for(i = 1, n-1,
        base[i, i] = 1;
        base[i, n] = -b[i];
    );
    base[n, n] = c;

    return(base);
}

\\ Fonction de test de l'Algorithme LLL
test() = {
    my(n, A, M, w, A1, Mess, s, b, res, T);

    \\ taille du crytposysteme
    n = 150;
    A = vector(n,i,random([2^n*(2^(i-1)-1)+1,2^n*(2^(i-1))]));
    M = random([2^(2*n+1)+1,2^(2*n+2)-1]);
    until(gcd(w,M)==1, w=random([2,M-2]));

    \\ A1 la clef publique
    A1 = lift(Mod(A/w,M));

    \\ Mess le message
    until(Mess != vector(n,i,0), Mess = vector(n,i,random([0,1])));

    \\ s le message crypté, donc juste un entier
    s = (A1*mattranspose(Mess));

    \\ on transforme le problème en base de reseau
    b = base(A1, s);
    T = qflll(b~);
    b = b~*T;
    b = b~;

    for(i=1, n+1,
        res = 0;
        for(j = 1, n,
            res +=b[i, j]*A1[j];
        );
        if(res == s, return(1));
    );
    return(0);

}
main() = {
    my(n, res, i);
    \\ nombre de test qu'on fait
    n = 1;
    res = 0;
    for(i = 1, n,
        res += test();
    );
    print(res, "/", n);

}


main();
