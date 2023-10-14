Return-Path: <linux-fsdevel+bounces-351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EC97C91BF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 02:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6D7BB20AA8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 00:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829B37EC;
	Sat, 14 Oct 2023 00:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAzZkG+O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B457E
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Oct 2023 00:17:43 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32902BE;
	Fri, 13 Oct 2023 17:17:42 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-57bc2c2f13dso1516987eaf.2;
        Fri, 13 Oct 2023 17:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697242661; x=1697847461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tn8uQaEx1SIomQ0RvneyDZfYbqqO2FYb9X+QMue1aS4=;
        b=HAzZkG+OKQOcYlsxUyTj22z4k5ebYHohFUXoRw25IfUBTent2g92LWADkvIcCNajxL
         YVc4BvWPvsCFxqkykrpV93V/nOXoX/8xKRU9dzZ6u97U/mHcoHbz89r2GAw3yo5Ta9Es
         QFwRx48rz5BBM57CV0Ar8NdMysApoo3Lq+J0DaPFQx2DW8scjdv88eS08V0eTFpCwCJO
         VdwhaBhzaoUq///TIsNE4oS/OY5CMAMVbocR9T+Ys05Zy2QZXwJA92VJxef9D6C7XEPC
         yTcS5bpDykjFK3rlcDCkj3DTTNZvPQRoyFD8ox/hi8iw1Av6tnF4/3dD6SoG/06cFCRq
         gfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697242661; x=1697847461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tn8uQaEx1SIomQ0RvneyDZfYbqqO2FYb9X+QMue1aS4=;
        b=bYvuNMI3rWJPjJUJZwLcKJPmqnO1l1CgUOLRRXUKP18wziaPdaeITgRdXqbAtRXidn
         RzIuLrCdepQl0X+obGIR8yu+oVlxpBmywp/pvPuJCwpBEkQiPR/UbPAPgdVMxcYzB4x7
         YhSzbUNkC4MhJyfrCJo8Li5Eq9sSY5raphpI44hARED6gCUpZVm6K8cbbMWMCXyQhznn
         /wO/C37dz+nR5RmfM+Hx+MSaagFqseFXS6GWi+ks8WJLTm6p5/v2J/zZeytMzYibMsVZ
         B7RdX3IlUZKG2yUVobxFEDx23BTnVSbW+HfHk3YXLY0xaFkadBKXuC7OmwqnbxI3vsE6
         8MOg==
X-Gm-Message-State: AOJu0YwQ5n18R4+1ZyvaAiUSrJaLRyAsw9X+6nfQvL2Q+WX4LEnpBGqj
	XF1/qsssffQtTHQvAkqjlBWvMqL8PPAHfg==
X-Google-Smtp-Source: AGHT+IGTkVysI8+/vE04p/jC/dV0aRwxFP4yT+Yu5J7KmEIEw8hkHAGHYbOlxmzQoLH0TqJkxlVFNQ==
X-Received: by 2002:a05:6358:2624:b0:15b:249:b520 with SMTP id l36-20020a056358262400b0015b0249b520mr31032640rwc.7.1697242660929;
        Fri, 13 Oct 2023 17:17:40 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id b4-20020aa79504000000b006b97d5cbb7csm203791pfp.60.2023.10.13.17.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 17:17:40 -0700 (PDT)
Date: Fri, 13 Oct 2023 17:15:28 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps
Message-ID: <ZSndoNcA7YWHXeUi@yury-ThinkPad>
References: <20231011144320.29201-1-jack@suse.cz>
 <20231011150252.32737-1-jack@suse.cz>
 <ZSbo1aAjteepdmcz@yury-ThinkPad>
 <20231012122110.zii5pg3ohpragpi7@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012122110.zii5pg3ohpragpi7@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Restore LKML

