Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF64447B2BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 19:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbhLTSWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 13:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbhLTSWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:22:24 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D9BC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 10:22:23 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id b187so14452378iof.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 10:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8V5W+F4HIuFfDbHiqlONHDJ62RtLbM4ZtUeKHt0Yhs=;
        b=oc5pvifmKiNpNTQNPsf3xp4BkAyP0E4nAC8vCSlUNX/brj4OslDaxuIwK/xEOuxTQ7
         xZ3Uwo/epzlTJVu7HoGxLNlTb7AqeNqPDEQp6pGDe73zmRkHr/ucEaHnYA0NheTLvoib
         /bj3/KZVgTjrKBS5rLhMXmf7xIB8pjDqElj5xZIKcDnpQ4hzNwd7rRMFJ0nbiPB5TpQG
         0MBaiaqxdd/Neg42BJexZNyAFaiT1XNhIbIA2E51uFLcXZNF2LMFcHyTBijrfjiqTTQB
         t0xWskmq8AoWj2+EjfR+qaLGl28mnnxH4sHVK7VBvXBRGhmfSzFQB/Wm/dpTA40HOD77
         mI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8V5W+F4HIuFfDbHiqlONHDJ62RtLbM4ZtUeKHt0Yhs=;
        b=5C2uthZ0/2SDj1Ol+fO0kBqOMaillqLb/i4buxMMFp3zZMkBFtasbKu8FulO0dMKPL
         1u95cXalxiSmpTYCfHDJBq+mX52FtG4WWQvH+JyVyhB6yeyD0n4MbJyFRYC53KGtOAEm
         6iHdeK4z+l/s/pZd6XhjSFuHfvrMcjkjziDCT2eMKQde8thTMRZTwOQeosZB518opm3K
         /5rRtCXXxoFJ/JioGORZBkR9gfX2nmPwtXBEVnnceRps7ewY+8kE4YUU+8rfN9hq7D16
         LluOCb0yEcwU0y2ryXtUvCiNqyI/HJaLy8NucBW5LOtB0ZbpeFOIxuV8Hu9zsfER8ymJ
         Q69g==
X-Gm-Message-State: AOAM531vOBeUnRe0Ylep5aUiNCszcDPO8l75faPo7ZPueWdzasiRmLg3
        MvHSHZWS1PhgMA2qe+Jhajqy+4hl1uS5G7EoNlelow+f
X-Google-Smtp-Source: ABdhPJziTWonqd9i45OM1Dzst7pVMU0NHxrrWkfz5g/xzE7ffXCh1uT9nnBGq0tgwbBWaHw7ZoGfm0nKX6WqJXP9yx0=
X-Received: by 2002:a02:aa98:: with SMTP id u24mr7816686jai.41.1640024543043;
 Mon, 20 Dec 2021 10:22:23 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxj9XZNhHB3y9LuGcUJYp-i4f-LXQa2tzX8AkZpRERH+8w@mail.gmail.com>
 <Ybo/5h9umGlinaM4@redhat.com> <CAOQ4uxheVq-YHkT9eOu3vUNt1RU4Wa6MkyzXXLboHE_Pj6-6tw@mail.gmail.com>
 <CAOQ4uxjzW7mt0pqA+K_sEJokYcv_D3e7axAOWLXxQ84bZDnfcw@mail.gmail.com>
 <YbtoQGKflkChU8lZ@redhat.com> <CAOQ4uxhucsMYO1YdHdLDPBJEaoOOyXb57wFJgijQznis2feE1A@mail.gmail.com>
 <Ybu8gBglHi+xikww@redhat.com> <CAOQ4uxj6FKZr_QWRN_Ts14+dcT1cxR6PmtZCJEyp2chCGKVh7w@mail.gmail.com>
 <YbybZQHaSxV5MXkI@redhat.com> <CAOQ4uxiWL8bc6f1qY+uzr3_FyN3S3o7sMToqy08G8okHOX-LEQ@mail.gmail.com>
 <YcCySSZC3ZmN8+q1@redhat.com>
In-Reply-To: <YcCySSZC3ZmN8+q1@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 20 Dec 2021 20:22:11 +0200
Message-ID: <CAOQ4uxiHB8khGU7ti7XLXriSqMU+Wn3uMk=Vq4C2ZvzAWu_w9g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>,
        Stef Bon <stefbon@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>,
        Nathan Youngman <git@nathany.com>,
        Ioannis Angelakopoulos <jaggel@bu.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 20, 2021 at 6:42 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Sat, Dec 18, 2021 at 10:28:35AM +0200, Amir Goldstein wrote:
