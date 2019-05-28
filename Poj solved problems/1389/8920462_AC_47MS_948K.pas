program poj1389;
 type arr=record
  x1,y1,x2,y2:longint;
 end;
 var i,j,n,p,m,q,l,r,k:longint;
 x1,x2,y1,y2:longint;
 a:array[1..1000] of arr;
 matrix:array[1..10000] of arr;
 tot,ans,time:longint;
procedure openfile;
 begin
 assign(input,'poj1389.in');
 assign(output,'poj1389.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
procedure add(x1,y1,x2,y2:longint);
 begin
 inc(tot);
 matrix[tot].x1:=x1; matrix[tot].x2:=x2;
 matrix[tot].y1:=y1; matrix[tot].y2:=y2;
 end;
procedure work(x1,y1,x2,y2,p:longint);
//var i,j,k1,:longint;
 begin
 if p=0 then begin add(x1,y1,x2,y2); exit; end;
 while (p>0)and((x1>matrix[p].x2)or(x2<matrix[p].x1)or(y1>matrix[p].y2)or(y2<matrix[p].y1)) do
  begin work(x1,y1,x2,y2,p-1); exit; end;
 if x1<matrix[p].x1 then
  begin work(x1,y1,matrix[p].x1,y2,p-1); x1:=matrix[p].x1; end;
 if x2>matrix[p].x2 then
  begin work(matrix[p].x2,y1,x2,y2,p-1); x2:=matrix[p].x2; end;
 if y1<matrix[p].y1 then
  work(x1,y1,x2,matrix[p].y1,p-1);
 if y2>matrix[p].y2 then
  work(x1,matrix[p].y2,x2,y2,p-1);
 end;
begin
 //openfile;
 readln(x1,y1,x2,y2);
for time:=1 to 10000 do
 begin
 n:=0;
 while (x1<>-1)or(y1<>-1)or(x2<>-1)or(y2<>-1) do
  begin
  inc(n); a[n].x1:=x1; a[n].x2:=x2; a[n].y1:=y1; a[n].y2:=y2;
  readln(x1,y1,x2,y2);
  end;
 tot:=0;
 for i:=1 to n do
  work(a[i].x1,a[i].y1,a[i].x2,a[i].y2,tot);
 ans:=0;
 for i:=1 to tot do
  ans:=ans+(matrix[i].x1-matrix[i].x2)*(matrix[i].y1-matrix[i].y2);
 writeln(ans);
 readln(x1,y1,x2,y2);
 if (x1=-1)and(x2=-1)and(y1=-1)and(y2=-1) then break;
 end;
// closefile;
end.