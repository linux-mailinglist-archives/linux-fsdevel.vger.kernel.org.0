Return-Path: <linux-fsdevel+bounces-54010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBA9AF9FE6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 13:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C96485832
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 11:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC1A253340;
	Sat,  5 Jul 2025 11:50:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149672E36FB;
	Sat,  5 Jul 2025 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751716237; cv=none; b=jypionyF9OFv4CwrZY6o3NgIn+UOnz3svFXx0G8ZNefgveSq2Npbj97OPRRgG2KbdBfjKZIci5K+zaGtpScgh/WQmPQG9gwEZhxbGsTf1tY8O5fXfaKgb9XETM/Fc2J/sn27YUJFIGad8JgY6ABzp6u1yfu9Mafy2W17ED1UaMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751716237; c=relaxed/simple;
	bh=sS9TzLWjySNQ7oXJqxvedN4gXCct98hT6bIjQgiugQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbk6eopyARWA9ugJsytt2sTxtFvuwbm9ncV2m0uaeUCDpcalRGkVZVh2vJFdxYP1oezjXNMFNYVTx1HkTPJxzXj6aoBwvn/HkLK70fJdIOyS6TdoSJ5a4oM3ro4ems1pq4TVtTuZpnu1PntfoNooQ6DoI5ZKLKfksvoZb8daVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bZ6pk3vqKz9syQ;
	Sat,  5 Jul 2025 12:55:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JFHckNlESQUx; Sat,  5 Jul 2025 12:55:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bZ6pk2fTFz9sy4;
	Sat,  5 Jul 2025 12:55:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 535538B7A9;
	Sat,  5 Jul 2025 12:55:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id wky-Rq-Yptn6; Sat,  5 Jul 2025 12:55:10 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E3ACB8B798;
	Sat,  5 Jul 2025 12:55:08 +0200 (CEST)
Message-ID: <3e9bff9f-1aaf-4e91-a6c0-328a343d18f1@csgroup.eu>
Date: Sat, 5 Jul 2025 12:55:06 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] powerpc: Implement masked user access
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: David Laight <david.laight.linux@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
 <20250622172043.3fb0e54c@pumpkin>
 <ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu>
 <20250624131714.GG17294@gate.crashing.org> <20250624175001.148a768f@pumpkin>
 <20250624182505.GH17294@gate.crashing.org> <20250624220816.078f960d@pumpkin>
 <83fb5685-a206-477c-bff3-03e0ebf4c40c@csgroup.eu>
 <20250626220148.GR17294@gate.crashing.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250626220148.GR17294@gate.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/06/2025 à 00:01, Segher Boessenkool a écrit :
> On Thu, Jun 26, 2025 at 07:56:10AM +0200, Christophe Leroy wrote:
>> Le 24/06/2025 à 23:08, David Laight a écrit :
>>> On Tue, 24 Jun 2025 13:25:05 -0500
>>> Segher Boessenkool <segher@kernel.crashing.org> wrote:
>>>>>> isel (which is base PowerPC, not something "e500" only) is a
>>>>>> computational instruction, it copies one of two registers to a third,
>>>>>> which of the two is decided by any bit in the condition register.
>>>>>
>>>>> Does that mean it could be used for all the ppc cpu variants?
>>>>
>>>> No, only things that implement architecture version of 2.03 or later.
>>>> That is from 2006, so essentially everything that is still made
>>>> implements it :-)
>>>>
>>>> But ancient things do not.  Both 970 (Apple G5) and Cell BE do not yet
>>>> have it (they are ISA 2.01 and 2.02 respectively).  And the older p5's
>>>> do not have it yet either, but the newer ones do.
>>
>> For book3s64, GCC only use isel with -mcpu=power9 or -mcpu=power10
> 
> I have no idea what "book3s64" means.

Well that's the name given in Linux kernel to the 64 bits power CPU 
processors. See commits subject:

f5164797284d book3s64/radix : Optimize vmemmap start alignment
58450938f771 book3s64/radix : Handle error conditions properly in 
radix_vmemmap_populate
9cf7e13fecba book3s64/radix : Align section vmemmap start address to 
PAGE_SIZE
29bdc1f1c1df book3s64/radix: Fix compile errors when 
CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP=n
d629d7a8efc3 powerpc/book3s64/hugetlb: Fix disabling hugetlb when fadump 
is active
5959ffabbb67 arch/powerpc: teach book3s64 
arch_get_unmapped_area{_topdown} to handle hugetlb mappings
8846d9683884 book3s64/hash: Early detect debug_pagealloc size requirement
76b7d6463fc5 book3s64/hash: Disable kfence if not early init
b5fbf7e2c6a4 book3s64/radix: Refactoring common kfence related functions
8fec58f503b2 book3s64/hash: Add kfence functionality
47dd2e63d42a book3s64/hash: Disable debug_pagealloc if it requires more 
memory
...

