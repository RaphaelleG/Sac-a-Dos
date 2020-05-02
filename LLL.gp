\\ renvoie le produit scalaire de deux vecteurs
scal(a, b) = {
    my(r , i);
    r = 0;
    for(i = 0, #a,
        r += a[i]*b[i];
    );
    return(r);
}




\\ b une base, donc un tableau de tableau

LLL(b) = {

    my(n = #b);

    \\ Première étape :Orthogonalisation de la base
    my(b_ortho, mu, B, i, j);

    b_ortho = vector(n); \\ la base orthonormée
    mu = vector(n);
    B = vector(n);
    b_ortho[1] = b[1];
    B[1] = scal(b_ortho[1], b_ortho[1]);

    for(i = 2, n,
        b_ortho[i] = b[i];
        for(j = 1, i-1,
            mu[i][j] = scal(b[i], b_ortho[j])/ B[j];
            b_ortho[i] -=mu[i][j]*b_ortho[j];
        );
        B[i]= scal(b_ortho[i], b_ortho[i]);
    );

    \\Deuxième étape : j'ai pas encore tout compris

}
