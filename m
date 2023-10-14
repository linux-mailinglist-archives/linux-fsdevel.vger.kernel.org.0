Return-Path: <linux-fsdevel+bounces-354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A2E7C925C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 04:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DA61F21A36
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 02:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B471CEA9;
	Sat, 14 Oct 2023 02:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AF57E7Zk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655C6367
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Oct 2023 02:53:49 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CFCB7;
	Fri, 13 Oct 2023 19:53:46 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59b5484fbe6so33749747b3.1;
        Fri, 13 Oct 2023 19:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697252025; x=1697856825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hGncKTdfCimdngO7kKPOQgHCStOsPVpBFk/n5kdBRjA=;
        b=AF57E7ZkrpqQEFli4FO2dD5xBD0mVV4F0PkOM5QE28ULYC9PnhVxPc8c7rLIyxlu2h
         WQPkYVV7XqtXf10Pj90yifND2SsgxLKAV3I+U5zWQWp2ZTz1q18mhzXxv7VfKm6XZolk
         zCdVFMB7weDm8uh5aqPQMzfqs3JtjLAcN8ydrCqgnMpI3SzbvInTNAaWKHmPMR7vTf7z
         fh+wTQV4E5gca6FxNdgwZWfMCI1UTelXKyWAyDrm+IDfK3Htmq2XfujH777mZo+rt875
         dQZEZZxGHksLszkWxDAnaq+zR1G+6ZTI+46bO4kon2zKRbe0BhL9MdCu8oyhWW8owNXi
         h/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697252025; x=1697856825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGncKTdfCimdngO7kKPOQgHCStOsPVpBFk/n5kdBRjA=;
        b=gHek8FFNWjXmj2SmZCcbkfmzbWpZ1E0D+xLVCamkXzLhTe9adfywhVZm4lQeB1nleg
         VJuQYAiqC5gjQqDCMV34tHFbx0CMWa2Lzoz/E75Z7s1jnhr3qfywM1BaDfdl91DMJEa1
         YB1wdYHOsO4N3ESyLv+2hDPxQZNZmDME7jXLXrys5JLLk31UqvneUV/Qx/mxf6yowpmr
         2v3IoLNHTg2CLKaIDIzPtCEpBvP2ihCChW7Rh1MEUQEDPtzVAkLMR9s8LSQ9+S8mGnWE
         cPaE9ognIoJrQf0NHZMlpZPh6NgPN9X0PvG56IIxFkJYzksjG8YsY1vWoBvJf8teEZKc
         dHIw==
X-Gm-Message-State: AOJu0Yy6MznIPLiiCw0gpy3Pa3RgOkZghMqDdH5rfKNLxMX8QczfEcka
	sm0gDufGF5LeVWaNW3PPHsp7Ufv52muQAg==
X-Google-Smtp-Source: AGHT+IF64BUBlHNToy/kVSEqM9physpRohj2L1qshJhiIksiQK26raMAYveyRWZt09UIwX5jq0K99A==
X-Received: by 2002:a81:ad42:0:b0:5a7:aa65:c536 with SMTP id l2-20020a81ad42000000b005a7aa65c536mr14292411ywk.0.1697252025487;
        Fri, 13 Oct 2023 19:53:45 -0700 (PDT)
Received: from localhost ([2607:fb90:3e1c:8d18:7450:8e7a:f047:ce0a])
        by smtp.gmail.com with ESMTPSA id f124-20020a0ddc82000000b0058427045833sm242832ywe.133.2023.10.13.19.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 19:53:44 -0700 (PDT)
Date: Fri, 13 Oct 2023 19:53:43 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Jan Kara <jack@suse.cz>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps
Message-ID: <ZSoCt5+DybhpsuGv@yury-ThinkPad>
References: <20231011144320.29201-1-jack@suse.cz>
 <20231011150252.32737-1-jack@suse.cz>
 <ZSbo1aAjteepdmcz@yury-ThinkPad>
 <20231012122110.zii5pg3ohpragpi7@quack3>
 <ZSndoNcA7YWHXeUi@yury-ThinkPad>
 <021970ad-942a-4fe8-ac95-c8089527f7d2@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021970ad-942a-4fe8-ac95-c8089527f7d2@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 04:21:50AM +0200, Mirsad Goran Todorovac wrote:
