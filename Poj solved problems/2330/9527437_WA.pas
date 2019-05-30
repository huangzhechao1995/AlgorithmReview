program poj2330;
 const maxn=50;
 var i,j,n,m,p,q,lx,ly,k:longint;
 map:array[-maxn*8..maxn*8,-maxn*8..maxn*8] of char;
 a:array[1..maxn,1..maxn] of longint;
 linex,liney:longint;
 minx,miny,maxx,maxy:longint;
procedure openfile;
 begin
 assign(input,'poj2330.in');
 assign(output,'poj2330.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure draw(x,y:longint);
 var i:longint;
 begin
 //------------
 map[x,y]:='+';
 map[x,y+4]:='+';
 map[x-3,y]:='+';
 map[x-3,y+4]:='+';
 map[x-2,y+6]:='+';
 map[x-5,y+2]:='+';
 map[x-5,y+6]:='+';
 //------------
 for i:=1 to 3 do
  begin
  map[x,y+i]:='-';
  map[x-3,y+i]:='-';
  map[x-5,y+i+2]:='-';
  end;
 //------------
 map[x-1,y]:='|'; map[x-2,y]:='|';
 map[x-1,y+4]:='|'; map[x-2,y+4]:='|';
 map[x-3,y+6]:='|'; map[x-4,y+6]:='|';
 //------------
 map[x-4,y+1]:='/'; map[x-4,y+5]:='/'; map[x-1,y+5]:='/';
 //------------
 for i:=1 to 3 do
  begin
  map[x-1,y+i]:=' ';
  map[x-2,y+i]:=' ';
  map[x-4,y+1+i]:=' ';
  end;
 map[x-2,y+5]:=' ';
 map[x-3,y+5]:=' ';
 end;
begin
// openfile;
 fillchar(map,sizeof(map),'.');
 readln(n,m);
 for i:=1 to n do
  for j:=1 to m do
  read(a[i,j]);
 linex:=0; liney:=0;
 for i:=1 to n do
  begin
   for j:=1 to m do
    for k:=1 to a[i,j] do
    draw(linex-3*k+3,4*j-4+liney);
   linex:=linex+2; liney:=liney-2;
  end;
 for i:=-maxn*8 to maxn*8 do
  for j:=-maxn*8 to maxn*8 do
  if map[i,j]<>'.' then
  begin
   if i<minx then minx:=i;
   if i>maxx then maxx:=i;
   if j<miny then miny:=j;
   if j>maxy then maxy:=j;
  end;
 for i:=minx to maxx do
  begin
  for j:=miny to maxy do
   write(map[i,j]);
  writeln;
  end;
// closefile;
end.