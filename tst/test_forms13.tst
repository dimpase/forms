gap> START_TEST("Forms: test_forms13.tst");
gap> q := 9;
9
gap> f := GF(q);
GF(3^2)
gap> dim := 3;
3
gap> v := f^dim;
( GF(3^2)^3 )
gap> mat := IdentityMat(dim,f);
[ [ Z(3)^0, 0*Z(3), 0*Z(3) ], [ 0*Z(3), Z(3)^0, 0*Z(3) ], 
  [ 0*Z(3), 0*Z(3), Z(3)^0 ] ]
gap> form := QuadraticFormByMatrix(mat,f);
< quadratic form >
gap> lines := Subspaces(v,1);
Subspaces( ( GF(3^2)^3 ), 1 )
gap> matrices := List(lines,x->BasisVectors(Basis(x)));;
gap> vectors := List(matrices,x->x[1]);;
gap> results := Collected(List(vectors,x->EvaluateForm(form,x)));;
gap> [Zero(f),(q^(dim-1)-1)/(q-1)] in results;
true
gap> results := Collected(List(matrices,x->x^form));;
gap> [[[Zero(f)]],(q^(dim-1)-1)/(q-1)] in results;
true
gap> Length(Filtered(vectors,x->IsSingularVector(form,x)))=(q^(dim-1)-1)/(q-1);
true
gap> Length(Filtered(matrices,x->IsTotallySingularSubspace(form,x)))=(q^(dim-1)-1)/(q-1);
true
gap> STOP_TEST("test_forms13.tst", 10000 );
