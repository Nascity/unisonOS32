extern "C" void kmain(void)
{
	((unsigned short*)0xb8000)[0] = 'A' | 0x0F << 8;
}
