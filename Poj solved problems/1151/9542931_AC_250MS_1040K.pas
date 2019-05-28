program poj1151;
 type arr=record
  x1,y1,x2,y2:double;
  end;
 const inf=0.00000001;
 var
 x1,y1,x2,y2:double;
 ans:double;
 a:array[1..10000] of arr;
 i,j,n,m,p,q,l,r:longint;  tot,time:longint;
procedure openfile;
 begin
 assign(input,'poj1151.in');
 assign(output,'poj1151.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure cut(p:longint; x1,x2,y1,y2:double);
 begin
 while (p>=1)and((x1>a[p].x2-inf)or(x2<a[p].x1+inf)
     or(y1>a[p].y2-inf)or(y2<a[p].y1+inf)) do dec(p);
 if p=0 then
  begin
   inc(tot); a[tot].x1:=x1;  a[tot].x2:=x2; a[tot].y1:=y1;  a[tot].y2:=y2;
   ans:=ans+(x2-x1)*(y2-y1);
   exit;
  end;
 if x1<a[p].x1 then begin cut(p-1,x1,a[p].x1,y1,y2); x1:=a[p].x1; end;
 if x2>a[p].x2 then begin cut(p-1,a[p].x2,x2,y1,y2); x2:=a[p].x2; end;
 if y1<a[p].y1-inf then cut(p-1,x1,x2,y1,a[p].y1);
 if y2>a[p].y2+inf then cut(p-1,x1,x2,a[p].y2,y2);
 end;
begin

 readln(n);
 while n<>0 do
  begin
  inc(time);
   tot:=0; ans:=0;
   for i:=1 to n do
    begin
    readln(x1,y1,x2,y2);
    cut(tot,x1,x2,y1,y2);
    end;
   writeln('Test case #',time);
   writeln('Total explored area: ',ans:0:2);
   writeln;
  readln(n);
  end;

end.
