gap> START_TEST("Forms: test_forms16.tst");
gap> q := 5;
5
gap> f := GF(q^4);
GF(5^4)
gap> mat := NullMat(3,3,f);
[ [ 0*Z(5), 0*Z(5), 0*Z(5) ], [ 0*Z(5), 0*Z(5), 0*Z(5) ], 
  [ 0*Z(5), 0*Z(5), 0*Z(5) ] ]
gap> mat[1][2] := Z(q^4);
Z(5^4)
gap> mat[2][1] := Z(q^4)^(q^2);
Z(5^4)^25
gap> mat[3][3] := Z(q)^0;
Z(5)^0
gap> form := HermitianFormByMatrix(mat,GF(q^4));
< hermitian form >
gap> v := f^3;
( GF(5^4)^3 )
gap> lines := Subspaces(v,1);
Subspaces( ( GF(5^4)^3 ), 1 )
gap> matrices := List(lines,x->BasisVectors(Basis(x)));;
gap> vectors := List(matrices,x->x[1]);;
gap> results := Collected(List(vectors,x->EvaluateForm(form,x,x)));;
gap> [Zero(f),q^6+1] in results;
true
gap> results := Collected(List(matrices,x->EvaluateForm(form,x,x)));;
gap> [[[Zero(f)]],q^6+1] in results;
true
gap> Number(vectors,x->IsIsotropicVector(form,x))=q^6+1;
true
gap> Number(matrices,x->IsTotallyIsotropicSubspace(form,x))=q^6+1;
true
gap> STOP_TEST("test_forms16.tst", 10000 );
