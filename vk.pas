{$reference 'vkapi.dll'}
{$reference System.Web.Extensions.dll}
uses System.Collections.Generic, System.Web.Script.Serialization;
type 
  ObjArr = array of object;
var
  client:vkapiclient;
  
begin
  client:= new vkapiclient(6264357);
  writeln(client.GetAuthUrl('page', 'offline', 'token', '5.85', '', ''));
  client.SetToken('Your Token');
  client.SetVersion('5.85');
  var resp:string:=client.Method('users.get', 'user_ids=your uid', 'fields=photo_big');
  writeln(resp);
  var jss := new JavaScriptSerializer();
  var ava:= (jss.DeserializeObject(resp) as Dictionary<string, object>)['response'];
  var avatar:=ava as objarr;
  var a:= avatar[0] as Dictionary<string, object>;
  writeln(a['photo_big']);
  DownloadFile(a['photo_big'] as string, 'avatar.jpg');
  writeln('Файл загружен!');
  readln();
end.