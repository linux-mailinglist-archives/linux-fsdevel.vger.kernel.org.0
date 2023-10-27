Return-Path: <linux-fsdevel+bounces-1382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 936C07D9D75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 17:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3AF71C20FE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 15:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2DE38BAB;
	Fri, 27 Oct 2023 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.hr header.i=@alu.hr header.b="p2dSKeLx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="vXyuycej"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FFD381A3
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 15:51:12 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F9F196;
	Fri, 27 Oct 2023 08:51:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 3BDDA6019B;
	Fri, 27 Oct 2023 17:51:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
	t=1698421865; bh=bcp2l66R6isCMuWqZZo9LM2yUuFsYZafsOLfI4eojr8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p2dSKeLx0S15csZSw5jy516VWtCZLVCvznNMWujGKxr5mdRaGGzDlGsFXxhTaX7Rc
	 b/85ePFXxgoGX7TQNkekh5uq8cl6r68MaqzO1knOhP02Vpbxoa70uP8AXVPhnVZBII
	 qtpZmzlXmOQdepXmKKn5z6t4ybsNyNErIUOBWcjSFUdgU3geH/Ncy+k+9UT8Jrqv23
	 mf2wxWAs7/o1jj0l+9PpO0wgXJ5Q1YBXWu7VMB7lof9G88vUbpkOqjC7+4KGD4ccT9
	 ARH6Oh3/z0HahT1ZbGFMbcofKMqfM6J4V0tsGnrDTuo29BNCcsMW4ael9vACEtTC/X
	 Gq26bwOc4DXlA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F2S1zlzVpZyA; Fri, 27 Oct 2023 17:51:02 +0200 (CEST)
Received: from [IPV6:2001:b68:2:2600:646f:d9a1:a315:536c] (unknown [IPv6:2001:b68:2:2600:646f:d9a1:a315:536c])
	by domac.alu.hr (Postfix) with ESMTPSA id 0754660197;
	Fri, 27 Oct 2023 17:51:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1698421862; bh=bcp2l66R6isCMuWqZZo9LM2yUuFsYZafsOLfI4eojr8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vXyuycejpXwyGdwPS3vAJpQK8MRuc057Pqjh0f1kuS1WYzID6KOGPYFp3nWnHpEj9
	 TUXmaJNf7WwuMDhWAwehw7+nqapnDWhW+F9suBMbpyw59q7gSMjCzI7a5Ph4HAhZ90
	 P8F2g1wLi8+bBxBTNcEYANE79lsQVp8eijwcGo7YVz7UVnbMie/6BxKE8qIeC8Jddo
	 praGi3VAjTWooGVFiNUczXb4yMCrt7Vm0FL88sIsKT163ikI4gr/5Z/fRweMA58ABf
	 lyg0IG4JNkFTKf/pH50lUAvE0zfAj3tuH4joL7RSVI1RZTxqExtIXRMr0jZH1I3yra
	 c9A0gxwSnmWmQ==
Message-ID: <1e976d6e-b685-4adb-8bfb-6f7f910e5baf@alu.unizg.hr>
Date: Fri, 27 Oct 2023 17:51:02 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps
Content-Language: en-US
To: Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: kernel test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>,
 oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
References: <202310251458.48b4452d-oliver.sang@intel.com>
 <374465d3-dceb-43b1-930e-dd4e9b7322d2@rasmusvillemoes.dk>
 <ZTszoD6fhLvCewXn@yury-ThinkPad>
