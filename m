Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E503F827D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 08:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbhHZGd2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 02:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbhHZGd2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 02:33:28 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A72C061757;
        Wed, 25 Aug 2021 23:32:41 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id a21so2372538ioq.6;
        Wed, 25 Aug 2021 23:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pIwUqES0KjF4tM/DUynoGjEfY9vOS2sW1S6XuW00tG4=;
        b=TSFlmcYGPwVV3W4+2ErCsSHNh6wlzQp4FgnmaFis1r3/gkp74EXyDetcQZ6Pisp40/
         i5a08/rUYKh/Yzx3xUsRcdwzurUSYAbvmYxlKX2Q+L4WajEz4PfBGXv1kYo7sTAUm/m9
         Vd6Dc4Yh/PF6AAQ+L4hAbePLuNq+AzlCg6HRj31SeUfiPbLqiCQad9IAHkbhHZ7pncfA
         AJ0f+cJAD9Sa6JZ3/Z+GrL0ZCwWm2LX69WrjhQci46sYsDL1odW01B4pKE2wJr+YMD7i
         YmOnG8wcJdCr7XN9urEs/rwAUvzXqSpoQVdOFZHYTB7LeIJH1UzcDD1EQQbncN334Jfz
         GRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pIwUqES0KjF4tM/DUynoGjEfY9vOS2sW1S6XuW00tG4=;
        b=KZqLphU7Fc9GYTVo2XO167vd4Wtta95QKf/zfxCW5woxWCnctvOQgIR+OzQLhgbRaa
         muj07aUC+7VE/8exJV45I9MUcfIlykBcmrMn1GG4iFW7PKPtDxTH2NHbvUgeqbPnZJIJ
         cRDOCq+isTYmzrnMI/2zcu6ak0AlcjsT+AOsRX+p0ADiYtSApcBnLOSEe7rdaGP35H+3
         2L8cxhjjVVUkW0dMFtWRb52lZnbkBfb9Jcd9BV9jaAwR8kRovDehRPCyvJGJnE9Jjtd9
         UHNJ8UWt74Hk5py6BiSJjvnAhFSdKwIylHggy2HEeKG7QRDCGHYZ1ZTDVMZ9lso5W30T
         v1CQ==
X-Gm-Message-State: AOAM532Ashbq+x0Nck9V457ZDIzPTV9HhJS5xvgvSrQhKJWgIkoVNmYj
        PiAmVbqO1dgj6D1K9stnIwMLYx1fIC62Qg+5z9M=
X-Google-Smtp-Source: ABdhPJxa1fbod7eShy2ojEpRZwrFd+0pNfPFx7oe6YmtF1RYOLKdfUUG+HqbHDUwOn7hZW+KxQ5wONL838ljkbGRPIk=
X-Received: by 2002:a5d:8b03:: with SMTP id k3mr1757843ion.203.1629959560394;
 Wed, 25 Aug 2021 23:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk> <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
 <YSVCAJDYShQke6Sy@casper.infradead.org> <CAHk-=wisF580D_g+wFt0B_uijSX+mCgz6tRRT5KADnO7Y97t-g@mail.gmail.com>
 <YSVHI9iaamxTGmI7@casper.infradead.org> <YSVMMMrzqxyFjHlw@mit.edu>
 <YSXkDFNkgAhQGB0E@infradead.org> <92cbfb8f-7418-15d5-c469-d7861e860589@rasmusvillemoes.dk>
In-Reply-To: <92cbfb8f-7418-15d5-c469-d7861e860589@rasmusvillemoes.dk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 26 Aug 2021 09:32:28 +0300
Message-ID: <CAOQ4uxhOmH8sEmpR=Jaj08r84Jpy3U--59LfKdo9H2O-a7kyrQ@mail.gmail.com>
Subject: Re: [GIT PULL] Memory folios for v5.15
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 25, 2021 at 12:02 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 25/08/2021 08.32, Christoph Hellwig wrote:
> > On Tue, Aug 24, 2021 at 03:44:48PM -0400, Theodore Ts'o wrote:
> >> The problem is whether we use struct head_page, or folio, or mempages,
> >> we're going to be subsystem users' faces.  And people who are using it
> >> every day will eventually get used to anything, whether it's "folio"
> >> or "xmoqax", we sould give a thought to newcomers to Linux file system
> >> code.  If they see things like "read_folio()", they are going to be
> >> far more confused than "read_pages()" or "read_mempages()".
> >
> > Are they?  It's not like page isn't some randomly made up term
> > as well, just one that had a lot more time to spread.
> >
> >> So if someone sees "kmem_cache_alloc()", they can probably make a
> >> guess what it means, and it's memorable once they learn it.
> >> Similarly, something like "head_page", or "mempages" is going to a bit
> >> more obvious to a kernel newbie.  So if we can make a tiny gesture
> >> towards comprehensibility, it would be good to do so while it's still
> >> easier to change the name.
> >
> > All this sounds really weird to me.  I doubt there is any name that
> > nicely explains "structure used to manage arbitrary power of two
> > units of memory in the kernel" very well.  So I agree with willy here,
> > let's pick something short and not clumsy.  I initially found the folio
> > name a little strange, but working with it I got used to it quickly.
> > And all the other uggestions I've seen s far are significantly worse,
> > especially all the odd compounds with page in it.
> >
>
> A comment from the peanut gallery: I find the name folio completely
> appropriate and easy to understand. Our vocabulary is already strongly
> inspired by words used in the world of printed text: the smallest unit
> of information is a char(acter) [ok, we usually call them bytes], a few
> characters make up a word, there's a number of words to each (cache)
> line, and a number of those is what makes up a page. So obviously a
> folio is something consisting of a few pages.
>
> Are the analogies perfect? Of course not. But they are actually quite
> apt; words, lines and pages don't universally have one size, but they do
> form a natural hierarchy describing how we organize information.
>
> Splitting a word across lines can slow down the reader so should be
> avoided... [sorry, couldn't resist].
>

And if we ever want to manage page cache using an arbitrary number
of contiguous filios, we can always saw them into a scroll ;-)

Thanks,
Amir.
