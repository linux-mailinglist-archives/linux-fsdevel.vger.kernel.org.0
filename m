Return-Path: <linux-fsdevel+bounces-356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0667C9409
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 12:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE598B20BD5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 10:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075D1EEC1;
	Sat, 14 Oct 2023 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="qN/5x1Yi";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="KBETBnQN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B193A6AB2
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Oct 2023 10:04:26 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2869FA2;
	Sat, 14 Oct 2023 03:04:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 7E9AE603B5;
	Sat, 14 Oct 2023 12:04:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697277861; bh=0C5M7Z31Klfz3IshezT5tCgRSv2DrwV8VHGho3xeedE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qN/5x1YihvyU23V9Xuh3vRkq6pruLjzWzYEbZgIFVbS/NgKul4Hmq/q7v6GUSbBm6
	 HoO78UupfMvY4Wa/ar2FvmSR4dApBadExZEW5pFFNEI+eFc0FTalpv6iksTK08+y6M
	 2nOBN7rhIorLRl1QD+/uyqEXGmh8Z2Eos8OVWNPECRpE8bPZ7Cn4EEhWDPsSuxcRrp
	 x61jZ1bzL3qWMxOFIIutU3ikrYSvd79QMoq+LSahAHz9poaZE1UtBkzKMG6eA//9/k
	 Oh2h6ybCwUoHFtAe6pRTbPhyQMQC/VXOGCr3AvRpOtKO+6w9jasgv7xFwVvtD8A/eH
	 vNWd1uXl/gs+g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 33Sb0r08LI3t; Sat, 14 Oct 2023 12:04:18 +0200 (CEST)
Received: from [192.168.1.6] (78-2-88-20.adsl.net.t-com.hr [78.2.88.20])
	by domac.alu.hr (Postfix) with ESMTPSA id 043C5603B2;
	Sat, 14 Oct 2023 12:04:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697277858; bh=0C5M7Z31Klfz3IshezT5tCgRSv2DrwV8VHGho3xeedE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KBETBnQNfkiAeIp997pml4E5hK/vpHaG80c996RwrllFUgS9qby7u02rsAUpwIRLR
	 hnj//jn7RvCKXGmyAT/0h+Czzsa/UbzKUhSkur9NKG05FNp67r11ppBnkuYyaHboWT
	 bbdqpgP65wnsU4DLodtkLpJiIulRoS12YiGwO2meNkq2EE1ZmiTQehLFt7kcvnCc0r
	 dOGCzg433Y1H4EMNMO+cGSS1wAc3Ci8J2SGiShWQ2ZOrWKyTKye0RZ9ewOQ70WzsSu
	 KvrrVbA71P1kiq6Me4Pje+GwTPcsq+0zgdmKzODWhe6d4rVEBR1MoCYa+c++9zywGs
	 mTuBqrju/inog==