From: Mirsad Todorovac <mirsad.todorovac@alu.hr>
In-Reply-To: <ZTszoD6fhLvCewXn@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/2023 5:51 AM, Yury Norov wrote:
> On Wed, Oct 25, 2023 at 10:18:00AM +0200, Rasmus Villemoes wrote:
>> On 25/10/2023 09.18, kernel test robot wrote:
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed a 3.7% improvement of will-it-scale.per_thread_ops on:
>>
>> So with that, can we please just finally say "yeah, let's make the
>> generic bitmap library functions correct
> 
> They are all correct already.
> 
>> and usable in more cases"
> 
> See below.
> 
>> instead of worrying about random micro-benchmarks that just show
>> you-win-some-you-lose-some.
> 
> That's I agree. I don't worry about either +2% or -3% benchmark, and
> don't think that they alone can or can't justificate such a radical
> change like making all find_bit functions volatile, and shutting down
> a newborn KCSAN.
> 
> Keeping that in mind, my best guess is that Jan's and Misrad's test
> that shows +2% was against stable bitmaps; and what robot measured
> is most likely against heavily concurrent access to some bitmap in
> the kernel.
> 
> I didn't look at both tests sources, but that at least makes some
> sense, because if GCC optimizes code against properly described
> memory correctly, this is exactly what we can expect.
> 
>> Yes, users will have to treat results from the find routines carefully
>> if their bitmap may be concurrently modified. They do. Nobody wins if
>> those users are forced to implement their own bitmap routines for their
>> lockless algorithms.
> 
> Again, I agree with this point, and I'm trying to address exactly this.
> 
> I'm working on a series that introduces lockless find_bit functions
> based on existing FIND_BIT() engine. It's not ready yet, but I hope
> I'll submit it in the next merge window.
> 
> https://github.com/norov/linux/commits/find_and_bit
> 
> Now that we've got a test that presumably works faster if find_bit()
> functions are all switched to be volatile, it would be great if we get
> into details and understand:
>   - what find_bit function or functions gives that gain in performance;
>   - on what bitmap(s);

I am positive that your test_and_clear_bit() loop per bit wouldn't 
improve performance. No insult, but it has to:

- LOCK the bus
- READ the (byte/word/longword/quadword) from memory
- TEST the bit and remember the result in FLAGS
- CLEAR the bit
- WRITE back the entire byte/word/longword/quadword

So, instead of speeding up, you'd end up reading 64 times in the worst 
case where only the last bit in the quadword is set.

What we need is this ffs() that expands to assembly instruction BSF
(bit scan forward)

  [1] https://www.felixcloutier.com/x86/bsf

followed by a BTR (bit test and reset)

  [2] https://www.felixcloutier.com/x86/btr

Ideally, we'd have an instruction that does both, and atomic, or a way 
to LOCK the bus for two instructions. But bad guys could use that to 
stall all cores indefinitely:

DON'T DO THIS!
-----------------------------
      LOCK
loop:
      BSF r16, m16/m32/m64
      BTR m16/m32/m64, r16
      JMP loop
      UNLOCK
-----------------------------

This would better work with the hardware-assisted CAM locking device, 
than stopping all cores from reading and writing on each memory barrier.

But this is a long story.

>   - is the reason in concurrent memory access (guess yes), and if so,
>   - can we refactor the code to use lockless find_and_bit() functions
>     mentioned above;
>   - if not, how else can we address this.
> 
> If you or someone else have an extra time slot to get deeper into
> that, I'll be really thankful.

I don't know if the Linux kernel uses any advantage of a trasnactional 
memory device if it finds one?

The idea of each mutex() or even user-space futex() stalling all cores 
to "asm LOCK CMPXCHG m8/m16/m32/m64, r8/r16/r32/r64" simply doesn't 
scale well with i.e. 128 cores that have to wait for one long 
read-modify-write cycle that bypasses cache and talks to very slow memory.

I see some progress with per-CPU variables.

[3] 
https://stackoverflow.com/questions/58664496/locking-on-per-cpu-variable/67997961#67997961

For multiprocessor system and to protect percpu variables, we can just 
disable preemption and do local_irq_save. This way we avoid taking the 
spinlock. Spinlock requires atomicity across multiple CPU's. With per 
cpu variables it shall not be required.

	local_irq_save(flags);
	preempt_disable();
	-- Modify the percpu variable
	preempt_enable();
	local_irq_restore(flags);

That compiles roughly to:

	unsigned long flags;

	asm volatile("cli": : :"memory");
	asm volatile(
		"mrs	%0, " IRQMASK_REG_NAME_R " @local_save_flags"
		: "=r" (flags) : : "memory", "cc");
	preempt_count_inc();
	__asm__ __volatile__("": : :"memory")  // barrier()
	--- your stuff here ---
	if (!(!(flags & X86_EFLAGS_IF))
		asm volatile("sti": : :"memory");
	__asm__ __volatile__("": : :"memory")  // barrier()
	preempt_count_dec();

With this code other CPUs can work in parallel. None of the CPU spins.

If we take spinlock then we modify an atomic variable also other CPU 
comes then it has to wait/spin if spinlock is acquired.

Best regards,
Mirsad


> Thanks,
> Yury

