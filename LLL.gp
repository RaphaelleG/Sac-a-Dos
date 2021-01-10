\\ b une clef publique donc un tableau
\\ c le dernier chiffre
base(b, c) = {
    my(base, i, n);
    n = #b + 1;
    base = vector(n);
    for(i = 1, n-1,
        base[i] = vector(n);
        base[i][i] = 1;
        base[i][n] = -b[i];
    );
    base[n] = vector(n);
    base[n][n] = c;

    return(base);
}




\\ renvoie le produit scalaire de deux vecteurs
scal(a, b) = {
    my(r , i);
    r = 0;
    for(i = 1, #a,
        r += a[i]*b[i];
    );
    return(r);
}


\\ [b, mu] = RED[k,l, b, mu] ==> pour mette les valeurs à jour de b et mu
RED(k, l, b, mu) = {
    my(r, j);
    if(abs(mu[k][l]) > 1/2,
        r = floor(0.5 + mu[k][l]);
        b[k] -=r*b[l];
        for(j =1, l-1,
            mu[k][j] -= r*mu[l][j];
        );
        mu[k][l] -=r;
    );
    return([b, mu]);
}


\\ b une base, donc un tableau de tableau

LLL(b) = {

    my(n = #b);

    \\ Première étape : Orthogonalisation de la base
    my(b_ortho, mu, B, i, j, k);

    b_ortho = vector(n); \\ la base orthonormée
    b_ortho[1] = b[1];


    \\ tableau simple
    B = vector(n);
    B[1] = scal(b_ortho[1], b_ortho[1]);

    \\ tableau de tableau
    mu = vector(n);
    for(i = 1, n,
        mu[i] = vector(n);
    );


    for(i = 2, n,
        b_ortho[i] = b[i];
        for(j = 1, i-1,
            mu[i][j] = scal(b[i], b_ortho[j])/ B[j];
            b_ortho[i] -=mu[i][j]*b_ortho[j];
        );
        B[i]= scal(b_ortho[i], b_ortho[i]);
    );


    \\Deuxième étape : j'ai pas encore tout compris mais je l'ai écrit
    k = 2;

    my(mu_tmp, B_tmp, b_tmp, mu_k_tmp, t);

    while(k<=n,

        [b, mu] = RED(k, k-1, b, mu);

        if( (B[k]) <  ((3/4)-(mu[k][k-1] ^ 2)) *B[k-1] ,
            mu_tmp = mu[k][k-1];
            B_tmp = B[k] + mu_tmp^2 * B[k-1];
            mu[k][k-1] = mu_tmp*B[k-1]/B_tmp;

            B[k] = B[k-1]*B[k]/B_tmp;
            B[k-1] = B_tmp;

            b_tmp = b[k];
            b[k] = b[k-1];
            b[k-1] = b_tmp;

            if(k>2,
                for(j = 1, k-2,
                    mu_k_tmp = mu[k][j];
                    mu[k][j] = mu[k-1][j];
                    mu[k-1][j] = mu_k_tmp;
                );
            );

            for(i = k+1, n,
                t = mu[i][k];
                mu[i][k] = mu[i][k-1] - mu_tmp*t;
                mu[i][k-1] = t + mu[k][k-1]*mu[i][k];
            );
            k = max(2, k-1),


            \\ else
            forstep(l=k-2, 1, -1,
                [b, mu] = RED(k,l, b, mu);
            );
            k = k+1;
        );

    );
    return(b);

}


\\ Fonction de test de l'Algorithme LLL
test() = {
    my(n, A, M, w, A1, Mess, s, b, res);

    \\ taille du crytposysteme
    n = 50;
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
    b = LLL(b);

    for(i=1, n+1,
        res = 0;
        for(j = 1, n,
            res +=b[i][j]*A1[j];
        );
        if(res == s, return(1));
    );
    return(0);

}

main() = {
    my(n, res, i);
    \\ nombre de test qu'on fait
    n = 500;
    res = 0;
    for(i = 1, n,
        res += test();
    );
    print(res, "/", n);
}

main();
