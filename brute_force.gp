
\\ La valeur maximale des éléments de la liste.

max_valeur = 10000 ;




\\ Creer une liste.

creer_liste(taille_liste, max_valeur) = {

  my(a);

  a = vector(taille_liste);

  for(i = 1, taille_liste,
      a[i] = random(max_valeur);
  );
  return(a);
}






\\ Initialise le probleme : creer une liste, en choisi k elements et
\\ conserve la solution et renvoi la somme de ces k elements.

init_probleme(taille_liste) = {

  my(a, res, somme, resultat);

  a = creer_liste(taille_liste, max_valeur);
  res = vector(taille_liste);
  somme = 0 ;

  for(i = 1, taille_liste,
      k = random(4) +1;
      if(k % 2 == 1,
        res[i] = 1 ;
        somme += a[i];
      )
  );
  resultat = [a, res, somme];
  return(resultat);
}







\\ Donne le dernier element selectionne de la liste.

last_elem(suite) = {

  my(res = 0);

  for(i = 1, #suite,
    if(suite[i] == 1,
      res = i;
    );
  );
  return(res)
}







\\ Rembobine les combinaisons : ... (1, 7, 8) -> (1, 7, 9) -> (1, 8, 9) -> (1, 9, 10) -> (2, 3, 4) -> (2, 3, 5) ...

remettre_0(suite) = {

  my(sauvegarde, i, cmpt, max_ecrit);

  sauvegarde = suite;
  i = #suite ;
  while(suite[i] == 1,
    cmpt++;
    suite[i] = 0;
    i--;
  );

  while(suite[i] == 0 && i > 0,
    i--;
  );

  suite[i] = 0;
  max_ecrit = i + cmpt;

  for(j = i +1, min(#suite, max_ecrit +1),
    suite[j] = 1;
  );

  return(suite);
}





\\ Verifie si la combinaison trouvee est la bonne.

verif(solution, valeurs, somme) = {

  my(res = 0);

  for(i = 1, #solution,
    if(solution[i] == 1,
      res += valeurs[i]
    );
  );
  if(res == somme,
    return(1),

  \\ else
    return(0);
  );
}



\\ Teste tous les combinaison de k parmi n, k fixé.

combinaison(set, somme, n, k) = {

  my(solution, solution_max, echec, curseur);

  solution = vector(n);
  solution_max = vector(n);
  echec = vector(n);

  for(i = 1, k,
    solution[i] = 1;
    solution_max[n-k+i] = 1;
  );

  curseur = last_elem(solution);

  if(curseur == 0,
    return(0);
  );

  while(solution != solution_max,
    curseur = last_elem(solution);
    \\print(solution);
    if(curseur == n,
      solution = remettre_0(solution),

    \\ else
      solution[curseur] = 0;
      solution[curseur +1] = 1;
    );
    if(verif(solution, set, somme),
      return(solution);
    );
  );
  return(echec);
}







\\ Enumere tous les combinaison de k parmi n, pour tous les k.

enumeration(liste) = {

  my(val, n, somme, res, nul);

  val = liste[1];
  n = #val ;

  somme = liste[3];
  nul = vector(n);

  for(k = 1, n,
    res = combinaison(val, somme, n, k);
    if(res != nul,
      return(res);
    );
  );

}






\\ Algorithme de brute force.

Brute_Force(taille) = {

  my(liste, vec);

  liste = init_probleme(taille);
  print("Probleme : "liste);

  vec = enumeration(liste);
  print("Solution : "vec);
  print("

  ");
  return(vec);

}





main() = {

  for(i = 1, 100,

    Brute_Force(25);
  )
}
#
print(main());
#
