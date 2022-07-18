#ifndef CC_H
#define CC_H
#include "emscripten.h"
#include "emscripten/fetch.h"

//#include "emscripten/emscripten.h"
//#include "emscripten/websocket.h"
#include <stdio.h>
#include <time.h>
#include <sys/stat.h>
#include <stdio.h>

#include <assert.h>
#include <stdlib.h>
#include <string.h>

void getFileLockFromUrl(char url[], char fn[]);

void myWriteDate(char fn[], const char *data, int size)
{
  printf("write data %s %d",data,size);
  FILE *file = fopen(fn, "wb");
  // assert(file);
  if (!file){
    printf("cant write data %s %d",data,size);
    return;
  }
  fwrite(data, 1, size, file);
  fclose(file);
}

void downloadSucceeded(emscripten_fetch_t *fetch)
{
  printf("Finished3 downloading %llu bytes from URL %s.\n", fetch->numBytes, fetch->url);
  // The data is now available at fetch->data[0] through fetch->data[fetch->numBytes-1];
   char fn[256];
  getFileLockFromUrl(fetch->url,fn);
  myWriteDate(fn, fetch->data, fetch->numBytes) ;
  emscripten_fetch_close(fetch); // Free data associated with the fetch.
  endDownload2(0);
}

void downloadFailed(emscripten_fetch_t *fetch)
{
  printf("Downloading2 %s failed, HTTP failure status code: %d.\n", fetch->url, fetch->status);
  emscripten_fetch_close(fetch); // Also free data on failure.
  endDownload2(0);
}


void downloadProgress(emscripten_fetch_t *fetch)
{
  printf("Downloading3 %s.. %.2f%%s complete. HTTP readyState: %d. HTTP status: %d.\n"
         "HTTP statusText: %s. Received chunk [%llu, %llu[\n",
         fetch->url, fetch->totalBytes > 0 ? (fetch->dataOffset + fetch->numBytes) * 100.0 / fetch->totalBytes : (fetch->dataOffset + fetch->numBytes),
         fetch->totalBytes > 0 ? "%" : " bytes",
         fetch->readyState, fetch->status, fetch->statusText,
         fetch->dataOffset, fetch->dataOffset + fetch->numBytes);

  // Process the partial data stream fetch->data[0] thru fetch->data[fetch->numBytes-1]
  // This buffer represents the file at offset fetch->dataOffset.
 
  

  for (size_t i = 0; i < fetch->numBytes; ++i)
    ; // Process fetch->data[i];
}
void create_file()
{
  FILE *file = fopen("/rrrr/hello_file.txt", "wb");
  // assert(file);
  if (!file)
    return;
  const char *data = "Hello world";
  const char *data2 = "da";
  const char *data3 = "ta!";
  fwrite(data, 1, strlen(data), file);
  fseek(file, 8, 0 /*SEEK_SET*/);
  fwrite(data3, 1, strlen(data3), file);
  fseek(file, 6, 0 /*SEEK_SET*/);
  fwrite(data2, 1, strlen(data2), file);
  fclose(file);
}
/*void persistFileToIndexedDB(const char *outputFilename, uint8_t *data, size_t numBytes) {
  emscripten_fetch_attr_t attr;
  emscripten_fetch_attr_init(&attr);
  strcpy(attr.requestMethod, "EM_IDB_STORE");
  attr.attributes = EMSCRIPTEN_FETCH_REPLACE | EMSCRIPTEN_FETCH_PERSIST_FILE;
  attr.requestData = (char *)data;
  attr.requestDataSize = numBytes;
  attr.onsuccess = success;
  attr.onerror = failure;
  emscripten_fetch(&attr, outputFilename);
}*/
int myMkdir(const char fn[])
{
  char zz[256];
  int c = 0;
  for (int i = 0; fn[i]; ++i)
  {
    if (fn[i] == '/')
    {
      if (c != 0)
      {
        zz[c] = 0;
        int status = mkdir(zz, 0777 /*__S_IWRITE*/);
        printf("mkdir3  %d %s.\n", status,zz);
      }
    }
    zz[c++] = fn[i];
  }
}
void wasmDownload(char path[])
{
  char fn[256];
  getFileLockFromUrl(path,fn);
  myMkdir(path);

  emscripten_fetch_attr_t attr;
  emscripten_fetch_attr_init(&attr);
  strcpy(attr.requestMethod, "GET");
  attr.attributes = EMSCRIPTEN_FETCH_LOAD_TO_MEMORY  ;
  attr.onsuccess = downloadSucceeded;
  attr.onerror = downloadFailed;
  //attr.onprogress = downloadProgress;
  emscripten_fetch(&attr, path);
}

