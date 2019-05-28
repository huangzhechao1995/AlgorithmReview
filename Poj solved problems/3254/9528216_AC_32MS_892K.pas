program poj3254;
 const modd=100000000;
 var i,j,n,m,p,q,l,r,k:longint;
 er:Array[0..15] of longint;
 stage:array[1..250] of longint;
 a:array[1..15] of longint;
 f:array[0..15,1..250] of longint;
 tot,ans:longint;
procedure openfile;
 begin
 assign(input,'poj3254.in');
 assign(output,'poj3254.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure select;
 var i,j,p:longint;
 begin
 for i:=0 to er[m]-1 do
  //begin
  if (i shl 1)and i=0 then
   begin
   inc(tot); stage[tot]:=i;
   end;
  //end;
 end;
begin
// openfile;
 readln(n,m);
 er[0]:=1;
 for i:=1 to m do
  er[i]:=1 shl i;
 select;
 for i:=1 to n do
 // begin
  for j:=1 to m do
   begin
   read(p);
   if p=1 then
   a[i]:=a[i] or er[j-1];
   end;
//  end;
 f[0,1]:=1;
 for i:=1 to n do
  for k:=1 to tot do
  if stage[k] or a[i]=a[i] then
  for j:=1 to tot do
  if stage[j] and stage[k]=0 then
   f[i][k]:=(f[i-1][j]+f[i][k])mod modd;
 for j:=1 to tot do
  ans:=(ans+f[n,j])mod modd;
 writeln(ans);
// closefile;
end.