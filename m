Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8184A4690
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 13:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348688AbiAaMGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 07:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349727AbiAaMG3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:06:29 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B946C06173B
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 04:06:28 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id c19so10914496ybf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 04:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0AMQ8VUubvQKRvznuFsAQp/vc+0Wx5dFnNJEwTXkGho=;
        b=F83hfDYlJo+Jo2DdHXr7238oLy4K6hZLXBO5Q+XuFgzhlNa3waLxvPiLA8Zgvn07tq
         UsBfVHq5bcML0j4tzx7OM38668eXszyGKeJhDFB/nn8C1tOygmwFe7JxaLUwaTAA3Kvs
         Dv2LFf3c85RVORq4L3O1h0NpYw6+9HXf+cuGunBPwHFGYyFjBD6X0V0SQ8rDLBIUU38G
         S/toh+WuvD0MGvc+TFGK7stNlPDV3LPw2HoT1M4eCE5g8Kl9HSnjSgNfWE0Uj39QGJpk
         D95ew+YvoDM9LlejV//kAvRm6qwYOFs+CMMNF5sm1TbfxkjkxXfBf1fAF8JEf5blqGR7
         eg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AMQ8VUubvQKRvznuFsAQp/vc+0Wx5dFnNJEwTXkGho=;
        b=L70UEJrZ/LiybA0NZYz/eqhjuDzeFr7Wl1CIPMy71eadGb/cfIiArEssSk0sceImKF
         gG4Aa2qoayBL0mUZ/pmVz9bz0zKhj/6ikY+W1/oaHSGRsv0Qs1hReIRw+bht3kfdEqI1
         6DVlCRVM5fglZfJZNRc6ta+I9iPfpespR5crQUX/0lVJSZHKJ9smbj+fTebaU8N58Nij
         HtUx5qr4uUNT6jQUlT77NZuPw2ok54tuyKj8roHBnjqL2sNEOU9KpixeH5oQmWI0jX0L
         lmPB8WFY8ObvDQCENDkI3d6BbmS4bxjvqX1kG+NHZ+tl06yQjFcvDNRlcdKlrSKnT1Dn
         0AFw==
X-Gm-Message-State: AOAM5314jYXXDFYmUpWETNBJyPzc0grsixITLcl9rAcTXT9LmdxbFDw5
        1GyxTGfiA6i4q8F0vveqLjzwNfCMG5Yw1oT+Yv4=
X-Google-Smtp-Source: ABdhPJyU7ZNGldNg0BWZDt+hFMbYPDBGKJ8vt82qkNDjPGq/yZWOtobATH8tSnAXaJYSrmVvHmdi7pRTowPeqFFRMZA=
X-Received: by 2002:a25:18d6:: with SMTP id 205mr29739399yby.230.1643630787804;
 Mon, 31 Jan 2022 04:06:27 -0800 (PST)
MIME-Version: 1.0
References: <CAL-cVeifoTfbYRfOcb0YeYor+sCtPWo_2__49taprONhR+tncw@mail.gmail.com>
 <CAL-cVeiHF3+1bq9+RLsdZU-kzfMNYxD0CJBGVeKOrrEpBAyt4Q@mail.gmail.com> <ad60a99826063822d4a9fbe12ebb20f285a20410.camel@kernel.org>
