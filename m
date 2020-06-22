Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AE42030FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 09:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgFVH6K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 03:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgFVH6E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:58:04 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C46C061795
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2020 00:58:02 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e11so15039002ilr.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2020 00:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YJOki992P9qNOPua918TTZl0HYesJ45HJbzAqlx6Elw=;
        b=RRBCbyCTLzOD8aqicLFIF4SOzn0LUeeYNdAbaD3uXB5TRlNWJHHhcxRGUW3hca/nXZ
         0DYilbSSca4elYYrVQbNeIoB8y0Yrh5I4KjV9CckmtZ4VNKyox/OkW/5HVWF+XYB9Rgm
         kiWR5gw9xXcDxPvzzAs4BT1YHyfeBNGlR5Gpg5wAy/3JCwpYmkTdvPoaeMgv1mW5yJzV
         9wTEu2u0EpHSL519bZP1iUokiNe8qraUG6yHXE3KH9/rVtqF3b5aB6OhJ9xNxS8D/laZ
         59eBMYI4nn4drI9UezD1eks8cmGZPh/aV9DmQA0REXcCZgYL7TQJHm2KMJ7QKIPaZzMj
         qgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YJOki992P9qNOPua918TTZl0HYesJ45HJbzAqlx6Elw=;
        b=VCg4kk8fi3PT/SC3STMOFhjRy1lyAh2oDB5IAy3mKklIDDsYsxBr/ti5r7U+m32Peb
         pi8zjdfX+YOe5TQjsEHlcEDQIzCopxto9QLh4hcMCN/MWtZwv6ANDADgd/20A5CFiXj9
         isk5hB2bx+rNpdYUf4p27OIKXleDnpG/qZg4SYZlS++YdPj82crv/PS3eNz/m1prP0qG
         V1PXP/133p3yw39+TizFxYpcTCk1BMki4YA3qMlLNyQbvRo1RHxfomPxzm8ADYMBXa5I
         BajH5pPcUeGYH1P1SOhslkIxwkN9ZNg7Kg4IJEyQuGMc0myYzZ22YcGc9fvltEIACP11
         Qyvw==
X-Gm-Message-State: AOAM530EL92u7qj8ibCESvlhSXkJ6mmYAH5w3apQm2L1ON7WPsi+tYml
        hBtEE1R8nQWT3FfEtSuph3InOlZis+E1pkfmkmnY3g==
X-Google-Smtp-Source: ABdhPJw+fjwMXvUCyqzwimJ4WWxs1noJQIVGDHJKmtUBPxyFHGYbNm8ZjI4IzPxISB9R6D6c7xgumGkOZEum/AUaPuc=
X-Received: by 2002:a92:2a0c:: with SMTP id r12mr15616351ile.275.1592812681747;
 Mon, 22 Jun 2020 00:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAMHtQmP_TVR8QA+noWQk04Nj_8AxMXfjCj1K_k0Zf6BN-Bq9sg@mail.gmail.com>
 <87bllhh7mg.fsf@vostro.rath.org> <CAMHtQmPcADq0WSAY=uFFyRgAeuCCAo=8dOHg37304at1SRjGBg@mail.gmail.com>
 <877dw0g0wn.fsf@vostro.rath.org> <CAJfpegs3xthDEuhx_vHUtjJ7BAbVfoDu9voNPPAqJo4G3BBYZQ@mail.gmail.com>
 <87sgensmsk.fsf@vostro.rath.org> <CAOQ4uxiYG3Z9rnXB6F+fnRtoV1e3k=WP5-mgphgkKsWw+jUK=Q@mail.gmail.com>
 <87mu4vsgd4.fsf@vostro.rath.org>
In-Reply-To: <87mu4vsgd4.fsf@vostro.rath.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 22 Jun 2020 10:57:50 +0300
Message-ID: <CAOQ4uxgqrT=cxyjAE+FAJzfnJ1=YS91t8aidXSqxPTsEoR90Vw@mail.gmail.com>
Subject: Re: [fuse-devel] 512 byte aligned write + O_DIRECT for xfstests
To:     Amir Goldstein <amir73il@gmail.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:35 AM Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> On Jun 22 2020, Amir Goldstein <amir73il@gmail.com> wrote:
> > [+CC fsdevel folks]
> >
> > On Mon, Jun 22, 2020 at 8:33 AM Nikolaus Rath <Nikolaus@rath.org> wrote:
> >>
> >> On Jun 21 2020, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >> >> I am not sure that is correct. At step 6, the write() request from
> >> >> userspace is still being processed. I don't think that it is reasonable
> >> >> to expect that the write() request is atomic, i.e. you can't expect to
> >> >> see none or all of the data that is *currently being written*.
> >> >
> >> > Apparently the standard is quite clear on this:
> >> >
> >> >   "All of the following functions shall be atomic with respect to each
> >> > other in the effects specified in POSIX.1-2017 when they operate on
> >> > regular files or symbolic links:
> >> >
> >> > [...]
> >> > pread()
> >> > read()
> >> > readv()
> >> > pwrite()
> >> > write()
> >> > writev()
> >> > [...]
> >> >
> >> > If two threads each call one of these functions, each call shall
> >> > either see all of the specified effects of the other call, or none of
> >> > them."[1]
> >> >
> >> > Thanks,
> >> > Miklos
> >> >
> >> > [1]
> >> > https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_09_07
> >>
> >> Thanks for digging this up, I did not know about this.
> >>
> >> That leaves FUSE in a rather uncomfortable place though, doesn't it?
> >> What does the kernel do when userspace issues a write request that's
> >> bigger than FUSE userspace pipe? It sounds like either the request must
> >> be splitted (so it becomes non-atomic), or you'd have to return a short
> >> write (which IIRC is not supposed to happen for local filesystems).
> >>
> >
> > What makes you say that short writes are not supposed to happen?
>
> I don't think it was an authoritative source, but I I've repeatedly read
> that "you do not have to worry about short reads/writes when accessing
> the local disk". I expect this to be a common expectation to be baked
> into programs, no matter if valid or not.
>

Even if that statement would have been considered true, since when can
we speak of FUSE as a "local filesystem".
IMO it follows all the characteristics of a "network filesystem".

> > Seems like the options for FUSE are:
> > - Take shared i_rwsem lock on read like XFS and regress performance of
> >   mixed rw workload
> > - Do the above only for non-direct and writeback_cache to minimize the
> >   damage potential
> > - Return short read/write for direct IO if request is bigger that FUSE
> > buffer size
> > - Add a FUSE mode that implements direct IO internally as something like
> >   RWF_UNCACHED [2] - this is a relaxed version of "no caching" in client or
> >   a stricter version of "cache write-through"  in the sense that
> > during an ongoing
> >   large write operation, read of those fresh written bytes only is served
> >   from the client cache copy and not from the server.
>
> I didn't understand all of that, but it seems to me that there is a
> fundamental problem with splitting up a single write into multiple FUSE
> requests, because the second request may fail after the first one
> succeeds.
>

I think you are confused by the use of the word "atomic" in the standard.
It does not mean what the O_ATOMIC proposal means, that is - write everything
or write nothing at all.
It means if thread A successfully wrote data X over data Y, then thread B can
either read X or Y, but not half X half Y.
If A got an error on write, the content that B will read is probably undefined
(excuse me for not reading what "the law" has to say about this).
If A got a short (half) write, then surely B can read either half X or half Y
from the first half range. Second half range I am not sure what to expect.

So I do not see any fundamental problem with FUSE write requests.
On the contrary - FUSE write requests are just like any network protocol write
request or local disk IO request for that matter.

Unless I am missing something...

Thanks,
Amir.
