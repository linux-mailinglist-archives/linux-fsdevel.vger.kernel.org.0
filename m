Return-Path: <linux-fsdevel+bounces-125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CD07C5D9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 21:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B3D2823FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 19:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C982E12E75;
	Wed, 11 Oct 2023 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="0QPxj8Da";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="qUYoFHef"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53EC3A29A
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 19:25:24 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FD48F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 12:25:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 4ABC86016E;
	Wed, 11 Oct 2023 21:25:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697052318; bh=u/eP8rpZytCfPggPUHSrU6b/q4c6VCh9lHTbmZs/ApU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=0QPxj8Da8kV8DxyyFWXFWc/0OlZL1F0eFnL9kT40rCRymjDsMlaDRwQ30h07rpaL8
	 0ubRsa+WxbnmJVhXtXQGwwT2bR5cjKXpnI1e97BRvBjSOcET6hzuXlJD+iV86lmeI5
	 /86Of5ufkpbnwncQPQXYoAQ8LgPdiv63ZjYy9R9jVXz+2O9LWjlyTRJIODC1tbwqiM
	 u14n1owFw+v9UWpX0n4JNC7bOo2KgkULyBwa/3rzRuLno5SUMD3TT0a7n5MBRNPS/Q
	 hc4l71n0lTopdNLSeG/V5JYse1zqHXKi7Y4YDgW73raZFrqJYvZb0bjjeQ5u8mpTvM
	 DqVUoA2JFjsEQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nru4xqE08yuY; Wed, 11 Oct 2023 21:25:15 +0200 (CEST)
Received: from [192.168.1.6] (78-1-184-43.adsl.net.t-com.hr [78.1.184.43])
	by domac.alu.hr (Postfix) with ESMTPSA id 326EF60155;
	Wed, 11 Oct 2023 21:25:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697052315; bh=u/eP8rpZytCfPggPUHSrU6b/q4c6VCh9lHTbmZs/ApU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qUYoFHefvlXg2oCBJ2IB0cFv22m3Yr5wovvuZNde9ujyhz38aS3O7wPUvJ3CQ8Q1l
	 8pMRUaiJ8Nl0mr9wcvWyZJCTI5MtF3EEvRzC08JaKq6LHyjHVva/e5Ziz8MzZsSJsa
	 Fm0CB/VNrNqEKsnTsFicC5UZJHARjlvQfan5MxVcrsalC+knrCUb+JXOkHtjGeMWq6
	 EICL4cVfRMx/7i0bmSxXIx/RRY3bVViqtDgDVgc21JVZHGjdEIkkMhKdmkSplqN2TN
	 teuhBF1W/KdG3D9zBCdg9KhBrCruMgRInQs2UyLAO+Xj3jtTfx8FV/dPbSJTuTLz4y
	 Im4BBQWi4Y8UQ==
