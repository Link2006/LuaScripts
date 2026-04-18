--Original Idea by VAdaPEGA
--Only tested with Sonic CD US 1.0, should work with other versions.

--Currently has *NO* zone checks, this *WILL* break palettes in other zones!
--Intended for Stardust Speedway! (7-X in Stage Select)
--This makes the background palette cycle to give more flair.

local AddrTbl = {0xFB5A, 0xFB74, 0xFB7A}

--Make sure we use the correct memory domain.
memory.usememorydomain("68K RAM")
while true do
	for key,addr in pairs(AddrTbl) do --Cycle through the addresses we have 
		--Copy the current vars into a table to cycle them afterwards.
		local Mem = {memory.read_u16_be(addr),memory.read_u16_be(addr+2),memory.read_u16_be(addr+4)}
		--Take the 2nd value, write it in place of the first
		--Repeat that for 3->2 and 1->3
		memory.write_u16_be(addr,Mem[2]) 
		memory.write_u16_be(addr+2,Mem[3])
		memory.write_u16_be(addr+4,Mem[1])
	end 
	for i=1,6 do --advance 6 frames
		emu.frameadvance();
	end 
end