void wasmDownload2(char path[])
{
  printf("start4 downloading %s bytes from URL .\n", path);
  emscripten_fetch_attr_t attr;
  emscripten_fetch_attr_init(&attr);
  strcpy(attr.requestMethod, "GET");
  attr.attributes = EMSCRIPTEN_FETCH_LOAD_TO_MEMORY | EMSCRIPTEN_FETCH_SYNCHRONOUS;
  emscripten_fetch_t *fetch = emscripten_fetch(&attr, "http://localhost:4000/resources/texel_checker.png"); // Blocks here until the operation is complete.
  if (fetch->status == 200)
  {
    printf("Finished downloading %llu bytes from URL %s.\n", fetch->numBytes, fetch->url);
    // The data is now available at fetch->data[0] through fetch->data[fetch->numBytes-1];
  }
  else
  {
    printf("Downloading %s failed, HTTP failure status code: %d.\n", fetch->url, fetch->status);
  }
  emscripten_fetch_close(fetch);
}
void msleep(int msec)
{
  struct timespec ts;
  int res;

  if (msec < 0)
    return;

  ts.tv_sec = msec / 1000;
  ts.tv_nsec = (msec % 1000) * 1000000;

  do
  {
    res = nanosleep(&ts, &ts);
  } while (res);

  return;
} /**/

int __attribute__((used)) endDownload2(int proc_id);

int __attribute__((used)) endDownload(int proc_id)
{
  return endDownload2(proc_id);
}


int wssRecive2(char* proc_id);

int __attribute__((used)) wssRecive(char* proc_id)
{
  return wssRecive2(proc_id);
}


/*EM_BOOL onopen(int eventType, const EmscriptenWebSocketOpenEvent *websocketEvent, void *userData) {
    puts("onopen");

    EMSCRIPTEN_RESULT result;
    result = emscripten_websocket_send_utf8_text(websocketEvent->socket, "My name is John");
    if (result) {
        printf("Failed to emscripten_websocket_send_utf8_text(): %d\n", result);
    }
    return EM_TRUE;
}
EM_BOOL onerror(int eventType, const EmscriptenWebSocketErrorEvent *websocketEvent, void *userData) {
    puts("onerror");

    return EM_TRUE;
}
EM_BOOL onclose(int eventType, const EmscriptenWebSocketCloseEvent *websocketEvent, void *userData) {
    puts("onclose");

    return EM_TRUE;
}
EM_BOOL onmessage(int eventType, const EmscriptenWebSocketMessageEvent *websocketEvent, void *userData) {
    puts("onmessage");
    if (websocketEvent->isText) {
        // For only ascii chars.
        printf("message: %s\n", websocketEvent->data);
    }

    EMSCRIPTEN_RESULT result;
    result = emscripten_websocket_close(websocketEvent->socket, 1000, "no reason");
    if (result) {
        printf("Failed to emscripten_websocket_close(): %d\n", result);
    }
    return EM_TRUE;
}

void wasmWssConnect(char path[]){
    if (!emscripten_websocket_is_supported()) {
        return ;
    }
    EmscriptenWebSocketCreateAttributes ws_attrs = {
        "wss://javascript.info/article/websocket/demo/hello",
        NULL,
        EM_TRUE
    };

    EMSCRIPTEN_WEBSOCKET_T ws = emscripten_websocket_new(&ws_attrs);
    emscripten_websocket_set_onopen_callback(ws, NULL, onopen);
    emscripten_websocket_set_onerror_callback(ws, NULL, onerror);
    emscripten_websocket_set_onclose_callback(ws, NULL, onclose);
    emscripten_websocket_set_onmessage_callback(ws, NULL, onmessage);
}/**/


#endif