Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6634A47CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 14:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377441AbiAaNKU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 08:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348565AbiAaNKU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:10:20 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107D5C061714
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 05:10:20 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id k31so40311919ybj.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 05:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zCiQW12y2tKZp4siqxbLJ1yrcW41A6apuVzZPf/qQps=;
        b=C06GSVqI9kdSSGPc35TamFnJ8Ojhj3kCKkiw+yCRCK2UkaWTLTLRcrxv5yMDgxhGhh
         zCjb+w6MAgeM9D26flhnsmcXyy1qlkzcrwnbF0LPoRnpKIGAZeVOLfYcX80rn73/smU/
         pRDI7UYMatrUHMxTH9JCPKABvd1TcedE2qakZc63uOyJvgkNTOHP1LSLgn31S4cHLIVl
         4zcQObOYtZLuMfWRR+eeiZkE/ooEqhgo7QB9qjAcUOu0la9X2TSTJ9jqsRNEW/lZnnak
         kH/4AeDEtna+T1MZakABnkvHIgPhDGeaKazfWcIDK9w2k65QNRGquyeeOnPhHXvcEyMJ
         IxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zCiQW12y2tKZp4siqxbLJ1yrcW41A6apuVzZPf/qQps=;
        b=E95fxi7y9pW+W1s7ki9q8UIYfyU2o6U3fzKeFZMsDtPK+rSvlhHzpYXFW+FbPZ4YvE
         nJwNRXAiNDU48wM1grCkXyCVyAHiUrtgN4B9Vxs6yixKPnNQffBB3ZvD8vOZz7ft7w+y
         JdUjTQqnOXLFhRyKMJ/o1Sjfc0MBvoR93MnPeYTQKmwD7IiZm4YXEmGv7cieIePi1b6S
         i5i/pdpPe0GRH1jLIO6Ts1aWiS8Hi3xAIAkLRJm939bGaJ6IEOoOgpnqzJYB1TZKnNxb
         cEBdxGGw8/Hnnq1pjuV/k3rNTOe6GlYh2eQzoNlOO2Pcgd1NA7cDYOHmNxZCY6G83QM3
         MnMg==
X-Gm-Message-State: AOAM533Pi4aMhFlzSws6pxYy0bLjOldFssYVtoz5Qlp4dt2jGLMbbxS4
        u+ggsVTh7M2DhtOgsLpe6sSIGw/amEbab9jh2UNGFX0/590L+Q==
X-Google-Smtp-Source: ABdhPJyP7DbSScbU9h99ar85aYBcg8/G/Qj2kBbgvZNTbxjDMErEz3Xw/r1FXDlxZhHXWzjWWMA9Y6rUsMhPus/U+Kg=
X-Received: by 2002:a25:cad6:: with SMTP id a205mr31575593ybg.80.1643634617952;
 Mon, 31 Jan 2022 05:10:17 -0800 (PST)
MIME-Version: 1.0
References: <CAL-cVeifoTfbYRfOcb0YeYor+sCtPWo_2__49taprONhR+tncw@mail.gmail.com>
 <CAL-cVeiHF3+1bq9+RLsdZU-kzfMNYxD0CJBGVeKOrrEpBAyt4Q@mail.gmail.com>
 <ad60a99826063822d4a9fbe12ebb20f285a20410.camel@kernel.org>
 <CAL-cVejy_pDAthiE1DEsDHwfj2mTYK42BoFVPE6ZsA3YNC+a4w@mail.gmail.com> <053a252018504705d11df27eef3e8a42a24381a1.camel@kernel.org>
