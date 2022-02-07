Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CA54AB2E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 01:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242940AbiBGAIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 19:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBGAIB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 19:08:01 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2CBC061348;
        Sun,  6 Feb 2022 16:07:59 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id f13so7893423uab.10;
        Sun, 06 Feb 2022 16:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FGDwZ1SSozpEqzky0FYUIfLiTK6N8OPpsp2lMvYE0Z8=;
        b=mPK7dMCm1uiwMfLRnUhk10L6BZhOUGGzJrOX/HyMyzEIoeshplD+u33el7kCi5H8Px
         7GQEtdBPBU9wtivV9xreOavBETE7p7kCXgeY4NULuNwmpXG5uCuA/4uzV0/GoR0UGOJe
         SrwDXKpFOnJfB7vznCjOdd1CRREhHptJryE3Qt3hE9YpxVGaGsBDlrb8pBlZNhhZ4Abs
         Gc0gsfoZspQqkd/9yFUlNdYRSpTi10/H8x22qoBiG4oIn7lFr/QruhaeeVK84ruk3wcv
         eQL828vYz8wfgMFay2Ep4bKQ907HRJAj+VWO4yAfsVKAo5qB+oZzH/wRuO9KsBFyjYWW
         sImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FGDwZ1SSozpEqzky0FYUIfLiTK6N8OPpsp2lMvYE0Z8=;
        b=WlsMtiMJ46bgrDgxgNtim3ZFpV0+b0pYTcZV8wnKbO+WYZmsLOiNaJCaKXprhJQWxd
         wGXI/crkVRTk0lZfuc76PkzVR0f7n+PX7JjcmulTQEpNWtFctPtoxtj9S9gXDAOrDGiW
         9jpZ5JVFdMqMneFlwFzEQ1rQLyCPLdXIEglPa+1e+agG7VWcSznCrfGsbH7P4aSAGQRt
         FgKYXHvld/jelDVQRvM0YK0q5g1VsHB7hAhEQJ1edXo7XNiQAptMBY48LL41meB/Wo63
         I9oVJYiacq8hiT6Ax0bleV0yIwqvXgb99jTetw6TRpKb9FE/LjDTNOkRSSfIK8YL45Bn
         lq3Q==
X-Gm-Message-State: AOAM531sV1aY/4eRtcUxXJlq8bLSjmbX6S3qwIPln7KPjVZY5mdRDfQg
        h+nDSvoD7GrVWntI960kS9OIg+mkuebWNWVSz2o=
X-Google-Smtp-Source: ABdhPJz6DJFgJu2WEG46TCAbsSIHtrD0faCxmDdib6fVo9dUM0cUgXZe/alfRWod2MoSnmG2sweD6Dk28RdCXrz1M3Y=
X-Received: by 2002:a05:6102:3a7a:: with SMTP id bf26mr3516249vsb.27.1644192478969;
 Sun, 06 Feb 2022 16:07:58 -0800 (PST)
MIME-Version: 1.0
References: <CAOE4rSwfTEaJ_O9Bv1CkLRnLWYoZ7NSS=5pzuQz4mUBE-PXQ5A@mail.gmail.com>
 <YfrX1BVIlIwiVYzs@casper.infradead.org> <CAOE4rSz1OTRYQPa4PUrQ-=cwSM3iVY977Uz_d77E2j-kH0G3rA@mail.gmail.com>
 <CAPj211uKvndvR40Vjh9WAf4wRbaV5MSnmUsvDAEAKv3Q+2tDkA@mail.gmail.com>
 <Yf/DiefrNOkib5mm@casper.infradead.org> <CAPj211uFgCyri=RKnOJs2cV7-9FRFjOPLti8Jo0ODZeHEPgGAw@mail.gmail.com>
 <CAOE4rSzJtDwDpb6PDN-E1i=b5p6jePu7wnKKgwr8dnwextaxUw@mail.gmail.com> <YgBegj4a/0/PkRlc@casper.infradead.org>
