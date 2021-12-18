Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D9A4799BA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Dec 2021 09:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhLRI2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Dec 2021 03:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhLRI2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Dec 2021 03:28:47 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A41C061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Dec 2021 00:28:47 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id x15so3463671ilc.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Dec 2021 00:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5r47P0lDnh8p/eo9TD8r7nz1nR9ZM2uNQzV6N58XN0=;
        b=O8KPMPeAGEKPrZk6Ba4+0lEiXFS8uAI3uMd7KE4ssvtKZ2wMtmG04OINsK68epbyih
         bTSzzc1ijBc0FnL+sxWy7UHAbkGY2V21IS3cET1wWyhMUUASZrqDdk2YNXDckwe1h2Vx
         r7NYFC5O60hOrP2er8JNlZ/6LoZDAYvqmK/dIBtaaneDy3t3CPUadctbhck8CpJbdmX1
         Zlt1qsyM3I0b0mHl64fP/yPedqB96tuvedCAz36aOOsMJ0gRukjOUXVIECGFxHOia+ZH
         f96mm6qtu+SvumLnQ0wCwDMCXu92uKQNmofQUANjyl+exNmGSs6S+Y6gCS655QXxnoPB
         jc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5r47P0lDnh8p/eo9TD8r7nz1nR9ZM2uNQzV6N58XN0=;
        b=5g5jtMIXLuEfyO+dbHANjt4BN81yugUbuqaCVIxn6nwgNdBG5YGWWgBtgkKzkIURjU
         o9zyYKcBpHnqqeisA43ihGugw/xefweflxEA5xXo3QAUbu41U0u1iNNdRmQyMYUHvS6P
         ZVpo4DvN7luRj0gmByjFQug3K6wOxJe/dB/VwLpHE1kl3KIdBybH544bBl6+U0/Osxdi
         Gro6SFt1XzSiXOsBHIL2le6+evcc9FQQQnSPWreV+UH7n3wibzpkH0Fao6XCzHh3QEPa
         6wYSRrOh7y3jZuauVM22qxsc8YkeF82VG5S8Y/ONGas8ppua5QQqU0qqIRrqnxrckYoR
         IsUA==
X-Gm-Message-State: AOAM532cUWH8X6tQ5CLlrkwg5JEwVxgSQGKMS62dqNaHDkak7rrtsNUA
        ZJGzlsbp/1aTMv355b0YusNjMAIxsiis4WEXUAk=
X-Google-Smtp-Source: ABdhPJxtI5BThykCcOdiO19jClP8bq+kH7QdMhzZVNT1ieaZBx1s/g+engYhn00nqzXMVH544mlo2vrOUZ6rigZ2GQU=
X-Received: by 2002:a92:d451:: with SMTP id r17mr3599673ilm.319.1639816126514;
 Sat, 18 Dec 2021 00:28:46 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxjfCs=+Of69U6moOJ9T6_zDb1wcrLXWu4DROVme1cNnfQ@mail.gmail.com>
 <YbobZMGEl6sl+gcX@redhat.com> <CAOQ4uxj9XZNhHB3y9LuGcUJYp-i4f-LXQa2tzX8AkZpRERH+8w@mail.gmail.com>
 <Ybo/5h9umGlinaM4@redhat.com> <CAOQ4uxheVq-YHkT9eOu3vUNt1RU4Wa6MkyzXXLboHE_Pj6-6tw@mail.gmail.com>
 <CAOQ4uxjzW7mt0pqA+K_sEJokYcv_D3e7axAOWLXxQ84bZDnfcw@mail.gmail.com>
 <YbtoQGKflkChU8lZ@redhat.com> <CAOQ4uxhucsMYO1YdHdLDPBJEaoOOyXb57wFJgijQznis2feE1A@mail.gmail.com>
 <Ybu8gBglHi+xikww@redhat.com> <CAOQ4uxj6FKZr_QWRN_Ts14+dcT1cxR6PmtZCJEyp2chCGKVh7w@mail.gmail.com>
 <YbybZQHaSxV5MXkI@redhat.com>
In-Reply-To: <YbybZQHaSxV5MXkI@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 18 Dec 2021 10:28:35 +0200
Message-ID: <CAOQ4uxiWL8bc6f1qY+uzr3_FyN3S3o7sMToqy08G8okHOX-LEQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>,
        Stef Bon <stefbon@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>,
        Nathan Youngman <git@nathany.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > >
> > > > 2. For FS_RENAME, will we be able to pass 4 buffers in iov?
> > > >     src_fuse_notify_fsnotify_out, src_name,
> > > >     dst_fuse_notify_fsnotify_out, dst_name
> > >
> > > So it is sort of two fsnotify events travelling in same event. We will
> > > have to have some sort of information in the src_fuse_notify_fsnotify_out
> > > which signals that another fsnotify_out is following. May be that's
> > > where fsnotify_flags->field can be used. Set a bit to signal another
> > > fsnotify_out is part of same event and this will also mean first one
> > > is src and second one is dst.
> > >
> > > Challenge I see is "src_name" and "dst_name", especially in the context
> > > of virtio queues.
> > >
> > > So we have a notification queue and for each notification, driver
> > > allocates a fixed amount of memory for each element and queues these
> > > elements in virtqueue. Server side pops these elements, places
> > > notification info in this vq element and sends back.
> > >
> > > So basically size of notification buffer needs to be known in advance,
> > > because these are allocated by driver (and not device/server). And
> > > that's the reason virtio spec has added a new filed "notify_buf_size"
> > > in device configuration space. Using this field device lets the driver
> > > know how much memory to allocate for each notification element.
> > >
> > > IOW, we can put variable sized elements in notifiation but max size
> > > of that variable length needs to be fixed in advance and needs to
> > > be told to driver at device initialization time.
> > >
> > > So what can be the max length of "src_name" and "dst_name"? Is it fair
> > > to use NAME_MAX to determine max length of name. So say "255" bytes
> > > (not including null) for each name. That means notify_buf_size will
> > > be.
> > >
> > > notify_buf_size = 2 * 255 + 2 * sizeof(struct fuse_notify_fsnotify_out);
> > >
> >
> > Can you push two subsequent elements to the events queue atomically?
> > If you can, then it is not a problem to queue the FS_MOVED_FROM
> > event (with one name) followed by FS_MOVED_TO event with
> > a self generated cookie in response to FAN_RENAME event on virtiofsd
> > server and rejoin them in virtiofs client.
>
> Hmm..., so basically break down FAN_RENAME event into two events joined
> by cookie and send them separately. I guess sounds reasonable because
> it helps reduce the max size of event.
>
> What do you mean by "atomically"? Do you mean strict ordering and these
> two events are right after each other. But if they are joined by cookie,
> we don't have to enforce it. Driver should be able to maintain an internal
> list and queue the event and wait for pair event to arrive. This also

This is what I would consider repeating mistakes of past APIs (i.e. inotify).
Why should the driver work hard to join events that were already joint before
the queue? Is there really a technical challenge in queueing the two events
together?

> means that these broken down events will have to be joined back, possibly
> by some fsnotify helper.
>

Currently, for local events, fsnotify() gets from vfs old dir inode and old name
and the moved dentry, from which fanotify extracts all other information.
Same for events on child (e.g. FS_OPEN).

Getting that moved (or opened) fuse dentry may be a challenge.
Driver can look for a dentry with the parent dir and child inode and name,
but there may not be such an entry in dcache or no such entry at all,
by the time the event is read by the driver.

I guess in that case, we could allow passing a disconnected dentry
and teach fanotify how to deal with it and not report the NEW_DFID
record or the child FID record, so I think it's doable.

> We will probably need a flag to differentiate whether its the case of
> broken down FAN_RENAME or not. Because in this case driver will wait
> for second event to arrive. But if it is regular FS_MOVED_FROM event,
> then don't wait and deliver it to user space.
>

Yes, a "multi part event" flag.

> Driver will have to be careful to not block actual event queue event
> while waiting for pair event to arrive. It should create a copy and
> add virtqueue element back to notification queue. Otherwise deadlock
> is possible where all elements in virtqueue are being used to wait for
> pair event and no free elements are available to actually send paired
> event.
>

See, this is the unneeded complexity I am talking about.
Letting the server wait until there are swo slots available in the queue
and always queue the two parts together seems a lot easier, unless
I am missing something?

> >
> > You see, I don't mind using the rename cookie API as long as rejoining
> > the disjoint events is possible for reporting the joint event to fanotify user.
>
> Right this will allow server to join independent FAN_MOVED_FROM and
> FAN_MOVED_TO if need be.
>

Yes, if the server wants, it can work harder to join independent inotify events,
but it is not a must.

> >
> > In case virtiofsd backend is implemented with inotify, it will receive and
> > report only disjoint events and in that case, FAN_RENAME cannot be
> > requested by fanotify user which is fine, as long as it will be possible
> > with another implementation of virtiofsd server down the road.
>
> Fair enough. In simplest form, virtiofsd will support FAN_RENAME only if
> host kernel fanotify supports FAN_RENAME.

Correct.
Or as I wrote before, a multi-client server can also report FS_RENAME
after executing a rename request from another client.
You need to think of the remote fsnotify service in a manner that is completely
detached from the backend facility used to provide the notifications.

>
> In more advanced form, virtiofsd (or other server) can wait for two
> events and then join and report as FAN_RENAME with user space generated
> cookie.
>

Yeh, that's possible.

> I think I like this idea of reporting two events joined by cookie to
> reduce the size of event. Will give it a try.
>

I am glad we seem to be converging :)

Thanks,
Amir.