Message-ID: <634f5fdf-e236-42cf-be8d-48a581c21660@alu.unizg.hr>
Date: Sat, 14 Oct 2023 12:04:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps
Content-Language: en-US
To: Yury Norov <yury.norov@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231011144320.29201-1-jack@suse.cz>
 <20231011150252.32737-1-jack@suse.cz> <ZSbo1aAjteepdmcz@yury-ThinkPad>
 <20231012122110.zii5pg3ohpragpi7@quack3> <ZSndoNcA7YWHXeUi@yury-ThinkPad>
 <021970ad-942a-4fe8-ac95-c8089527f7d2@alu.unizg.hr>
 <ZSoCt5+DybhpsuGv@yury-ThinkPad>
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZSoCt5+DybhpsuGv@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/14/23 04:53, Yury Norov wrote:
> On Sat, Oct 14, 2023 at 04:21:50AM +0200, Mirsad Goran Todorovac wrote:
>> On 10/14/2023 2:15 AM, Yury Norov wrote:
>>> Restore LKML
>>>
>>> On Thu, Oct 12, 2023 at 02:21:10PM +0200, Jan Kara wrote:
>>>> On Wed 11-10-23 11:26:29, Yury Norov wrote:
>>>>> Long story short: KCSAN found some potential issues related to how
>>>>> people use bitmap API. And instead of working through that issues,
>>>>> the following code shuts down KCSAN by applying READ_ONCE() here
>>>>> and there.
>>>>
>>>> I'm sorry but this is not what the patch does. I'm not sure how to get the
>>>> message across so maybe let me start from a different angle:
>>>>
>>>> Bitmaps are perfectly fine to be used without any external locking if
>>>> only atomic bit ops (set_bit, clear_bit, test_and_{set/clear}_bit) are
>>>> used. This is a significant performance gain compared to using a spinlock
>>>> or other locking and people do this for a long time. I hope we agree on
>>>> that.
>>>>
>>>> Now it is also common that you need to find a set / clear bit in a bitmap.
>>>> To maintain lockless protocol and deal with races people employ schemes
>>>> like (the dumbest form):
>>>>
>>>> 	do {
>>>> 		bit = find_first_bit(bitmap, n);
>>>> 		if (bit >= n)
>>>> 			abort...
>>>> 	} while (!test_and_clear_bit(bit, bitmap));
>>>>
>>>> So the code loops until it finds a set bit that is successfully cleared by
>>>> it. This is perfectly fine and safe lockless code and such use should be
>>>> supported. Agreed?
>>>
>>> Great example. When you're running non-atomic functions concurrently,
>>> the result may easily become incorrect, and this is what you're
>>> demonstrating here.
>>>
>>> Regarding find_first_bit() it means that:
>>>    - it may erroneously return unset bit;
>>>    - it may erroneously return non-first set bit;
>>>    - it may erroneously return no bits for non-empty bitmap.
>>>
>>> Effectively it means that find_first bit may just return a random number.
>>>
>>> Let's take another example:
>>>
>>> 	do {
>>> 		bit = get_random_number();
>>> 		if (bit >= n)
>>> 			abort...
>>> 	} while (!test_and_clear_bit(bit, bitmap));
>>>
>>> When running concurrently, the difference between this and your code
>>> is only in probability of getting set bit somewhere from around the
>>> beginning of bitmap.
>>>
>>> The key point is that find_bit() may return undef even if READ_ONCE() is
>>> used. If bitmap gets changed anytime in the process, the result becomes
>>> invalid. It may happen even after returning from find_first_bit().
>>>
>>> And if my understanding correct, your code is designed in the
>>> assumption that find_first_bit() may return garbage, so handles it
>>> correctly.
>>>
>>>> *Except* that the above actually is not safe due to find_first_bit()
>>>> implementation and KCSAN warns about that. The problem is that:
>>>>
>>>> Assume *addr == 1
>>>> CPU1			CPU2
>>>> find_first_bit(addr, 64)
>>>>     val = *addr;
>>>>     if (val) -> true
>>>> 			clear_bit(0, addr)
>>>>       val = *addr -> compiler decided to refetch addr contents for whatever
>>>> 		   reason in the generated assembly
>>>>       __ffs(val) -> now executed for value 0 which has undefined results.
>>>
>>> Yes, __ffs(0) is undef. But the whole function is undef when accessing
>>> bitmap concurrently.
>>>
>>>> And the READ_ONCE() this patch adds prevents the compiler from adding the
>>>> refetching of addr into the assembly.
>>>
>>> That's true. But it doesn't improve on the situation. It was an undef
>>> before, and it's undef after, but a 2% slower undef.
>>>
>>> Now on that KCSAN warning. If I understand things correctly, for the
>>> example above, KCSAN warning is false-positive, because you're
>>> intentionally running lockless.
>>>
>>> But for some other people it may be a true error, and now they'll have
>>> no chance to catch it if KCSAN is forced to ignore find_bit() entirely.
>>>
>>> We've got the whole class of lockless algorithms that allow safe concurrent
>>> access to the memory. And now that there's a tool that searches for them
>>> (concurrent accesses), we need to have an option to somehow teach it
>>> to suppress irrelevant warnings. Maybe something like this?
>>>
>>>           lockless_algorithm_begin(bitmap, bitmap_size(nbits));
>>> 	do {
>>> 		bit = find_first_bit(bitmap, nbits);
>>> 		if (bit >= nbits)
>>> 			break;
>>> 	} while (!test_and_clear_bit(bit, bitmap));
>>>           lockless_algorithm_end(bitmap, bitmap_size(nbits));
>>>
>>> And, of course, as I suggested a couple iterations ago, you can invent
>>> a thread-safe version of find_bit(), that would be perfectly correct
>>> for lockless use:
>>>
>>>    unsigned long _find_and_clear_bit(volatile unsigned long *addr, unsigned long size)
>>>    {
>>>           unsigned long bit = 0;
>>>           while (!test_and_clear_bit(bit, bitmap) {
>>>                   bit = FIND_FIRST_BIT(addr[idx], /* nop */, size);
>>>                   if (bit >= size)
>>>                           return size;
>>>           }
>>>
>>>           return bit;
>>>    }
>>
>> Hi, Yuri,
>>
>> But the code above effectively does the same as the READ_ONCE() macro
>> as defined in rwonce.h:
>>
>> #ifndef __READ_ONCE
>> #define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
>> #endif
>>
>> #define READ_ONCE(x)							\
>> ({									\
>> 	compiletime_assert_rwonce_type(x);				\
>> 	__READ_ONCE(x);							\
>> })
>>
>> Both uses only prevent the funny stuff the compiler might have done to the
>> read of the addr[idx], there's no black magic in READ_ONCE().
>>
>> Both examples would probably result in the same assembly and produce the
>> same 2% slowdown ...
>>
>> Only you declare volatile in one place, and READ_ONCE() in each read, but
>> this will only compile a bit slower and generate the same machine code.
> 
> The difference is that find_and_clear_bit() has a semantics of
> atomic operation. Those who will decide to use it will also anticipate
> associate downsides. And other hundreds (or thousands) users of
> non-atomic find_bit() functions will not have to pay extra buck
> for unneeded atomicity.
> 
> Check how 'volatile' is used in test_and_clear_bit(), and consider
> find_and_clear_bit() as a wrapper around test_and_clear_bit().
> 
> In other words, this patch suggests to make find_bit() thread-safe by
> using READ_ONCE(), and it doesn't work. find_and_clear_bit(), on the
> other hand, is simply a wrapper around test_and_clear_bit(), and
> doesn't imply any new restriction that test_and_clear_bit() doesn't.
> 
> Think of it as an optimized version of:
>           while (bit < nbits && !test_and_clear_bit(bit, bitmap)
>                  bit++;
> 
> If you think it's worth to try in your code, I can send a patch for
> you.
> 
> Thanks,
> Yury

After some thinking, your declaration:

>>>    unsigned long _find_and_clear_bit(volatile unsigned long *addr, unsigned long size)

OK, this makes "addr" a pointer to a volatile array of unsigned longs.

But to this I have an objection:

>           while (bit < nbits && !test_and_clear_bit(bit, bitmap)
>                  bit++;

Note that there is nothing magical in an atomic test_and_clear_bit():
it has to read entire (quad)word, remember the stat of the bit, clear it,
and write it back.

The problem is that LOCK prefix comes before the assembled instruction

LOCK BTR r/m32, imm8

so it would be executed atomically.

Otherwise there are no guarantees that other core wouldn't write its own
idea of the value.

But atomic test_and_clear_bit() is not a free lunch: you would LOCK the
bus for all cores except yours 32/64 times for each bit, per (quad)word tested.

That is 32/64 times more than it is optimal, and it looks like a real hog.

Do you see the difference?

Needless to say, your atomicity works for one bit, and nothing prevents i.e.
core 5 to modify/set atomically bits you have already tested and found clear ...

Ideally, you would use atomic ffs() which is compiled as a single and atomic BSF/BSR
instruction on x86.

BSR r32, r/m32

(Alternatively you might want BSL in your algorithm, scanning from the least
significant bit.)

Even better would be if we could also atomically clear that bit in memory and
have the instruction return its index.

Test is atomic because it is a single instruction, but it can also be prefixed
with a LOCK.

LOCK BSR reg, mem
LOCK BTR mem, reg

would unfortunately not work, because something unfortunate could change the
memory location in between.

But your proposed algorithm is nothing more atomic than

         bit = ffs(bitmap);
	test_and_clear_bit(bit, bitmap);

And only less efficient, since you use on average 16/32 bus LOCKs instead of
one assembly instruction BSR/BRL. Those LOCK prefixes would mean that the entire
set of cores is prevented from reading or modifying memory while the bus is
LOCKed, or only writes on smarted architectures with WRITE LOCK in assembly,
as reads won't hurt the process of test_and_clear_bit(), only might give an
out-of-sync value.

Whatever fancy C function or macro, it cannot outsmart the CPU instruction set if
the set doesn't have that one.

For x86/x86_64, I couldn't find an atomic instruction to find the first set bit
and atomically clear it, returning its value ... but it doesn't mean nobody else knows.

Regards,
Mirsad

