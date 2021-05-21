Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43F638CA60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 17:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhEUPrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 11:47:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232798AbhEUPrm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 11:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621611979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oiv5CMTfVr5fGq4A95QHsr3IkiN3wgJIlDUHsc03NSs=;
        b=CK6juZW/RGfUZ27Fo8Wi78NB4bvjfCGSWefbe4/LHwFaYCnmg6hL1biM8KYl81D2aYCrtT
        PqZCUwKTJQO6PWH/hYQRmVuA88DM1RhHWVGRsn7IeJq+Eij1xpQ8rjobejuTpLeCSCuJ4r
        vsuHyIJBVEt3UI09Ri8ETJREtz7wC8g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-ARhpwjcvNiyW8JmFWT-wmQ-1; Fri, 21 May 2021 11:46:17 -0400
X-MC-Unique: ARhpwjcvNiyW8JmFWT-wmQ-1
Received: by mail-wr1-f70.google.com with SMTP id a5-20020a5d6ca50000b029011035a261adso9583391wra.17
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 08:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oiv5CMTfVr5fGq4A95QHsr3IkiN3wgJIlDUHsc03NSs=;
        b=mtFk7WZfVxUn9Of8cJHX4S6VBcEctWgZinWzbIa2yFh/fiIIwkjUrn4VFcmIu3TkOM
         LTH1m9FpPSBlhfTOv31eXH6Emc5JMTgIuHaxk0YPRTFtCDAq7eQ+IurPhlmX+ZKJxKBK
         7WgozNe5fVH1zQbkW5agBxfoYPfNuzUfcH1ATuEZKyrmaqRMr9tAvCGn2fz3s55oogql
         qqDV5gM8lPlDGXg///wcOWBqCX9nhzoAj98rTODYxIHj+N2B0tNeKPVF+C8IwVnPMto2
         ThyNcPRojXGhXGFT4S5X8wZIz79ZTAQcbuUSccUHW1tbdhnHRD77cyf7uu20zFhWHZc0
         eP+g==
X-Gm-Message-State: AOAM533sqpz+0ltvN5B1ZHWiBBlGDHWPGFa6nseH2Jw98jlwPlwQKf/i
        ESL2TAL4auwvvUeQ/oN4h/bi0PztqGMSY5Rj88EQ4VOMG1QKA8kY2xGUbjtpJqmOpFfYtuLgJpV
        tEh8czpYUM8344ZuXPf6MFfSOXcetIayrGO2lCqCQFg==
X-Received: by 2002:a05:600c:4f4e:: with SMTP id m14mr9769342wmq.164.1621611976424;
        Fri, 21 May 2021 08:46:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNiKyNNQUg0ROCG/SSOfEtN4zmZrv2U5Ehc2HYyxeDqg4kgiTzYPVs1QJPabytJJQk6QNyxHUQkFNSA09pUs4=
X-Received: by 2002:a05:600c:4f4e:: with SMTP id m14mr9769331wmq.164.1621611976235;
 Fri, 21 May 2021 08:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210520122536.1596602-1-agruenba@redhat.com> <20210520122536.1596602-7-agruenba@redhat.com>
 <20210520133015.GC18952@quack2.suse.cz> <CAHc6FU7ESASp+G59d218LekK8+YMBvH9GxbPr-qOVBhzyVmq4Q@mail.gmail.com>
 <20210521152352.GQ18952@quack2.suse.cz>
