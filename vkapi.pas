library VKAPI;

uses System.Collections.Generic, System.Web, System.IO, System.Net;
{
https://vk.com/nukdokplex
NukDotCom Team
}
const
  methodendpoint = 'https://api.vk.com/method/';

type
  VKAPIClient = class
  private 
    token: string;
    client_id: integer;
    v: string;
  public 
    constructor(client_id: integer);
    function GetAuthUrl(display, scope, response_type, v, state, revoke: string): string;
    procedure SetToken(tk: string);
    function Method(method: string; params parameters: array of string): string;
    procedure SetVersion(v: string);
  end;

function VKAPIClient.GetAuthUrl(display, scope, response_type, v, state, revoke: string): string;
var
  url: string;
begin
  url := 'https://oauth.vk.com/authorize?client_id=' + client_id +
  '&display=' + display + '&scope=' + scope + '&response_type=' + response_type +
  '&v=' + v + '&state=' + state + '&revoke=' + revoke;
  GetAuthUrl := url;
end;

procedure vkapiclient.SetToken(tk: string);
begin
  token := tk;
end;

constructor VKAPIClient.Create(client_id: integer);
begin
  Self.client_id := client_id;
end;

procedure VKAPIClient.SetVersion(v: string);
begin
  self.v := v;
end;

function VKAPIClient.Method(method: string; params parameters: array of string): string;
var
  json: string;
  url: string;
begin
  url := methodendpoint + method + '?access_token=' + self.token + '&v=' + self.v + '&';
  var prms := new StringBuilder;
  for var i := 0 to parameters.Length - 1 do 
  begin
    if i = parameters.Length - 1 then prms.Append(parameters[i])
    else prms.Append(parameters[i] + '&');
  end;
  url+=prms.ToString();
  var request: HTTPWebRequest := HTTPWebRequest(WebRequest.Create(url));
  request.Method := 'GET';
  var resp: WebResponse := request.GetResponse();
  var sr: StreamReader := new StreamReader(resp.GetResponseStream(), System.Text.Encoding.UTF8);
  json := sr.ReadToEnd();
  sr.Close();
  resp.Close();
  Result := json;
end;

procedure DownloadFile(url, fname: string);
begin
  var wclient := new WebClient();
  wclient.DownloadFile(new System.Uri(url), fname);
end;



end.
