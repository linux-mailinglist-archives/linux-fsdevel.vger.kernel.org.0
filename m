Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4A1B2CB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 18:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgDUQbr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 12:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgDUQbq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:31:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAB5C061A10;
        Tue, 21 Apr 2020 09:31:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x18so17199433wrq.2;
        Tue, 21 Apr 2020 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hb6ZLfSFpMZd4Y9W6ASz7WrEHgGkQpH64cD11mmBcUo=;
        b=Q4+L40D9mGncJW3ikEJHNPZNQJt+igrtsQdWwnOVpAWPWnScDkjji5wa1U8hg4polg
         VB2aeUgjQe6yjqVJlVbGoPdUaET4z/C0emoQB7UFPdkcQolS2DHIrRJ8AW8dNy4BCX+9
         4EvhIdAvxIAqxk7ROUiJ0b489Ng4UCF5FMb/tmpQ3UwwbzE0vPMU+a1wChcXcwJ75+eo
         sIGTDZPV7gOtDsC1Izt2Lg/uZkJk2GBssemgnN6/P3NL9IQS98KSwM5P1HENF7xpwTIO
         RpVlZOEnhskBIzTnaPSnN5ZPQZKYlPDrEz0QAAQj5x+VH5ZR1bT8iYbcAUTbbA96e5wC
         cNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hb6ZLfSFpMZd4Y9W6ASz7WrEHgGkQpH64cD11mmBcUo=;
        b=JgRWLwc3kvaLyGhoAPuZeO+gQrQsJ9aVpHW3kev0mtbjjeydhLvh4pWLLBIan+UGFK
         AgCHK9gMIRkoCo/VsgTIDIabKpondicc4sKyx/SdbwAWxHl136StZYfYmu7S+KuwzFmT
         qk3NhalOB8bYfRzANEWBjzN/8IdqYLUcUqbRcmNWdf/BnUw2IBFFPo28Hv5PG5ZV5wYw
         nsqz3x4L/r+kGadOdvn7f3+OAhnTYjlDud6FkTOrwMP4D0lKrBsTkVkljFJ6BR/FYcGS
         QgACxl5qFvK94PITsdSqsourW/4a8csEwa3HBTDWdSYUz98x2ZHGy48w1tlRLQ7nVyM5
         Pzqg==
X-Gm-Message-State: AGi0PuZCz2/r1qjx9id/SXdnfcbGuNpovH1nOp4l/ZuDwal7kw1H/AY/
        C0zJBiLWbics/o+Fgra4Dg==
X-Google-Smtp-Source: APiQypK2rybQrDS/Zjb18N3TvlwMzNlQIUMLHJmI52Rr+DN4bPKzQjVPd8dxnF+9w4SjiU5TuqN59A==
X-Received: by 2002:adf:83c2:: with SMTP id 60mr24475213wre.169.1587486705267;
        Tue, 21 Apr 2020 09:31:45 -0700 (PDT)
Received: from avx2 ([46.53.252.84])
        by smtp.gmail.com with ESMTPSA id c190sm4311134wme.10.2020.04.21.09.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:31:44 -0700 (PDT)
Date:   Tue, 21 Apr 2020 19:31:42 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH 03/15] print_integer: new and improved way of printing
 integers
Message-ID: <20200421163142.GA8735@avx2>
References: <20200420205743.19964-1-adobriyan@gmail.com>
 <20200420205743.19964-3-adobriyan@gmail.com>
 <20200420211911.GC185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200420211911.GC185537@smile.fi.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 12:19:11AM +0300, Andy Shevchenko wrote:
> On Mon, Apr 20, 2020 at 11:57:31PM +0300, Alexey Dobriyan wrote:
> > Time honored way to print integers via vsnprintf() or equivalent has
> > unavoidable slowdown of parsing format string. This can't be fixed in C,
> > without introducing external preprocessor.
> > 
> > seq_put_decimal_ull() partially saves the day, but there are a lot of
> > branches inside and overcopying still.
> > 
> > _print_integer_*() family of functions is meant to make printing
> > integers as fast as possible by deleting format string parsing and doing
> > as little work as possible.
> > 
> > It is based on the following observations:
> > 
> > 1) memcpy is done in forward direction
> > 	it can be done backwards but nobody does that,
> > 
> > 2) digits can be extracted in a very simple loop which costs only
> > 	1 multiplication and shift (division by constant is not division)
> > 
> > All the above asks for the following signature, semantics and pattern of
> > printing out beloved /proc files:
> > 
> > 	/* seq_printf(seq, "%u %llu\n", A, b); */
> > 
> > 	char buf[10 + 1 + 20 + 1];
> > 	char *p = buf + sizeof(buf);
> > 
> > 	*--p = '\n';
> > 	p = _print_integer_u64(p, B);
> > 	*--p = ' ';
> > 	p = _print_integer_u32(p, A);
> > 
> > 	seq_write(seq, p, buf + sizeof(buf) - p);
> > 
> > 1) stack buffer capable of holding the biggest string is allocated.
> > 
> > 2) "p" is pointer to start of the string. Initially it points past
> > 	the end of the buffer WHICH IS NOT NUL-TERMINATED!
> > 
> > 3) _print_integer_*() actually prints an integer from right to left
> > 	and returns new start of the string.
> > 
> > 			     <--------|
> > 				123
> > 				^
> > 				|
> > 				+-- p
> > 
> > 4) 1 character is printed with
> > 
> > 	*--p = 'x';
> > 
> > 	It generates very efficient code as multiple writes can be
> > 	merged.
> > 
> > 5) fixed string is printed with
> > 
> > 	p = memcpy(p - 3, "foo", 3);
> > 
> > 	Complers know what memcpy() does and write-combine it.
> > 	4/8-byte writes become 1 instruction and are very efficient.
> > 
> > 6) Once everything is printed, the result is written to seq_file buffer.
> > 	It does only one overflow check and 1 copy.
> > 
> > This generates very efficient code (and small!).
> > 
> > In regular seq_printf() calls, first argument and format string are
> > constantly reloaded. Format string will most likely with [rip+...] which
> > is quite verbose.
> > 
> > seq_put_decimal_ull() will do branches (and even more branches
> > with "width" argument)
> > 
> 
> > 	TODO
> > 	benchmark with mainline because nouveau is broken for me -(
> > 	vsnprintf() changes make the code slower
> 
> Exactly main point of this exercise. I don't believe that algos in vsprintf.c
> are too dumb to use division per digit (yes, division by constant which is not
> power of two is a heavy operation).

It is not about division.

It is about fucktons of branches in vsprintf().

> > +noinline
> > +char *_print_integer_u32(char *p, u32 x)
> > +{
> > +	do {
> > +		*--p = '0' + (x % 10);
> > +	} while (x /= 10);
> > +	return p;
> > +}
> 
> > +noinline
> > +char *_print_integer_u64(char *p, u64 x)
> > +{
> > +	while (x >= 100 * 1000 * 1000) {
> > +		u32 r;
> > +
> > +		x = div_u64_rem(x, 100 * 1000 * 1000, &r);
> > +		p = memset(p - 8, '0', 8);
> > +		(void)_print_integer_u32(p + 8, r);
> > +	}
> > +	return _print_integer_u32(p, x);
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
