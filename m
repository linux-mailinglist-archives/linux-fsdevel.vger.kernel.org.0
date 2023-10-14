Return-Path: <linux-fsdevel+bounces-352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE237C924F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 04:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E1D0B20BF7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 02:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6302715BB;
	Sat, 14 Oct 2023 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="HxNWq3Uh";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="hXhmO1vZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F67E
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Oct 2023 02:22:01 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E78A9;
	Fri, 13 Oct 2023 19:21:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 9BD3A60152;
	Sat, 14 Oct 2023 04:21:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697250114; bh=JZSPijZWtC9fSzTN6rP8wgc/TQMAaBgOg7i84LxeGKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HxNWq3UhqmLMYPViHyiyuNCKpYA6Gu0Xp42sH1eqiDVpM2irQZP2lEHsSbbX1L34L
	 oMuzvGRauSRqdDxMOGDELw9FjHAX/ttqxiR9gvfKNDFYBbmM2mq5VN5TK5wIL92x9E
	 RVA7CZnaMqjXV6uVU2rkPciksGSuKcdrGlrMuBeDNFWaFawotg5+QON93JMXdnnrmk
	 JJRizrP7+olkUhugFlP+9f0WWZjZTbFnQJXGOH17TgsQbQhEkOItAYvJpR8mchdbId
	 2DPFoEb/iYMHswbIf+1uvgDQrVrKSh0YoQ+IrQeeuxGQqntwDPyNh8Se2am0wCsNCU
	 8eX6xwp+ap76w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LOMkYWKqLERe; Sat, 14 Oct 2023 04:21:51 +0200 (CEST)
Received: from [192.168.1.3] (78-2-88-84.adsl.net.t-com.hr [78.2.88.84])
	by domac.alu.hr (Postfix) with ESMTPSA id E737D6013C;
	Sat, 14 Oct 2023 04:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697250111; bh=JZSPijZWtC9fSzTN6rP8wgc/TQMAaBgOg7i84LxeGKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hXhmO1vZDJhlSprsnHhCCdZK3hYR1ynG4lrHImeLCV0HCKBSjTQxMAPPPoBNI5jcw
	 Ga/qUwspnF2ioKro4ziV4VMiB4A8Zm5jZ57baieYcB68lvSyPM6s9RfTUmQgholtF6
	 mR9wXkjYms4neFWIgIuzBGS6gEctiMsZq0wx3kRvRq4326D9h3vVaMKHKM3Q8pR9aw
	 J8L63VvYIXZXpCwLvJL51UXZRGzQe8/a7g0zwmw0T4B8Zu49XqfNgPGzBnQS5ClSUs
	 D6Q81owYqvuBua9s8OMUYN0oJwLcrsjstT8GB7vHXg5Jcxty8WYC8rcjm/udqXwPj2
	 yGVcXfLsbliPQ==
Message-ID: <021970ad-942a-4fe8-ac95-c8089527f7d2@alu.unizg.hr>
Date: Sat, 14 Oct 2023 04:21:50 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps
Content-Language: en-US
To: Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231011144320.29201-1-jack@suse.cz>
 <20231011150252.32737-1-jack@suse.cz> <ZSbo1aAjteepdmcz@yury-ThinkPad>
 <20231012122110.zii5pg3ohpragpi7@quack3> <ZSndoNcA7YWHXeUi@yury-ThinkPad>
From: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Autocrypt: addr=mirsad.todorovac@alu.unizg.hr; keydata=
 xjMEYp0QmBYJKwYBBAHaRw8BAQdAI14D1/OE3jLBYycg8HaOJOYrvEaox0abFZtJf3vagyLN
 Nk1pcnNhZCBHb3JhbiBUb2Rvcm92YWMgPG1pcnNhZC50b2Rvcm92YWNAYWx1LnVuaXpnLmhy
 PsKPBBMWCAA3FiEEdCs8n09L2Xwp/ytk6p9/SWOJhIAFAmKdEJgFCQ0oaIACGwMECwkIBwUV
 CAkKCwUWAgMBAAAKCRDqn39JY4mEgIf/AP9hx09nve6VH6D/F3m5jRT5m1lzt5YzSMpxLGGU
 vGlI4QEAvOvGI6gPCQMhuQQrOfRr1CnnTXeaXHhlp9GaZEW45QzOOARinRCZEgorBgEEAZdV
 AQUBAQdAqJ1CxZGdTsiS0cqW3AvoufnWUIC/h3W2rpJ+HUxm61QDAQgHwn4EGBYIACYWIQR0
 KzyfT0vZfCn/K2Tqn39JY4mEgAUCYp0QmQUJDShogAIbDAAKCRDqn39JY4mEgIMnAQDPKMJJ
 fs8+QnWS2xx299NkVTRsZwfg54z9NIvH5L3HiAD9FT3zfHfvQxIViWEzcj0q+FLWoRkOh02P
 Ny0lWTyFlgc=