> 
> Some ancient Power architecture versions had something called
> "Book III-S", which was juxtaposed to "Book III-E", which essentially
> corresponds to the old aborted BookE stuff.
> 
> I guess you mean almost all non-FSL implementations?  Most of those
> support the isel insns.  Like, Power5+ (GS).  And everything after that.
> 
> I have no idea why you think power9 has it while older CPUS do not.  In
> the GCC source code we have this comment:

I think nothing, I just observed that GCC doesn't use it unless you tell 
it is power9 or power10. But OK, the comment explains why.

>    /* For ISA 2.06, don't add ISEL, since in general it isn't a win, but
>       altivec is a win so enable it.  */
> and in fact we do not enable it for ISA 2.06 (p8) either, probably for
> a similar reason.
> 
>>>> And all classic PowerPC is ISA 1.xx of course.  Medieval CPUs :-)
>>>
>>> That make more sense than the list in patch 5/5.
>>
>> Sorry for the ambiguity. In patch 5/5 I was addressing only powerpc/32,
>> and as far as I know the only powerpc/32 supported by Linux that has
>> isel is the 85xx which has an e500 core.
> 
> What is "powerpc/32"?  It does not help if you use different names from
> what everyone else does.

Again, that's the way it is called in Linux kernel, refer below commits 
subjects:

$ git log --oneline arch/powerpc/ | grep powerpc/32
2bf3caa7cc3b powerpc/32: Stop printing Kernel virtual memory layout
2a17a5bebc9a powerpc/32: Replace mulhdu() by mul_u64_u64_shr()
dca5b1d69aea powerpc/32: Implement validation of emergency stack
2f2b9a3adc66 powerpc/32s: Reduce default size of module/execmem area
5799cd765fea powerpc/32: Convert patch_instruction() to patch_uint()
6035e7e35482 powerpc/32: Curb objtool unannotated intra-function call 
warning
b72c066ba85a powerpc/32: fix ADB_CUDA kconfig warning
cb615bbe5526 powerpc/32: fix ADB_CUDA kconfig warning
c8a1634145c2 powerpc/32: Drop unused grackle_set_stg()
aad26d3b6af1 powerpc/32s: Implement local_flush_tlb_page_psize()
bac4cffc7c4a powerpc/32s: Introduce _PAGE_READ and remove _PAGE_USER
46ebef51fd92 powerpc/32s: Add _PAGE_WRITE to supplement _PAGE_RW
f84b727d132c powerpc/32: Enable POWER_RESET in pmac32_defconfig
a3ef2fef198c powerpc/32: Add dependencies of POWER_RESET for pmac32
7cb0094be4a5 powerpc/32s: Cleanup the mess in __set_pte_at()
6958ad05d578 powerpc/32: Rearrange _switch to prepare for 32/64 merge
fc8562c9b69a powerpc/32: Remove sync from _switch
...

It means everything built with CONFIG_PPC32

> 
> The name "powerpc32" is sometimes used colloquially to mean PowerPC code
> running in SF=0 mode (MSR[SF]=0), but perhaps more often it is used for
> 32-bit only implementations (so, those that do not even have that bit:
> it's bit 0 in the 64-bit MSR, so all implementations that have an only
> 32-bit MSR, for example).
> 
>> For powerpc/64 we have less constraint than on powerpc32:
>> - Kernel memory starts at 0xc000000000000000
>> - User memory stops at 0x0010000000000000
> 
> That isn't true, not even if you mean some existing name.  Usually
> userspace code is mapped at 256MB (0x10000000).  On powerpc64-linux
> anyway, different default on different ABIs of course :-)

0x10000000 is below 0x0010000000000000, isn't it ? So why isn't it true ?

On 64 bits powerpc, everything related to user is between 0 and 
TASK_SIZE_MAX.

TASK_SIZE_MAX is either TASK_SIZE_4PB or TASK_SIZE_64TB depending on 
page size (64k or 4k)

TASK_SIZE_4PB is 0x0010000000000000UL

Christophe

> 
>>> And for access_ok() avoiding the conditional is a good enough reason
>>> to use a 'conditional move' instruction.
>>> Avoiding speculation is actually free.
>>
>> And on CPUs that are not affected by Spectre and Meltdown like powerpc
>> 8xx or powerpc 603,
> 
> Erm.
> 
> 
> Segher