In-Reply-To: <20210521152352.GQ18952@quack2.suse.cz>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 21 May 2021 17:46:04 +0200
Message-ID: <CAHc6FU6df7cBbjmYOZE35v_FALWRO62cYjg2Y9rY+Hd6x5yeyw@mail.gmail.com>
Subject: Re: [PATCH 6/6] gfs2: Fix mmap + page fault deadlocks (part 2)
To:     Jan Kara <jack@suse.cz>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 5:23 PM Jan Kara <jack@suse.cz> wrote:
> On Thu 20-05-21 16:07:56, Andreas Gruenbacher wrote:
> > On Thu, May 20, 2021 at 3:30 PM Jan Kara <jack@suse.cz> wrote:
> > > On Thu 20-05-21 14:25:36, Andreas Gruenbacher wrote:
> > > > Now that we handle self-recursion on the inode glock in gfs2_fault and
> > > > gfs2_page_mkwrite, we need to take care of more complex deadlock
> > > > scenarios like the following (example by Jan Kara):
> > > >
> > > > Two independent processes P1, P2. Two files F1, F2, and two mappings M1,
> > > > M2 where M1 is a mapping of F1, M2 is a mapping of F2. Now P1 does DIO
> > > > to F1 with M2 as a buffer, P2 does DIO to F2 with M1 as a buffer. They
> > > > can race like:
> > > >
> > > > P1                                      P2
> > > > read()                                  read()
> > > >   gfs2_file_read_iter()                   gfs2_file_read_iter()
> > > >     gfs2_file_direct_read()                 gfs2_file_direct_read()
> > > >       locks glock of F1                       locks glock of F2
> > > >       iomap_dio_rw()                          iomap_dio_rw()
> > > >         bio_iov_iter_get_pages()                bio_iov_iter_get_pages()
> > > >           <fault in M2>                           <fault in M1>
> > > >             gfs2_fault()                            gfs2_fault()
> > > >               tries to grab glock of F2               tries to grab glock of F1
> > > >
> > > > Those kinds of scenarios are much harder to reproduce than
> > > > self-recursion.
> > > >
> > > > We deal with such situations by using the LM_FLAG_OUTER flag to mark
> > > > "outer" glock taking.  Then, when taking an "inner" glock, we use the
> > > > LM_FLAG_TRY flag so that locking attempts that don't immediately succeed
> > > > will be aborted.  In case of a failed locking attempt, we "unroll" to
> > > > where the "outer" glock was taken, drop the "outer" glock, and fault in
> > > > the first offending user page.  This will re-trigger the "inner" locking
> > > > attempt but without the LM_FLAG_TRY flag.  Once that has happened, we
> > > > re-acquire the "outer" glock and retry the original operation.
> > > >
> > > > Reported-by: Jan Kara <jack@suse.cz>
> > > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > >
> > > ...
> > >
> > > > diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> > > > index 7d88abb4629b..8b26893f8dc6 100644
> > > > --- a/fs/gfs2/file.c
> > > > +++ b/fs/gfs2/file.c
> > > > @@ -431,21 +431,30 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
> > > >       vm_fault_t ret = VM_FAULT_LOCKED;
> > > >       struct gfs2_holder gh;
> > > >       unsigned int length;
> > > > +     u16 flags = 0;
> > > >       loff_t size;
> > > >       int err;
> > > >
> > > >       sb_start_pagefault(inode->i_sb);
> > > >
> > > > -     gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
> > > > +     if (current_holds_glock())
> > > > +             flags |= LM_FLAG_TRY;
> > > > +
> > > > +     gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, flags, &gh);
> > > >       if (likely(!outer_gh)) {
> > > >               err = gfs2_glock_nq(&gh);
> > > >               if (err) {
> > > >                       ret = block_page_mkwrite_return(err);
> > > > +                     if (err == GLR_TRYFAILED) {
> > > > +                             set_current_needs_retry(true);
> > > > +                             ret = VM_FAULT_SIGBUS;
> > > > +                     }
> > >
> > > I've checked to make sure but do_user_addr_fault() indeed calls do_sigbus()
> > > which raises the SIGBUS signal. So if the application does not ignore
> > > SIGBUS, your retry will be visible to the application and can cause all
> > > sorts of interesting results...
> >
> > I would have noticed that, but no SIGBUS signals were actually
> > delivered. So we probably end up in kernelmode_fixup_or_oops() when in
> > kernel mode, which just does nothing in that case.
>
> Hum, but how would we get there? I don't think fatal_signal_pending() would
> return true yet...

Hmm, right ...

> > > So you probably need to add a new VM_FAULT_
> > > return code that will behave like VM_FAULT_SIGBUS except it will not raise
> > > the signal.
> >
> > A new VM_FAULT_* flag might make the code easier to read, but I don't
> > know if we can have one.
>
> Well, this is kernel-internal API and there's still plenty of space in
> vm_fault_reason.

That's in the context of the page fault. The other issue is how to
propagate that out through iov_iter_fault_in_readable ->
fault_in_pages_readable -> __get_user, for example. I don't think
there's much of a chance to get an additional error code out of
__get_user and __put_user.

Thanks,
Andreas

