unit uFLUICallback;
interface
uses uFLTypes;

procedure registerUIMessagesCallback(p: pointer; f: TUICallback); cdecl;
procedure sendUI(msgType: TMessageType; msg: PChar; len: Longword);

implementation
uses uFLIPC;

var uiCallbackPointer: pointer;
    uiCallbackFunction: TUICallback;

procedure engineMessageCallback(p: pointer; msg: PChar; len: Longword);
begin
    if len = 128 * 256 then uiCallbackFunction(uiCallbackPointer, mtPreview, msg, len)
end;

procedure registerUIMessagesCallback(p: pointer; f: TUICallback); cdecl;
begin
    uiCallbackPointer:= p;
    uiCallbackFunction:= f;

    registerIPCCallback(nil, @engineMessageCallback)
end;

procedure sendUI(msgType: TMessageType; msg: PChar; len: Longword);
begin
    uiCallbackFunction(uiCallbackPointer, msgType, msg, len)
end;

end.