Organization: Academy of Fine Arts, University of Zagreb
In-Reply-To: <ZSndoNcA7YWHXeUi@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/14/2023 2:15 AM, Yury Norov wrote:
> Restore LKML
> 
> On Thu, Oct 12, 2023 at 02:21:10PM +0200, Jan Kara wrote:
>> On Wed 11-10-23 11:26:29, Yury Norov wrote:
>>> Long story short: KCSAN found some potential issues related to how
>>> people use bitmap API. And instead of working through that issues,
>>> the following code shuts down KCSAN by applying READ_ONCE() here
>>> and there.
>>
>> I'm sorry but this is not what the patch does. I'm not sure how to get the
>> message across so maybe let me start from a different angle:
>>
>> Bitmaps are perfectly fine to be used without any external locking if
>> only atomic bit ops (set_bit, clear_bit, test_and_{set/clear}_bit) are
>> used. This is a significant performance gain compared to using a spinlock
>> or other locking and people do this for a long time. I hope we agree on
>> that.
>>
>> Now it is also common that you need to find a set / clear bit in a bitmap.
>> To maintain lockless protocol and deal with races people employ schemes
>> like (the dumbest form):
>>
>> 	do {
>> 		bit = find_first_bit(bitmap, n);
>> 		if (bit >= n)
>> 			abort...
>> 	} while (!test_and_clear_bit(bit, bitmap));
>>
>> So the code loops until it finds a set bit that is successfully cleared by
>> it. This is perfectly fine and safe lockless code and such use should be
>> supported. Agreed?
> 
> Great example. When you're running non-atomic functions concurrently,
> the result may easily become incorrect, and this is what you're
> demonstrating here.
> 
> Regarding find_first_bit() it means that:
>   - it may erroneously return unset bit;
>   - it may erroneously return non-first set bit;
>   - it may erroneously return no bits for non-empty bitmap.
> 
> Effectively it means that find_first bit may just return a random number.
> 
> Let's take another example:
> 
> 	do {
> 		bit = get_random_number();
> 		if (bit >= n)
> 			abort...
> 	} while (!test_and_clear_bit(bit, bitmap));
> 
> When running concurrently, the difference between this and your code
> is only in probability of getting set bit somewhere from around the
> beginning of bitmap.
> 
> The key point is that find_bit() may return undef even if READ_ONCE() is
> used. If bitmap gets changed anytime in the process, the result becomes
> invalid. It may happen even after returning from find_first_bit().
> 
> And if my understanding correct, your code is designed in the
> assumption that find_first_bit() may return garbage, so handles it
> correctly.
> 
>> *Except* that the above actually is not safe due to find_first_bit()
>> implementation and KCSAN warns about that. The problem is that:
>>
>> Assume *addr == 1
>> CPU1			CPU2
>> find_first_bit(addr, 64)
>>    val = *addr;
>>    if (val) -> true
>> 			clear_bit(0, addr)
>>      val = *addr -> compiler decided to refetch addr contents for whatever
>> 		   reason in the generated assembly
>>      __ffs(val) -> now executed for value 0 which has undefined results.
> 
> Yes, __ffs(0) is undef. But the whole function is undef when accessing
> bitmap concurrently.
> 
>> And the READ_ONCE() this patch adds prevents the compiler from adding the
>> refetching of addr into the assembly.
> 
> That's true. But it doesn't improve on the situation. It was an undef
> before, and it's undef after, but a 2% slower undef.
> 
> Now on that KCSAN warning. If I understand things correctly, for the
> example above, KCSAN warning is false-positive, because you're
> intentionally running lockless.
> 
> But for some other people it may be a true error, and now they'll have
> no chance to catch it if KCSAN is forced to ignore find_bit() entirely.
> 
> We've got the whole class of lockless algorithms that allow safe concurrent
> access to the memory. And now that there's a tool that searches for them
> (concurrent accesses), we need to have an option to somehow teach it
> to suppress irrelevant warnings. Maybe something like this?
> 
>          lockless_algorithm_begin(bitmap, bitmap_size(nbits));
> 	do {
> 		bit = find_first_bit(bitmap, nbits);
> 		if (bit >= nbits)
> 			break;
> 	} while (!test_and_clear_bit(bit, bitmap));
>          lockless_algorithm_end(bitmap, bitmap_size(nbits));
> 
> And, of course, as I suggested a couple iterations ago, you can invent
> a thread-safe version of find_bit(), that would be perfectly correct
> for lockless use:
> 
>   unsigned long _find_and_clear_bit(volatile unsigned long *addr, unsigned long size)
>   {
>          unsigned long bit = 0;
>   
>          while (!test_and_clear_bit(bit, bitmap) {
>                  bit = FIND_FIRST_BIT(addr[idx], /* nop */, size);
>                  if (bit >= size)
>                          return size;
>          }
> 
>          return bit;
>   }

Hi, Yuri,

But the code above effectively does the same as the READ_ONCE() macro
as defined in rwonce.h:

#ifndef __READ_ONCE
#define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
#endif

#define READ_ONCE(x)							\
({									\
	compiletime_assert_rwonce_type(x);				\
	__READ_ONCE(x);							\
})

Both uses only prevent the funny stuff the compiler might have done to the
read of the addr[idx], there's no black magic in READ_ONCE().

Both examples would probably result in the same assembly and produce the
same 2% slowdown ...

Only you declare volatile in one place, and READ_ONCE() in each read, but
this will only compile a bit slower and generate the same machine code.

Best regards,
Mirsad Todorovac


> Didn't test that, but I hope 'volatile' specifier should be enough
> for compiler to realize that it shouldn't optimize memory access, and
> for KCSAN that everything's OK here.
> 
> By the way, thank you for respectful and professional communication.
> 
> Thanks,
> Yury

-- 
Mirsad Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
tel. +385 (0)1 3711 451
mob. +385 91 57 88 355