Message-ID: <166ade6f-f3fb-4b37-bdf1-db0317d1796f@alu.unizg.hr>
Date: Wed, 11 Oct 2023 21:25:14 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Yury Norov <yury.norov@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-fsdevel@vger.kernel.org
References: <20231011144320.29201-1-jack@suse.cz>
 <20231011150252.32737-1-jack@suse.cz> <ZSbo1aAjteepdmcz@yury-ThinkPad>
 <ZSbuMWGYyulgUA6g@casper.infradead.org>
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZSbuMWGYyulgUA6g@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/11/23 20:49, Matthew Wilcox wrote:
> On Wed, Oct 11, 2023 at 11:26:29AM -0700, Yury Norov wrote:
>> Long story short: KCSAN found some potential issues related to how
>> people use bitmap API. And instead of working through that issues,
>> the following code shuts down KCSAN by applying READ_ONCE() here
>> and there.
> 
> Pfft.
> 
>> READ_ONCE() fixes nothing because nothing is broken in find_bit() API.
>> As I suspected, and as Matthew confirmed in his email, the true reason
>> for READ_ONCE() here is to disable KCSAN check:
>>
>>          READ_ONCE() serves two functions here;
>>          one is that it tells the compiler not to try anything fancy, and
>>          the other is that it tells KCSAN to not bother instrumenting this
>>          load; no load-delay-reload.
>>
>> https://lkml.kernel.org/linux-mm/ZQkhgVb8nWGxpSPk@casper.infradead.org/
>>
>> And as side-effect, it of course hurts the performance. In the same
>> email Matthew said he doesn't believe me that READ_ONCE would do that,
>> so thank you for testing and confirming that it does.
> 
> You really misinterpreted what Jan wrote to accomplish this motivated
> reasoning.
> 
>> Jan, I think that in your last email you confirmed that the xarray
>> problem that you're trying to solve is about a lack of proper locking:
>>
>>          Well, for xarray the write side is synchronized with a spinlock but the read
>>          side is not (only RCU protected).
>>
>> https://lkml.kernel.org/linux-mm/20230918155403.ylhfdbscgw6yek6p@quack3/
>>
>> If there's no enough synchronization, why not just adding it?
> 
> You don't understand.  We _intend_ for there to be no locking.
> We_understand_ there is a race here.  We're _fine_ with there being
> a race here.
> 
>> Regardless performance consideration, my main concern is that this patch
>> considers bitmap as an atomic structure, which is intentionally not.
>> There are just a few single-bit atomic operations like set_bit() and
>> clear_bit(). All other functions are non-atomic, including those
>> find_bit() operations.
> 
> ... and for KCSAN to understand that, we have to use READ_ONCE.
> 
>> There is quite a lot of examples of wrong use of bitmaps wrt
>> atomicity, the most typical is like:
>>          for(idx = 0; idx < num; idx++) {
>>                  ...
>>                  set_bit(idx, bitmap);
>>          }
>>
>> This is wrong because a series of atomic ops is not atomic itself, and
>> if you see something like this in you code, it should be converted to
>> using non-atomic __set_bit(), and protected externally if needed.
> 
> That is a bad use of set_bit()!  I agree!  See, for example, commit
> b21866f514cb where I remove precisely this kind of code.
> 
>> Similarly, READ_ONCE() in a for-loop doesn't guarantee any ordering or
>> atomicity, and only hurts the performance. And this is exactly what
>> this patch does.
> 
> Go back and read Jan's patch again, instead of cherry-picking some
> little bits that confirm your prejudices.

Hey Yuri,

No hard feelings, but I tend to agree with Mr. Wilcox and Jan.

set_bit just as any atomic increment or memory barrier - by the same
author you quoted - causes a LOCK prefix to the assembler instruction.
By my modest knowledge of the machine language, this will cause the CPU
core to LOCK the memory bus for the time the byte, word, longword or quadword
(or even bit) is being read, changed, and written back.

If I am not making a stupid logical mistake, this LOCK on the memory
bus by a core is going to prevent the other cores from accessing memory
or filling or flushing their caches.

I agree with Mr. Wilcox that locking would have much worse performance
penalty that a simply READ_ONCE() that is designed to prevent the compiler
from the "funny" optimisations, such as using the two faster instructions
instead of the atomic load - which might in the worst case be interrupted
just between two half-loads.

It does nothing to hurt performance on the level of a memory read or write barrier
or the memory bus lock that stalls all cores.

So, it silences KCSAN and I am happy with it, but I will not proceed with
a formal patch proposal until we have a consensus about it.

The data-race actually means that another core can tear your half-load and
you get unexpected results. Why does it happen more often on my configuration
that on the others I cannot tell. But it might hurt the integrity of any
filesystem relying of find_first_bit() and find_next_bit() primitives.

I mean, in the worst case scenario.

Meaning, I might not opt to go to Mars with the ship's computer running
with data-races ;-)

Best regards,
Mirsad Todorovac

