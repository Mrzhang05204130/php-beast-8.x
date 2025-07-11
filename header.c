
/*
 * You can modify this sign to disguise your encrypt file
 */
char encrypt_file_header_sign[] = {
	0xa2, 0x3f, 0xb4, 0x1a,
	0xf6, 0xb6, 0x84, 0x51
};

int encrypt_file_header_length = sizeof(encrypt_file_header_sign);
