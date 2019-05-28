program poj1061;
  var a,b,t,x,y,x1,y1,n,m,l,p : int64;
  
  function gcd(a,b:int64):int64;
    begin
      if b = 0 then
         begin
           x := 1; y := 0;  exit(a);
         end;
      gcd := gcd(b,a mod b);
      t := x; x := y; y := t - (a div b) * y;
    end;
  
  begin
    readln(x1,y1,n,m,l);
    if n > m then begin  b := y1-x1; a := n-m; end
             else begin  b := x1-y1; a := m-n; end;   \
    p := gcd(a,l);
    if b mod p <> 0 then writeln('Impossible') else
       begin
         x := x * (b div p); l := l div p;
         if x <= 0 then x := x + l * ((-x-1) div l + 1); 
         x  := x mod l;
         writeln(x);
       end;
  end.