In-Reply-To: <ad60a99826063822d4a9fbe12ebb20f285a20410.camel@kernel.org>
From:   Ivan Zuboff <anotherdiskmag@gmail.com>
Date:   Mon, 31 Jan 2022 15:06:16 +0300
Message-ID: <CAL-cVejy_pDAthiE1DEsDHwfj2mTYK42BoFVPE6ZsA3YNC+a4w@mail.gmail.com>
Subject: Re: Fwd: Bug: lockf returns false-positive EDEADLK in multiprocess
 multithreaded environment
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 2:21 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Mon, 2022-01-31 at 12:37 +0300, Ivan Zuboff wrote:
> > Hello, Jeff!
> >
> > Several weeks ago I mailed linux-fsdevel about some weird behavior
> > I've found. To me, it looks like a bug. Unfortunately, I've got no
> > response, so I decided to forward this message to you directly.
> >
> > Sorry for the interruption and for my bad English -- it's not my
> > native language.
> >
> > Hope to hear your opinion on this!
> >
> > Best regards,
> > Ivan
> >
>
> Sorry I missed your message. Re-cc'ing linux-fsdevel, so others can join
> in on the discussion:
>
> > ---------- Forwarded message ---------
> > From: Ivan Zuboff <anotherdiskmag@gmail.com>
> > Date: Mon, Jan 10, 2022 at 1:46 PM
> > Subject: Bug: lockf returns false-positive EDEADLK in multiprocess
> > multithreaded environment
> > To: <linux-fsdevel@vger.kernel.org>
> >
> >
> > As an application-level developer, I found a counter-intuitive
> > behavior in lockf function provided by glibc and Linux kernel that is
> > likely a bug.
> >
> > In glibc, lockf function is implemented on top of fcntl system call:
> > https://github.com/lattera/glibc/blob/master/io/lockf.c
> > man page says that lockf can sometimes detect deadlock:
> > http://manpages.ubuntu.com/manpages/xenial/man3/lockf.3.html
> > Same with fcntl(F_SETLKW), on top of which lockf is implemented:
> > http://manpages.ubuntu.com/manpages/hirsute/en/man3/fcntl.3posix.html
> >
> > Deadlock detection algorithm in the Linux kernel
> > (https://github.com/torvalds/linux/blob/master/fs/locks.c) seems buggy
> > because it can easily give false positives. Suppose we have two
> > processes A and B, process A has threads 1 and 2, process B has
> > threads 3 and 4. When this processes execute concurrently, following
> > sequence of actions is possible:
> > 1. processA thread1 gets lockI
> > 2. processB thread2 gets lockII
> > 3. processA thread3 tries to get lockII, starts to wait
> > 4. processB thread4 tries to get lockI, kernel detects deadlock,
> > EDEADLK is returned from lockf function
> >
> > Steps to reproduce this scenario (see attached file):
> > 1. gcc -o edeadlk ./edeadlk.c -lpthread
> > 2. Launch "./edeadlk a b" in the first terminal window.
> > 3. Launch "./edeadlk a b" in the second terminal window.
> >
> > What I expected to happen: two instances of the program are steadily working.
> >
> > What happened instead:
> > Assertion failed: (lockf(fd, 1, 1)) != -1 file: ./edeadlk.c, line:25,
> > errno:35 . Error:: Resource deadlock avoided
> > Aborted (core dumped)
> >
> > Surely, this behavior is kind of "right". lockf file locks belongs to
> > process, so on the process level it seems that deadlock is just about
> > to happen: process A holds lockI and waits for lockII, process B holds
> > lockII and is going to wait for lockI. However, the algorithm in the
> > kernel doesn't take threads into account. In fact, a deadlock is not
> > going to happen here if the thread scheduler will give control to some
> > thread holding a lock.
> >
> > I think there's a problem with the deadlock detection algorithm
> > because it's overly pessimistic, which in turn creates problems --
> > lockf errors in applications. I had to patch my application to use
> > flock instead because flock doesn't have this overly-pessimistic
> > behavior.
> >
> >
>
> The POSIX locking API predates the concept of threading, and so it was
> written with some unfortunate concepts around processes. Because you're
> doing all of your lock acquisition from different threads, obviously
> nothing should deadlock, but all of the locks are owned by the process
> so the deadlock detection algorithm can't tell that.
>
> If you have need to do something like this, then you may want to
> consider using OFD locks, which were designed to allow proper file
> locking in threaded programs. Here's an older article that predates the
> name, but it gives a good overview:
>
>     https://lwn.net/Articles/586904/
>
> --
> Jeff Layton <jlayton@kernel.org>

Thank you very much for your reply.

Yes, I've considered OFD locks and flock for my specific task, and
flock seemed the more reasonable solution because of its portability
(which is valuable for my task). So my specific problem is indeed
solved, I just wanted to warn kernel developers about such kind of
unexpectable behavior deep under the hood. I thought that maybe if the
algorithm in locks.c can't detect deadlock without such false
positives then maybe it shouldn't try to do it at all? I have no
specific stance on this question, I just wanted to inform the people
who may care about it and maybe would want to do something about it.

At least there will be messages in mailing list archives explaining
the situation for people who will face the same problem -- not bad in
itself!

Best regards,
Ivan
