# test code for recognition, only testing whether no errors are thrown.
g := Sp(6,3);
forms := PreservedSesquilinearForms(g);
g := SU(4,3);
forms := PreservedSesquilinearForms(g);
g := SO(1,4,3);
forms := PreservedSesquilinearForms(g);
g := SO(1,4,4);
forms := PreservedSesquilinearForms(g);
g := SO(-1,4,3);
forms := PreservedSesquilinearForms(g);
g := SO(5,3);
forms := PreservedSesquilinearForms(g);
quit;
