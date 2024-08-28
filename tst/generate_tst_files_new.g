#create output and tst files from .g files in the tst/gap directory.
#Executing this file is NOT necessary for the installation of the package "forms" (including the documentation)

#Performing these steps, files will be written in the tst directory of the
#forms package tree. Under UNIX-like operating systems, you need sufficient
#permissions to do. Executing this is NOT necessary for the installation of the
#package "forms". This file is based on the generate_examples_files.g in the /forms/examples directory.

#to make sure tjere is no confusing with linebreaks, it seems better to have all input (in the .g files)
#in one (long) line.

#Messy things happen when you do it, so don't try this at home kids!

#create workspace with packages
LoadPackage("forms");
SaveWorkspace("forms.ws");
quit;

#restart gap now.

#initialize filenames

#initialisations to create .tst files from .g files in tst directory. Output will be in outputdir.

files := ["test_forms1", "test_forms2", "test_forms3", "test_forms4", "test_forms5",
            "test_forms6","test_forms7", "test_forms8", "test_forms9", "test_forms10",
            "test_forms11", "test_recog", "test_forms12", "test_forms13", "test_forms14",
            "test_forms15", "test_forms16" ];
            
files := ["test_preservedform"];

homedir := DirectoryCurrent();
scriptfile := Filename(homedir,"generate_output_forms_testfiles.sh");
PrintTo(scriptfile,"");

gapstart := "gap4r13.1"; #might be different on your computer
gap := Filename(Directory("/usr/local/bin/"),gapstart);
paths := JoinStringsWithSeparator(GAPInfo.RootPaths{[3,4]},";");
pathsstr := Concatenation("\"",paths,"\"");
sourcedir := DirectoriesPackageLibrary("forms","tst/gap")[1];
outputdir := DirectoriesPackageLibrary("forms","tst/output")[1];

filename := "conic";
#cmd := ["gap4r13.1 -l "./;/opt/gap-4.13.1/" -L forms.ws -c "LogTo(\"test.out\");" < conic.g]
#gap4r13.1 -l "./;/opt/gap-4.13.1/" -L forms.ws -c "LogTo(\"test.out\");" < conic.g

for filename in files do
inputfile := Filename(sourcedir,Concatenation(filename,".g"));
outputfile := Filename(outputdir,Concatenation(filename,".out"));
outputfilestr := Concatenation("\"LogTo(","\\\"",outputfile,"\\\"",");\"");
cmdlist := [gapstart,"-l",pathsstr,"-L","forms.ws","-o","4G","-c",outputfilestr,"<",inputfile,"\n"];
cmd := JoinStringsWithSeparator(cmdlist," ");
AppendTo(scriptfile,cmd);
od;

preambledir := DirectoriesPackageLibrary("forms","examples/")[1];
outputdir := DirectoriesPackageLibrary("forms","tst/output")[1];
cmddir := "dir \:\= DirectoriesPackageLibrary\(\"forms\"\,\"tst\/output\"\)\[1\]\;";

#create .tst files
#the nested ifs together with the SizeScreen make sure that input lines (plural),
#are written back in the tst file as one (long) input line.
includedir := DirectoriesPackageLibrary("forms","tst")[1];
for filename in files do
  i := Filename(outputdir,Concatenation(filename,".out"));
  o := Filename(includedir,Concatenation(filename,".tst"));
  PrintTo(o,"");
  input_stream := InputTextFile(i);
  ReadLine(input_stream); #reads first line which is a line with a #
  #ReadLine(input_stream);
  AppendTo(o,Concatenation("gap> START_TEST(\"Forms: ",filename,".tst\");\n"));
  line := ReadLine(input_stream);
  while line <> "gap> quit;\n" do
    if Length(line) > 3 then
        if line{[1..4]} = "gap>" then
            RemoveCharacters(line,"\n");
            line := Concatenation(line,"\n");
        fi;
    fi;
    SizeScreen([500,24]);
    AppendTo(o,line);
    SizeScreen([80,24]);
    line := ReadLine(input_stream);
  od;
  AppendTo(o,Concatenation("gap> STOP_TEST(\"",filename,".tst\", 10000 );\n"));
od;

#now write testall.g file.

o := Filename(includedir,"testall.g");
tstdir := DirectoriesPackageLibrary("forms","tst")[1];
part1 := Filename(tstdir,"template_part1.g");
input_stream := InputTextFile(part1);
PrintTo(o,ReadAll(input_stream));

AppendTo(o,"testfiles := [\n");
for i in [1..Length(files)-1] do
    filename := Concatenation(files[i],".tst");
    AppendTo(o,Concatenation("\"",filename,"\",\n"));
od;
filename := Concatenation(files[Length(files)],".tst");
AppendTo(o,Concatenation("\"",filename,"\"\n];\n\n"));

part2 := Filename(tstdir,"template_part2.g");
input_stream := InputTextFile(part2);
AppendTo(o,ReadAll(input_stream));
