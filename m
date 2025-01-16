Return-Path: <linux-fsdevel+bounces-39422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1EDA14039
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 18:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02762162135
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 17:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCAB22D4E1;
	Thu, 16 Jan 2025 17:04:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13FC1547FE;
	Thu, 16 Jan 2025 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047089; cv=none; b=rNiCeWS8KzaBgd7kpgyk9ILUQBFoojqMveHAkMyYg6nBd4WJrZ33OEwOEMWxoauS7K2UrcicD4dKMv91XZOw08r3e4jOfGCSaOnnNo0ZIyq+/2hZ7HqnVWoJ2Tn9LmfZ1EuUIS++Sw7RfOWZOKhBZGEHoNmivp7WQdk6AiLz63c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047089; c=relaxed/simple;
	bh=zBDXu0nIJGNTWyI7jqJS7KFZo3Hc9XU/2UYsRXjc/RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4d5t0E3y/gM5zyCHEXUbQcAYcqQZlCJgJ+1cxW31cLPE9LplJTYsOAs2ONAuNTQCNA3A5xrlu57cRvpVF9JG/SqIIxesOP+kb/cImGhFfxYdx2We+eibKzwIltG3mjCsrQOwnr/qa+dyVgJMLnVllth55XBdHlwJSFT6mn4D9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d896be3992so8985026d6.1;
        Thu, 16 Jan 2025 09:04:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737047087; x=1737651887;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0ItbpnNp/vbadPeHlv4wbai1YbJmLUEJ6P7GuBf1GQ=;
        b=Kr513zWUCqwFJ2k7uw3abVXB6EXIp2nZZ6FUJUWSyN+v3bg3YUj6EDHpk4W3AsaIka
         +cW4pYboMHQqb98CsysP7iGxv5Yydi8lwhmBHTJicjuD06oqfRf+W6nEQ60mjwfFFV5B
         NyPsEpeNDB2Yaop1sT1xmC7fO+43AGPngzqrIBb4m0Moz566+EEp+Q+Agzh0FOXtfqff
         GgydGvm8HhOJ4aeTq55mHxiMW1/riR4Wu2NH+qcIJLJJH29sS1/RbiUocTgsfRpRfU1H
         QBFTu3m2mOTq4qe8mhG893bZOzF2hdpfnJf46oSy4B8YP5F0v+kVbkaCfrDArIRJ1dkV
         SjMw==
X-Forwarded-Encrypted: i=1; AJvYcCWkImSplobujzpOECR42Az9LipMrG0m8I44MrobnbbAxdZ8Mn44FT1L7Dw04CVOOoT4E3NDed1tNcB0uEiC@vger.kernel.org, AJvYcCWrM1RKXdnF6wjIdFQRnBt9HxyhsDEoCCkYNfpkqhckXQaux2GWa0vuBd5ZUsHXvQM5Q5VpOB9jwUWK+xgW@vger.kernel.org
X-Gm-Message-State: AOJu0YwMoj71JpbkN+K3/F2FGrrQvXmLSkdYZYvpWQRokee7+V+04cyY
	xBKIOEf3qECASGjVhL0wgRzNilfdrJaDuHkb0xdnpqTJZUd6z/AY
X-Gm-Gg: ASbGnctZ14Vvf+SUcXvGmqTh2BrC8F3G5TGOucIWz8wLQKfq361YaOm0splwYfu8zRj
	YyITiAy5OexyqpbzGycceE7RDno1ewnuQ7wGTZ2l7gJsou/zjVA1nbcnKWLNba/iek02zm51HrB
	7CRWZ1Z+DdLmLVQiyaNtyLhE1NE3XUkEmdFiB7dhvtin/03VwSGPuD6hmdi/y+odXaFb/CmWwRZ
	OwlJ7/c0tAZiEGQ/ew+U9zEwXD3PwoPFKug9INrbqZZj0+bnHBtj9Cf9geHpxk=
X-Google-Smtp-Source: AGHT+IFf1ZSMof1IFnL99dQ8wtm729SOP4YbYpyj9N1PJK1Wn4HvIq1qLj6JoBsw9AssD2XGTQXlfg==
X-Received: by 2002:a05:6214:1249:b0:6d8:b371:6a0f with SMTP id 6a1803df08f44-6df9b2d5c50mr578194806d6.31.1737047086881;
        Thu, 16 Jan 2025 09:04:46 -0800 (PST)