> On 10/14/2023 2:15 AM, Yury Norov wrote:
> > Restore LKML
> > 
> > On Thu, Oct 12, 2023 at 02:21:10PM +0200, Jan Kara wrote:
> > > On Wed 11-10-23 11:26:29, Yury Norov wrote:
> > > > Long story short: KCSAN found some potential issues related to how
> > > > people use bitmap API. And instead of working through that issues,
> > > > the following code shuts down KCSAN by applying READ_ONCE() here
> > > > and there.
> > > 
> > > I'm sorry but this is not what the patch does. I'm not sure how to get the
> > > message across so maybe let me start from a different angle:
> > > 
> > > Bitmaps are perfectly fine to be used without any external locking if
> > > only atomic bit ops (set_bit, clear_bit, test_and_{set/clear}_bit) are
> > > used. This is a significant performance gain compared to using a spinlock
> > > or other locking and people do this for a long time. I hope we agree on
> > > that.
> > > 
> > > Now it is also common that you need to find a set / clear bit in a bitmap.
> > > To maintain lockless protocol and deal with races people employ schemes
> > > like (the dumbest form):
> > > 
> > > 	do {
> > > 		bit = find_first_bit(bitmap, n);
> > > 		if (bit >= n)
> > > 			abort...
> > > 	} while (!test_and_clear_bit(bit, bitmap));
> > > 
> > > So the code loops until it finds a set bit that is successfully cleared by
> > > it. This is perfectly fine and safe lockless code and such use should be
> > > supported. Agreed?
> > 
> > Great example. When you're running non-atomic functions concurrently,
> > the result may easily become incorrect, and this is what you're
> > demonstrating here.
> > 
> > Regarding find_first_bit() it means that:
> >   - it may erroneously return unset bit;
> >   - it may erroneously return non-first set bit;
> >   - it may erroneously return no bits for non-empty bitmap.
> > 
> > Effectively it means that find_first bit may just return a random number.
> > 
> > Let's take another example:
> > 
> > 	do {
> > 		bit = get_random_number();
> > 		if (bit >= n)
> > 			abort...
> > 	} while (!test_and_clear_bit(bit, bitmap));
> > 
> > When running concurrently, the difference between this and your code
> > is only in probability of getting set bit somewhere from around the
> > beginning of bitmap.
> > 
> > The key point is that find_bit() may return undef even if READ_ONCE() is
> > used. If bitmap gets changed anytime in the process, the result becomes
> > invalid. It may happen even after returning from find_first_bit().
> > 
> > And if my understanding correct, your code is designed in the
> > assumption that find_first_bit() may return garbage, so handles it
> > correctly.
> > 
> > > *Except* that the above actually is not safe due to find_first_bit()
> > > implementation and KCSAN warns about that. The problem is that:
> > > 
> > > Assume *addr == 1
> > > CPU1			CPU2
> > > find_first_bit(addr, 64)
> > >    val = *addr;
> > >    if (val) -> true
> > > 			clear_bit(0, addr)
> > >      val = *addr -> compiler decided to refetch addr contents for whatever
> > > 		   reason in the generated assembly
> > >      __ffs(val) -> now executed for value 0 which has undefined results.
> > 
> > Yes, __ffs(0) is undef. But the whole function is undef when accessing
> > bitmap concurrently.
> > 
> > > And the READ_ONCE() this patch adds prevents the compiler from adding the
> > > refetching of addr into the assembly.
> > 
> > That's true. But it doesn't improve on the situation. It was an undef
> > before, and it's undef after, but a 2% slower undef.
> > 
> > Now on that KCSAN warning. If I understand things correctly, for the
> > example above, KCSAN warning is false-positive, because you're
> > intentionally running lockless.
> > 
> > But for some other people it may be a true error, and now they'll have
> > no chance to catch it if KCSAN is forced to ignore find_bit() entirely.
> > 
> > We've got the whole class of lockless algorithms that allow safe concurrent
> > access to the memory. And now that there's a tool that searches for them
> > (concurrent accesses), we need to have an option to somehow teach it
> > to suppress irrelevant warnings. Maybe something like this?
> > 
> >          lockless_algorithm_begin(bitmap, bitmap_size(nbits));
> > 	do {
> > 		bit = find_first_bit(bitmap, nbits);
> > 		if (bit >= nbits)
> > 			break;
> > 	} while (!test_and_clear_bit(bit, bitmap));
> >          lockless_algorithm_end(bitmap, bitmap_size(nbits));
> > 
> > And, of course, as I suggested a couple iterations ago, you can invent
> > a thread-safe version of find_bit(), that would be perfectly correct
> > for lockless use:
> > 
> >   unsigned long _find_and_clear_bit(volatile unsigned long *addr, unsigned long size)
> >   {
> >          unsigned long bit = 0;
> >          while (!test_and_clear_bit(bit, bitmap) {
> >                  bit = FIND_FIRST_BIT(addr[idx], /* nop */, size);
> >                  if (bit >= size)
> >                          return size;
> >          }
> > 
> >          return bit;
> >   }
> 
> Hi, Yuri,
> 
> But the code above effectively does the same as the READ_ONCE() macro
> as defined in rwonce.h:
> 
> #ifndef __READ_ONCE
> #define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
> #endif
> 
> #define READ_ONCE(x)							\
> ({									\
> 	compiletime_assert_rwonce_type(x);				\
> 	__READ_ONCE(x);							\
> })
> 
> Both uses only prevent the funny stuff the compiler might have done to the
> read of the addr[idx], there's no black magic in READ_ONCE().
> 
> Both examples would probably result in the same assembly and produce the
> same 2% slowdown ...
> 
> Only you declare volatile in one place, and READ_ONCE() in each read, but
> this will only compile a bit slower and generate the same machine code.

The difference is that find_and_clear_bit() has a semantics of
atomic operation. Those who will decide to use it will also anticipate
associate downsides. And other hundreds (or thousands) users of
non-atomic find_bit() functions will not have to pay extra buck
for unneeded atomicity.

Check how 'volatile' is used in test_and_clear_bit(), and consider
find_and_clear_bit() as a wrapper around test_and_clear_bit().

In other words, this patch suggests to make find_bit() thread-safe by
using READ_ONCE(), and it doesn't work. find_and_clear_bit(), on the
other hand, is simply a wrapper around test_and_clear_bit(), and
doesn't imply any new restriction that test_and_clear_bit() doesn't.

Think of it as an optimized version of:
         while (bit < nbits && !test_and_clear_bit(bit, bitmap)
                bit++;

If you think it's worth to try in your code, I can send a patch for
you.

Thanks,
Yury