On Thu, Oct 12, 2023 at 02:21:10PM +0200, Jan Kara wrote:
> On Wed 11-10-23 11:26:29, Yury Norov wrote:
> > Long story short: KCSAN found some potential issues related to how
> > people use bitmap API. And instead of working through that issues,
> > the following code shuts down KCSAN by applying READ_ONCE() here
> > and there.
> 
> I'm sorry but this is not what the patch does. I'm not sure how to get the
> message across so maybe let me start from a different angle:
> 
> Bitmaps are perfectly fine to be used without any external locking if
> only atomic bit ops (set_bit, clear_bit, test_and_{set/clear}_bit) are
> used. This is a significant performance gain compared to using a spinlock
> or other locking and people do this for a long time. I hope we agree on
> that.
> 
> Now it is also common that you need to find a set / clear bit in a bitmap.
> To maintain lockless protocol and deal with races people employ schemes
> like (the dumbest form):
> 
> 	do {
> 		bit = find_first_bit(bitmap, n);
> 		if (bit >= n)
> 			abort...
> 	} while (!test_and_clear_bit(bit, bitmap));
> 
> So the code loops until it finds a set bit that is successfully cleared by
> it. This is perfectly fine and safe lockless code and such use should be
> supported. Agreed?

Great example. When you're running non-atomic functions concurrently,
the result may easily become incorrect, and this is what you're
demonstrating here.

Regarding find_first_bit() it means that:
 - it may erroneously return unset bit;
 - it may erroneously return non-first set bit;
 - it may erroneously return no bits for non-empty bitmap.

Effectively it means that find_first bit may just return a random number.

Let's take another example:

	do {
		bit = get_random_number();
		if (bit >= n)
			abort...
	} while (!test_and_clear_bit(bit, bitmap));

When running concurrently, the difference between this and your code
is only in probability of getting set bit somewhere from around the
beginning of bitmap.

The key point is that find_bit() may return undef even if READ_ONCE() is
used. If bitmap gets changed anytime in the process, the result becomes
invalid. It may happen even after returning from find_first_bit().

And if my understanding correct, your code is designed in the
assumption that find_first_bit() may return garbage, so handles it
correctly.

> *Except* that the above actually is not safe due to find_first_bit()
> implementation and KCSAN warns about that. The problem is that:
> 
> Assume *addr == 1
> CPU1			CPU2
> find_first_bit(addr, 64)
>   val = *addr;
>   if (val) -> true
> 			clear_bit(0, addr)
>     val = *addr -> compiler decided to refetch addr contents for whatever
> 		   reason in the generated assembly
>     __ffs(val) -> now executed for value 0 which has undefined results.

Yes, __ffs(0) is undef. But the whole function is undef when accessing
bitmap concurrently.

> And the READ_ONCE() this patch adds prevents the compiler from adding the
> refetching of addr into the assembly.

That's true. But it doesn't improve on the situation. It was an undef
before, and it's undef after, but a 2% slower undef.

Now on that KCSAN warning. If I understand things correctly, for the
example above, KCSAN warning is false-positive, because you're
intentionally running lockless.

But for some other people it may be a true error, and now they'll have
no chance to catch it if KCSAN is forced to ignore find_bit() entirely.

We've got the whole class of lockless algorithms that allow safe concurrent
access to the memory. And now that there's a tool that searches for them
(concurrent accesses), we need to have an option to somehow teach it
to suppress irrelevant warnings. Maybe something like this?

        lockless_algorithm_begin(bitmap, bitmap_size(nbits));
	do {
		bit = find_first_bit(bitmap, nbits);
		if (bit >= nbits)
			break;
	} while (!test_and_clear_bit(bit, bitmap));
        lockless_algorithm_end(bitmap, bitmap_size(nbits));

And, of course, as I suggested a couple iterations ago, you can invent
a thread-safe version of find_bit(), that would be perfectly correct
for lockless use:

 unsigned long _find_and_clear_bit(volatile unsigned long *addr, unsigned long size)
 {
        unsigned long bit = 0;
 
        while (!test_and_clear_bit(bit, bitmap) {
                bit = FIND_FIRST_BIT(addr[idx], /* nop */, size);
                if (bit >= size)
                        return size;
        }

        return bit;
 }

Didn't test that, but I hope 'volatile' specifier should be enough
for compiler to realize that it shouldn't optimize memory access, and
for KCSAN that everything's OK here. 

By the way, thank you for respectful and professional communication.

Thanks,
Yury