Received: from gmail.com ([192.159.180.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afce4129sm1682516d6.102.2025.01.16.09.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 09:04:46 -0800 (PST)
Date: Thu, 16 Jan 2025 12:04:44 -0500
From: Tavian Barnes <tavianator@tavianator.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump: allow interrupting dumps of large anonymous
 regions
Message-ID: <Z4k68Clw4k2g2OgK@tachyon.localdomain>
References: <049f0da40ed76d94c419f83dd42deb413d6afb44.1737000287.git.tavianator@tavianator.com>
 <t2cucclkkxj65fk7nknzogbeobyq7tgx4klep77ptnnlfrv34e@vjkzxymgnr4r>
 <63wvjel64hsft4clgeayaorx3v7txvqh264mw7ionlbmmve7pj@eblpknd677zf>
 <CAGudoHFg4BgeygyKV8tY_2Dk4cv9zwQnU6-n7jSxjwyyXzau6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFg4BgeygyKV8tY_2Dk4cv9zwQnU6-n7jSxjwyyXzau6g@mail.gmail.com>

On Thu, Jan 16, 2025 at 01:04:42PM +0100, Mateusz Guzik wrote:
> On Thu, Jan 16, 2025 at 10:56 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 16-01-25 08:46:48, Mateusz Guzik wrote:
> > > On Wed, Jan 15, 2025 at 11:05:38PM -0500, Tavian Barnes wrote:
> > > > dump_user_range() supports sparse core dumps by skipping anonymous pages
> > > > which have not been modified.  If get_dump_page() returns NULL, the page
> > > > is skipped rather than written to the core dump with dump_emit_page().
> > > >
> > > > Sadly, dump_emit_page() contains the only check for dump_interrupted(),
> > > > so when dumping a very large sparse region, the core dump becomes
> > > > effectively uninterruptible.  This can be observed with the following
> > > > test program:
> > > >
> > > >     #include <stdlib.h>
> > > >     #include <stdio.h>
> > > >     #include <sys/mman.h>
> > > >
> > > >     int main(void) {
> > > >         char *mem = mmap(NULL, 1ULL << 40, PROT_READ | PROT_WRITE,
> > > >                 MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE, -1, 0);
> > > >         printf("%p %m\n", mem);
> > > >         if (mem != MAP_FAILED) {
> > > >                 mem[0] = 1;
> > > >         }
> > > >         abort();
> > > >     }
> > > >
> > > > The program allocates 1 TiB of anonymous memory, touches one page of it,
> > > > and aborts.  During the core dump, SIGKILL has no effect.  It takes
> > > > about 30 seconds to finish the dump, burning 100% CPU.
> > > >
> > >
> > > While the patch makes sense to me, this should not be taking anywhere
> > > near this much time and plausibly after unscrewing it will stop being a
> > > factor.
> > >
> > > So I had a look with a profiler:
> > > -   99.89%     0.00%  a.out
> > >      entry_SYSCALL_64_after_hwframe
> > >      do_syscall_64
> > >      syscall_exit_to_user_mode
> > >      arch_do_signal_or_restart
> > >    - get_signal
> > >       - 99.89% do_coredump
> > >          - 99.88% elf_core_dump
> > >             - dump_user_range
> > >                - 98.12% get_dump_page
> > >                   - 64.19% __get_user_pages
> > >                      - 40.92% gup_vma_lookup
> > >                         - find_vma
> > >                            - mt_find
> > >                                 4.21% __rcu_read_lock
> > >                                 1.33% __rcu_read_unlock
> > >                      - 3.14% check_vma_flags
> > >                           0.68% vma_is_secretmem
> > >                        0.61% __cond_resched
> > >                        0.60% vma_pgtable_walk_end
> > >                        0.59% vma_pgtable_walk_begin
> > >                        0.58% no_page_table
> > >                   - 15.13% down_read_killable
> > >                        0.69% __cond_resched
> > >                     13.84% up_read
> > >                  0.58% __cond_resched
> > >
> > >
> > > Almost 29% of time is spent relocking the mmap semaphore in
> > > __get_user_pages. This most likely can operate locklessly in the fast
> > > path. Even if somehow not, chances are the lock can be held across
> > > multiple calls.
> > >
> > > mt_find spends most of it's time issuing a rep stos of 48 bytes (would
> > > be faster to rep mov 6 times instead). This is the compiler being nasty,
> > > I'll maybe look into it.
> > >
> > > However, I strongly suspect the current iteration method is just slow
> > > due to repeat mt_find calls and The Right Approach(tm) would make this
> > > entire thing finish within miliseconds by iterating the maple tree
> > > instead, but then the mm folk would have to be consulted on how to
> > > approach this and it may be time consuming to implement.
> > >
> > > Sorting out relocking should be an easily achievable & measurable win
> > > (no interest on my end).
> >
> > As much as I agree the code is dumb, doing what you suggest with mmap_sem
> > isn't going to be easy. You cannot call dump_emit_page() with mmap_sem held
> > as that will cause lock inversion between mmap_sem and whatever filesystem
> > locks we have to take. So the fix would have to involve processing larger
> > batches of address space at once (which should also somewhat amortize the
> > __get_user_pages() setup costs). Not that hard to do but I wanted to spell
> > it out in case someone wants to pick up this todo item :)
> >
> 
> Is the lock really needed to begin with?
> 
> Suppose it is.
> 
> In this context there are next to no pages found, but there is a
> gazillion relocks as the entire VA is being walked.

Do I understand correctly that all the relocks are to look up the VMA
associated with each address, one page at a time?  That's especially
wasteful as dump_user_range() is called separately for each VMA, so it's
going to find the same VMA every time anyway.

> Bare minimum patch which would already significantly help would start
> with the lock held and only relock if there is a page to dump, should
> be very easy to add.

That seems like a good idea.

> I however vote for someone mm-savvy to point out an easy way (if any)
> to just iterate pages which are there instead.

It seems like some of the <linux/pagewalk.h> APIs might be relevant?
Not sure which one has the right semantics.  Can we just use
folio_walk_start()?

I guess the main complexity is every time we find a page, we have to
stop the walk, unlock mmap_sem, call dump_emit_page(), and restart the
walk from the next address.  Maybe an mm expert can weigh in.

> -- 
> Mateusz Guzik <mjguzik gmail.com>
> 