In-Reply-To: <YgBegj4a/0/PkRlc@casper.infradead.org>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Mon, 7 Feb 2022 02:07:47 +0200
Message-ID: <CAOE4rSxV-BbpwNYe7cfY8Ag_mWY930yG3pubqASKHjsKXAp6TA@mail.gmail.com>
Subject: Re: How to debug stuck read?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     FMDF <fmdefrancesco@gmail.com>, linux-fsdevel@vger.kernel.org,
        BTRFS <linux-btrfs@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pirmd., 2022. g. 7. febr., plkst. 01:49 =E2=80=94 lietot=C4=81js Matthew Wi=
lcox
(<willy@infradead.org>) rakst=C4=ABja:
>
> On Mon, Feb 07, 2022 at 01:21:53AM +0200, D=C4=81vis Mos=C4=81ns wrote:
> > sv=C4=93td., 2022. g. 6. febr., plkst. 13:01 =E2=80=94 lietot=C4=81js F=
MDF
> > (<fmdefrancesco@gmail.com>) rakst=C4=ABja:
> > [...]
> > > There is no special recipe for debugging "this properly" :)
> > >
> > > You wrote that "by pure luck" you found a memcpy() that wrote beyond =
the
> > > limit of allocated memory. I suppose that you found that faulty memcp=
y()
> > > somewhere in one of the function listed in the stack trace.
> > >
> > > That's the right approach! You read the calls chain and find out wher=
e something
> > > looks wrong and then fix it. This is why stack traces are so helpful.
> > >
> > > It was not "pure luck". I think that you did what developers usually =
do after
> > > decoding a stack trace. If not, how did you find that faulty memcpy()=
 buried
> > > somewhere in 40 millions lines of code?
> > >
> > > it seems that you've found the right way to figure out the problems i=
n code
> > > that (probably) you had not ever worked on or read before you hit tha=
t bug.
> > >
> >
> > I think there should be a way to see which locks (and by who/where)
> > have been taken for a long time.
>
> Well ... we do, but the problem is that the page lock is a single bit.
> We just don't have the space in struct page for a pointer to a stack
> trace.  So the page lock isn't like a spinlock or a mutex where we can
> use the LOCKDEP infrastructure to tell us this kind of thing.
>
> Also, in this case, we know exactly where the lock was taken and by whom
> -- and it would be no more information than you had from the stack trace.

The issue here is that you have a stuck task that doesn't have any
crash/stack trace. The process itself is waiting in
folio_wait_bit_common but I need to find the other side of it.

> Something I slightly regret is that you used to get a "task blocked for
> more than 120 seconds" message from check_hung_task().  But I made
> that not show up in this path because I made the sleep killable and
> that's only called for UNINTERRUPTIBLE tasks.
>
> Maybe that should be changed.  Perhaps we should emit those messages
> for TASK_KILLABLE too.
>

Sounds like that would be very useful.

> > Yep, fully sure and tested :P I'm able to reproduce stuck process with
> > 100% reliability. After applying my patch it returns EIO as expected
> > and doesn't get stuck.
> > If you look at copy_compressed_segment (in fs/btrfs/lzo.c) you'll see
> >   kaddr =3D kmap(cur_page);
> >   memcpy(dest + *cur_in - orig_in,
> >                  kaddr + offset_in_page(*cur_in), copy_len);
> >   kunmap(cur_page);
> >
> > My guess is that kmap(cur_page) locks that page, then memcpy crashes
> > so that page never gets unmapped causing anyone that tries to map it
> > to wait forever. Hence this can be reproduced only once per boot. If I
> > knew how to find kernel thread that is running this we could check
> > it's stack and it should be stuck here on kmap.
>
> kmap() doesn't lock the page; it's already locked at this point.
> But if the memcpy() does crash then you're right, the page will never
> be unlocked because it was this thread's job to unlock it when the page
> was uptodate.  The thread will be dead, so there's no way to find it.
> Do we not dump the thread's stack on its death?

Yeah there was, but as I said it happens only once per boot. So you
have one (potentially old) crash/stacktrace but many stuck processes
with no clear cause. Eg. you get crash and stuck process, kill
process. Then days later you try reading that file again and it will
get stuck but there won't be stacktrace as it won't reach that memcpy
anymore.