In-Reply-To: <053a252018504705d11df27eef3e8a42a24381a1.camel@kernel.org>
From:   Ivan Zuboff <anotherdiskmag@gmail.com>
Date:   Mon, 31 Jan 2022 16:10:06 +0300
Message-ID: <CAL-cVehNDpiJ693=R5c_ZBZLhWjvZL1xPSnXSRpo8Xesu2r_Yg@mail.gmail.com>
Subject: Re: Fwd: Bug: lockf returns false-positive EDEADLK in multiprocess
 multithreaded environment
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 3:45 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Mon, 2022-01-31 at 15:06 +0300, Ivan Zuboff wrote:
> > On Mon, Jan 31, 2022 at 2:21 PM Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > On Mon, 2022-01-31 at 12:37 +0300, Ivan Zuboff wrote:
> > > > Hello, Jeff!
> > > >
> > > > Several weeks ago I mailed linux-fsdevel about some weird behavior
> > > > I've found. To me, it looks like a bug. Unfortunately, I've got no
> > > > response, so I decided to forward this message to you directly.
> > > >
> > > > Sorry for the interruption and for my bad English -- it's not my
> > > > native language.
> > > >
> > > > Hope to hear your opinion on this!
> > > >
> > > > Best regards,
> > > > Ivan
> > > >
> > >
> > > Sorry I missed your message. Re-cc'ing linux-fsdevel, so others can j=
oin
> > > in on the discussion:
> > >
> > > > ---------- Forwarded message ---------
> > > > From: Ivan Zuboff <anotherdiskmag@gmail.com>
> > > > Date: Mon, Jan 10, 2022 at 1:46 PM
> > > > Subject: Bug: lockf returns false-positive EDEADLK in multiprocess
> > > > multithreaded environment
> > > > To: <linux-fsdevel@vger.kernel.org>
> > > >
> > > >
> > > > As an application-level developer, I found a counter-intuitive
> > > > behavior in lockf function provided by glibc and Linux kernel that =
is
> > > > likely a bug.
> > > >
> > > > In glibc, lockf function is implemented on top of fcntl system call=
:
> > > > https://github.com/lattera/glibc/blob/master/io/lockf.c
> > > > man page says that lockf can sometimes detect deadlock:
> > > > http://manpages.ubuntu.com/manpages/xenial/man3/lockf.3.html
> > > > Same with fcntl(F_SETLKW), on top of which lockf is implemented:
> > > > http://manpages.ubuntu.com/manpages/hirsute/en/man3/fcntl.3posix.ht=
ml
> > > >
> > > > Deadlock detection algorithm in the Linux kernel
> > > > (https://github.com/torvalds/linux/blob/master/fs/locks.c) seems bu=
ggy
> > > > because it can easily give false positives. Suppose we have two
> > > > processes A and B, process A has threads 1 and 2, process B has
> > > > threads 3 and 4. When this processes execute concurrently, followin=
g
> > > > sequence of actions is possible:
> > > > 1. processA thread1 gets lockI
> > > > 2. processB thread2 gets lockII
> > > > 3. processA thread3 tries to get lockII, starts to wait
> > > > 4. processB thread4 tries to get lockI, kernel detects deadlock,
> > > > EDEADLK is returned from lockf function
> > > >
> > > > Steps to reproduce this scenario (see attached file):
> > > > 1. gcc -o edeadlk ./edeadlk.c -lpthread
> > > > 2. Launch "./edeadlk a b" in the first terminal window.
> > > > 3. Launch "./edeadlk a b" in the second terminal window.
> > > >
> > > > What I expected to happen: two instances of the program are steadil=
y working.
> > > >
> > > > What happened instead:
> > > > Assertion failed: (lockf(fd, 1, 1)) !=3D -1 file: ./edeadlk.c, line=
:25,
> > > > errno:35 . Error:: Resource deadlock avoided
> > > > Aborted (core dumped)
> > > >
> > > > Surely, this behavior is kind of "right". lockf file locks belongs =
to
> > > > process, so on the process level it seems that deadlock is just abo=
ut
> > > > to happen: process A holds lockI and waits for lockII, process B ho=
lds
> > > > lockII and is going to wait for lockI. However, the algorithm in th=
e
> > > > kernel doesn't take threads into account. In fact, a deadlock is no=
t
> > > > going to happen here if the thread scheduler will give control to s=
ome
> > > > thread holding a lock.
> > > >
> > > > I think there's a problem with the deadlock detection algorithm
> > > > because it's overly pessimistic, which in turn creates problems --
> > > > lockf errors in applications. I had to patch my application to use
> > > > flock instead because flock doesn't have this overly-pessimistic
> > > > behavior.
> > > >
> > > >
> > >
> > > The POSIX locking API predates the concept of threading, and so it wa=
s
> > > written with some unfortunate concepts around processes. Because you'=
re
> > > doing all of your lock acquisition from different threads, obviously
> > > nothing should deadlock, but all of the locks are owned by the proces=
s
> > > so the deadlock detection algorithm can't tell that.
> > >
> > > If you have need to do something like this, then you may want to
> > > consider using OFD locks, which were designed to allow proper file
> > > locking in threaded programs. Here's an older article that predates t=
he
> > > name, but it gives a good overview:
> > >
> > >     https://lwn.net/Articles/586904/
> > >
> > > --
> > > Jeff Layton <jlayton@kernel.org>
> >
> > Thank you very much for your reply.
> >
> > Yes, I've considered OFD locks and flock for my specific task, and
> > flock seemed the more reasonable solution because of its portability
> > (which is valuable for my task). So my specific problem is indeed
> > solved, I just wanted to warn kernel developers about such kind of
> > unexpectable behavior deep under the hood. I thought that maybe if the
> > algorithm in locks.c can't detect deadlock without such false
> > positives then maybe it shouldn't try to do it at all?
> >
>
> Heh, I once made this argument as well, but it does work in some
> traditional cases so we decided to keep it around. It is onerous to
> track though.
>
> OFD and flock locks specifically do not do any sort of deadlock
> detection (thank goodness).
>
>
> > I have no
> > specific stance on this question, I just wanted to inform the people
> > who may care about it and maybe would want to do something about it.
> >
> > At least there will be messages in mailing list archives explaining
> > the situation for people who will face the same problem -- not bad in
> > itself!
> >
>
> I think the moral of the story is that you don't really want to use
> classic POSIX locks in anything that involves locking between different
> threads, as their design just doesn't mesh well with that model.
>
> We did try to convey that in the fcntl manpage in the lead-in to OFD
> locks section:
>
>        *  The threads in a process share locks.  In other words, a multi=
=E2=80=90
>           threaded  program  can't  use  record  locking  to  ensure that
>           threads don't simultaneously access the same region of a file.
>
> Maybe we need to revise that to be more clear? Or possibly add something
> that points out that this can also manifest as false-positives in
> deadlock detection?
>
> --
> Jeff Layton <jlayton@kernel.org>

Yes, I see the moral of this story the same way as you.

I read this passage in fcntl manpage before when I thought about the
best way to solve my problem. In my opinion, this description tells
about another problem. It says that record locking will not help with
races between threads because record locking is performed on the
thread level. Okay, I thought, I have a mutex for that purpose. But in
my humble opinion, it would be great if manpage said that record locks
not just "don't protect threads from each other" but "don't pair well
with threading at all, because it can interfere with threading in
counter-intuitive way". So yes, I fully appreciate an idea to edit
manpage. But I personally have zero experience dealing with manpage
documentation so I'd prefer someone else did it, to be honest. Of
course, if it's possible.

Best regards,
Ivan
