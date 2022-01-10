Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3271C489E4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 18:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbiAJRZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 12:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238202AbiAJRZN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:25:13 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCF5C06173F
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jan 2022 09:25:13 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id d7so7002974ybo.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jan 2022 09:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S49UlxL/fsiTamxTIgefeURrqnW3PFqiJDDCzTc/0cc=;
        b=VCdeKW3sNP+kY6RTFC/xDpcb6BGp9EFzyrlM8ZMqgpZHIL4xCzt4ONzlz0iXBKAs6A
         QIzGQBKrqqzWhUm+c0djm+bbedLM7nFmAKNNYybG752cXjGeMmIQVF+QhPbltPM/2VhG
         f7r/J8vEF3BxJ69LvJ+7jpkKy1u2C5VYnMZwlqnjVB2y1UCcgMDABX0/5ZKBQ1rj2pMF
         V8NwgXcMILRZCjB2iqkYE31Kfyx6mgaFxTg7QrTjO3QzrKHOxEH4eAUCbMQAFxJQEGKx
         9pzy7hWJSTWJNfq2JHUcfnNXUBLNxrE1X4INdXGewmaVJH9E3UKqi5VzUvxFB7oATIfI
         C7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S49UlxL/fsiTamxTIgefeURrqnW3PFqiJDDCzTc/0cc=;
        b=Xs7HSOIMijCczcMmmvqnzpVlhGEQw89o9xtusHr23/QRWwDYLtIM39Aq/4DUqH8sOZ
         Xst2eNXhuhsMdFl9Gl6r1FmU8Q+Kj6E3arVYIEuxrUCEFcUFXDCh1azVaMKWLDkn1A0/
         1eulHbNAkQdta4QOc1qGcYw6FI80dQ6uYWXmUyHygFh9P6WaDV6Q/ql5FOEHb0osj6tT
         yBqxAT31RsPfoYhLbxOMWnFoQMbrFbBES6zTp5ZTRCyghRKCC9XeIz/sVaCW8RnJdelq
         rsSZUQvQ+AJ57jOY2E3ALBpv7/y6hHJZdE/Rdcs9JUtRYdAg9L75bavzPBBPUHZpzqRG
         ULXg==
X-Gm-Message-State: AOAM533YNNPiDgo0C/Cjpnlzx3yO5NInf/rkdtJWHyF7VrQbxon1o0hI
        jos9TjpV49gb8GlTPkwUoBXlGSV4OdGBFGCy+s5tcw==
X-Google-Smtp-Source: ABdhPJxGq+zYLLxC8sn7LZDUsLrH4GX6FkkADsYi2zUYF9m5j4rlWu6WSTZbP9nlpFwN9FhHCK4Gnu8L8/uSWMlf4HE=
X-Received: by 2002:a05:6902:703:: with SMTP id k3mr758294ybt.225.1641835511962;
 Mon, 10 Jan 2022 09:25:11 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e8f8f505d0e479a5@google.com> <20211211015620.1793-1-hdanton@sina.com>
 <YbQUSlq76Iv5L4cC@sol.localdomain> <YdW3WfHURBXRmn/6@sol.localdomain>
 <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com>
 <CAHk-=wjddvNbZBuvh9m_2VYFC1W7HvbP33mAzkPGOCHuVi5fJg@mail.gmail.com>
 <CAHk-=wjn5xkLWaF2_4pMVEkZrTA=LiOH=_pQK0g-_BMSE-8Jxg@mail.gmail.com> <Ydw4hWCRjAhGfCAv@cmpxchg.org>
In-Reply-To: <Ydw4hWCRjAhGfCAv@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 10 Jan 2022 09:25:00 -0800
Message-ID: <CAJuCfpHg=SPzx7SGUL75DVpMy0BDEwVj4o-SM0UKGmEJrOSdvg@mail.gmail.com>
Subject: Re: psi_trigger_poll() is completely broken
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 10, 2022 at 5:45 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Jan 05, 2022 at 11:13:30AM -0800, Linus Torvalds wrote:
> > On Wed, Jan 5, 2022 at 11:07 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > Whoever came up with that stupid "replace existing trigger with a
> > > write()" model should feel bad. It's garbage, and it's actively buggy
> > > in multiple ways.
> >
> > What are the users? Can we make the rule for -EBUSY simply be that you
> > can _install_ a trigger, but you can't replace an existing one (except
> > with NULL, when you close it).
>
> Apologies for the delay, I'm traveling right now.
>
> The primary user of the poll interface is still Android userspace OOM
> killing. I'm CCing Suren who is the most familiar with this usecase.
>
> Suren, the way the refcounting is written right now assumes that
> poll_wait() is the actual blocking wait. That's not true, it just
> queues the waiter and saves &t->event_wait, and the *caller* of
> psi_trigger_poll() continues to interact with it afterwards.

Thanks for adding me, Johannes. I see where I made a mistake.
Terribly sorry for the trouble this caused. I do feel bad.

>
> If at all possible, I would also prefer the simplicity of one trigger
> setup per fd; if you need a new trigger, close the fd and open again.
>
> Can you please take a look if that is workable from the Android side?

Yes, one trigger per fd would work fine for Android. That's how we
intended to use it.
I'm still catching up on this email thread. Once I digest it, will try
to fix this with one-trigger-per-fd approach.

About the issue of serializing concurrent writes for
cgroup_pressure_write() similar to how psi_write() does. Doesn't
of->mutex inside kernfs_fop_write_iter() serialize the writes to the
same file: https://elixir.bootlin.com/linux/latest/source/fs/kernfs/file.c#L287
?

>
> (I'm going to follow up on the static branch issue Linus pointed out,
> later this week when I'm back home. I also think we should add Suren
> as additional psi maintainer since the polling code is a good chunk of
> the codebase and he shouldn't miss threads like these.)

That would help me not to miss these emails and respond promptly.
Thanks,
Suren.

>
> > That would fix the poll() lifetime issue, and would make the
> > psi_trigger_replace() races fairly easy to fix - just use
> >
> >         if (cmpxchg(trigger_ptr, NULL, new) != NULL) {
> >                 ... free 'new', return -EBUSY ..
> >
> > to install the new one, instead of
> >
> >         rcu_assign_pointer(*trigger_ptr, new);
> >
> > or something like that. No locking necessary.
> >
> > But I assume people actually end up re-writing triggers, because
> > people are perverse and have taken advantage of this completely broken
> > API.
> >
> >                Linus
