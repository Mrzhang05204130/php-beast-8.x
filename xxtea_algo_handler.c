/**
 * Base64 encrypt algorithms handler module for Beast
 * @author: liexusong
 */

#include <stdlib.h>
#include <string.h>
#include "beast_log.h"
#include "beast_module.h"
#include "xxtea.h"
char* testString2 = "494153555045524D414E21";

void tallymarker_hextobin(char * str, char * bytes, size_t blen)
{
   unsigned char  pos;
   unsigned char  idx0;
   unsigned char  idx1;

   // mapping of ASCII characters to hex values
   const unsigned char hashmap[] =
   {
     0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, // 01234567
     0x08, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // 89:;<=>?
     0x00, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x00, // @ABCDEFG
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // HIJKLMNO
   };

   memset(bytes, 0, blen);
   for (pos = 0; ((pos < (blen*2)) && (pos < strlen(str))); pos += 2)
   {
      idx0 = ((unsigned char)str[pos+0] & 0x1F) ^ 0x10;
      idx1 = ((unsigned char)str[pos+1] & 0x1F) ^ 0x10;
      bytes[pos/2] = (unsigned char)(hashmap[idx0] << 4) | hashmap[idx1];
   };
}

int xxtea_encrypt_handler(char *inbuf, int len,
        char **outbuf, int *outlen)
{
    char *result;
    size_t reslen;
    char* key;

    key = malloc(strlen(testString2)+1);
    memset(key, 0, strlen(testString2)+1);
    tallymarker_hextobin(testString2,key,strlen(testString2)/2);

    beast_write_log(beast_log_debug,"begin to xxtea encrypt handler  %s %d %s",__FILE__,__LINE__,key);
    result = xxtea_encrypt((void*)inbuf, len,key, &reslen);
    if (!result) {
        return -1;
    }

    for(int i=0;i<reslen;i++){
        char* p =(char*)result;
        p=p+i;
        char a = *p;
        *p=a^0xff;
    }

    *outbuf = result;
    *outlen = reslen;

    free((void*)key);

    return 0;
}


int xxtea_decrypt_handler(char *inbuf, int len,
        char **outbuf, int *outlen)
{
    char *result;
    size_t reslen;
    char* key;

    key = malloc(strlen(testString2)+1);
    memset(key, 0, strlen(testString2)+1);
    tallymarker_hextobin(testString2,key,strlen(testString2)/2);
    /*beast_write_log(beast_log_debug,"begin to xxtea dencrypt handler  %s %d %s",__FILE__,__LINE__,key);*/

    for(int i=0;i<len;i++){
        char* p =(char*)inbuf;
        p=p+i;
        char a = *p;
        *p=a^0xff;
    }
    /*beast_write_log(beast_log_debug,"begin to xxtea encrypt handler  %s %d %s",__FILE__,__LINE__,key);*/
    result = xxtea_decrypt((void*)inbuf, len,key, &reslen);
    if (!result) {
        return -1;
    }

    *outbuf = result;
    *outlen = reslen;

    free((void*)key);

    return 0;
}


void xxtea_free_handler(void *ptr)
{
    if (ptr) {
        free(ptr);
    }
}


struct beast_ops xxtea_handler_ops = {
    "xxtea-algo",
    xxtea_encrypt_handler,
    xxtea_decrypt_handler,
    xxtea_free_handler,
    NULL
};