> > > > >
> > > > > > 2. For FS_RENAME, will we be able to pass 4 buffers in iov?
> > > > > >     src_fuse_notify_fsnotify_out, src_name,
> > > > > >     dst_fuse_notify_fsnotify_out, dst_name
> > > > >
> > > > > So it is sort of two fsnotify events travelling in same event. We will
> > > > > have to have some sort of information in the src_fuse_notify_fsnotify_out
> > > > > which signals that another fsnotify_out is following. May be that's
> > > > > where fsnotify_flags->field can be used. Set a bit to signal another
> > > > > fsnotify_out is part of same event and this will also mean first one
> > > > > is src and second one is dst.
> > > > >
> > > > > Challenge I see is "src_name" and "dst_name", especially in the context
> > > > > of virtio queues.
> > > > >
> > > > > So we have a notification queue and for each notification, driver
> > > > > allocates a fixed amount of memory for each element and queues these
> > > > > elements in virtqueue. Server side pops these elements, places
> > > > > notification info in this vq element and sends back.
> > > > >
> > > > > So basically size of notification buffer needs to be known in advance,
> > > > > because these are allocated by driver (and not device/server). And
> > > > > that's the reason virtio spec has added a new filed "notify_buf_size"
> > > > > in device configuration space. Using this field device lets the driver
> > > > > know how much memory to allocate for each notification element.
> > > > >
> > > > > IOW, we can put variable sized elements in notifiation but max size
> > > > > of that variable length needs to be fixed in advance and needs to
> > > > > be told to driver at device initialization time.
> > > > >
> > > > > So what can be the max length of "src_name" and "dst_name"? Is it fair
> > > > > to use NAME_MAX to determine max length of name. So say "255" bytes
> > > > > (not including null) for each name. That means notify_buf_size will
> > > > > be.
> > > > >
> > > > > notify_buf_size = 2 * 255 + 2 * sizeof(struct fuse_notify_fsnotify_out);
> > > > >
> > > >
> > > > Can you push two subsequent elements to the events queue atomically?
> > > > If you can, then it is not a problem to queue the FS_MOVED_FROM
> > > > event (with one name) followed by FS_MOVED_TO event with
> > > > a self generated cookie in response to FAN_RENAME event on virtiofsd
> > > > server and rejoin them in virtiofs client.
> > >
> > > Hmm..., so basically break down FAN_RENAME event into two events joined
> > > by cookie and send them separately. I guess sounds reasonable because
> > > it helps reduce the max size of event.
> > >
> > > What do you mean by "atomically"? Do you mean strict ordering and these
> > > two events are right after each other. But if they are joined by cookie,
> > > we don't have to enforce it. Driver should be able to maintain an internal
> > > list and queue the event and wait for pair event to arrive. This also
> >
> > This is what I would consider repeating mistakes of past APIs (i.e. inotify).
> > Why should the driver work hard to join events that were already joint before
> > the queue? Is there really a technical challenge in queueing the two events
> > together?
>
> We can try queuing these together but it might not be that easy. If two
> elements are not available at the time of the queuing, then you will
> to let go the lock, put that element back in the queue and retry later.
>
> To me, it is much simpler and more flexible to not guarantee strict
> ordering and let the events be joined by cookie. BTW, we are using
> cookie anyway. So strict ordering should not be required.
>
> All I am saying is that implementation can still choose to send two
> events together one after the other, but this probably should not be
> a requirement on the part of the protocol.
>
> So what's the concern with joining the event with cookie API? I am
> not aware what went wrong in the past.
>
> One thing simpler with atomic event is that if second event does not
> come right away, we can probably discard first event saying some
> error happened. But if we join them by cookie and second event does
> not come, its not clear how do to error handling and how long guest
> driver should wait for second event to arrive.
>
> With the notion of enforcing atomicity, I am concerned about some
> deadlock/starvation possibility where you can't get two elements
> together at all. For example, some guest driver decides to instantiate
> queue only with 1 element.
>
> So is it doable, it most likely is. Still, I am not sure we should try to
> enforce atomicity. Apart from error handling, I am unable to seek
> what other issues exist with non-atomic joined events. Maybe you can
> help me understand better why requiring atomicity is a better option.
>

As UAPI the cookie interface is non reliable and users don't know how long
they would need to wait for the other part and how many rename states
to maintain and generally, most applications got it wrong and assumed to
many things about ordering and such.

As an internal virtio protocol you can do whatever ends up being more
easy for you as long as you are able to call the vfs fsnotify() API with
both src and dst dirs.

My feeling is that it is easier to queue two elements together.
I think it is possible to prevent starvation, by some reservation.
For example, if you allocate N+1 slots, but treat the queue as
"full" when there are N elements in the queue -
only a 2-elements push can dip into the +1 reservation if the
queue is not "full".

You can try this way or the other and choose for yourself.

Thanks,
Amir.
