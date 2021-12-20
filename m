Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FCA47B16D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 17:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbhLTQmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 11:42:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237078AbhLTQmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640018542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PP2ROh2IwCMQigzkUu+Hnyg/Vw8gLXDadKd/pAU0lzM=;
        b=MnoKy4YXJXaqWfYL4tojFaDWC8CCKVh3RxG20Z1nPzG+xK1oc5opyOrPJHqJClIuDm1k4r
        c02RV4xA6b639TTtWkKcvVgX9BWFB3Px3IfnuOQjNv6L9i3uTx+EhfLt72YVi7BnMAAVd7
        BdwvBBHc4ACxgR/lfCmlwaLI08k03bQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-EGsxpTvSNbmY8mgAZno4Lw-1; Mon, 20 Dec 2021 11:42:19 -0500
X-MC-Unique: EGsxpTvSNbmY8mgAZno4Lw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 406DD80BCA8;
        Mon, 20 Dec 2021 16:42:17 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57D6F60843;
        Mon, 20 Dec 2021 16:41:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B0A2D22367A; Mon, 20 Dec 2021 11:41:45 -0500 (EST)
Date:   Mon, 20 Dec 2021 11:41:45 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>,
        Stef Bon <stefbon@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>,
        Nathan Youngman <git@nathany.com>,
        Ioannis Angelakopoulos <jaggel@bu.edu>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
Message-ID: <YcCySSZC3ZmN8+q1@redhat.com>
References: <CAOQ4uxj9XZNhHB3y9LuGcUJYp-i4f-LXQa2tzX8AkZpRERH+8w@mail.gmail.com>
 <Ybo/5h9umGlinaM4@redhat.com>
 <CAOQ4uxheVq-YHkT9eOu3vUNt1RU4Wa6MkyzXXLboHE_Pj6-6tw@mail.gmail.com>
 <CAOQ4uxjzW7mt0pqA+K_sEJokYcv_D3e7axAOWLXxQ84bZDnfcw@mail.gmail.com>
 <YbtoQGKflkChU8lZ@redhat.com>
 <CAOQ4uxhucsMYO1YdHdLDPBJEaoOOyXb57wFJgijQznis2feE1A@mail.gmail.com>
 <Ybu8gBglHi+xikww@redhat.com>
 <CAOQ4uxj6FKZr_QWRN_Ts14+dcT1cxR6PmtZCJEyp2chCGKVh7w@mail.gmail.com>
 <YbybZQHaSxV5MXkI@redhat.com>
 <CAOQ4uxiWL8bc6f1qY+uzr3_FyN3S3o7sMToqy08G8okHOX-LEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiWL8bc6f1qY+uzr3_FyN3S3o7sMToqy08G8okHOX-LEQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 18, 2021 at 10:28:35AM +0200, Amir Goldstein wrote:
> > > >
> > > > > 2. For FS_RENAME, will we be able to pass 4 buffers in iov?
> > > > >     src_fuse_notify_fsnotify_out, src_name,
> > > > >     dst_fuse_notify_fsnotify_out, dst_name
> > > >
> > > > So it is sort of two fsnotify events travelling in same event. We will
> > > > have to have some sort of information in the src_fuse_notify_fsnotify_out
> > > > which signals that another fsnotify_out is following. May be that's
> > > > where fsnotify_flags->field can be used. Set a bit to signal another
> > > > fsnotify_out is part of same event and this will also mean first one
> > > > is src and second one is dst.
> > > >
> > > > Challenge I see is "src_name" and "dst_name", especially in the context
> > > > of virtio queues.
> > > >
> > > > So we have a notification queue and for each notification, driver
> > > > allocates a fixed amount of memory for each element and queues these
> > > > elements in virtqueue. Server side pops these elements, places
> > > > notification info in this vq element and sends back.
> > > >
> > > > So basically size of notification buffer needs to be known in advance,
> > > > because these are allocated by driver (and not device/server). And
> > > > that's the reason virtio spec has added a new filed "notify_buf_size"
> > > > in device configuration space. Using this field device lets the driver
> > > > know how much memory to allocate for each notification element.
> > > >
> > > > IOW, we can put variable sized elements in notifiation but max size
> > > > of that variable length needs to be fixed in advance and needs to
> > > > be told to driver at device initialization time.
> > > >
> > > > So what can be the max length of "src_name" and "dst_name"? Is it fair
> > > > to use NAME_MAX to determine max length of name. So say "255" bytes
> > > > (not including null) for each name. That means notify_buf_size will
> > > > be.
> > > >
> > > > notify_buf_size = 2 * 255 + 2 * sizeof(struct fuse_notify_fsnotify_out);
> > > >
> > >
> > > Can you push two subsequent elements to the events queue atomically?
> > > If you can, then it is not a problem to queue the FS_MOVED_FROM
> > > event (with one name) followed by FS_MOVED_TO event with
> > > a self generated cookie in response to FAN_RENAME event on virtiofsd
> > > server and rejoin them in virtiofs client.
> >
> > Hmm..., so basically break down FAN_RENAME event into two events joined
> > by cookie and send them separately. I guess sounds reasonable because
> > it helps reduce the max size of event.
> >
> > What do you mean by "atomically"? Do you mean strict ordering and these
> > two events are right after each other. But if they are joined by cookie,
> > we don't have to enforce it. Driver should be able to maintain an internal
> > list and queue the event and wait for pair event to arrive. This also
> 
> This is what I would consider repeating mistakes of past APIs (i.e. inotify).
> Why should the driver work hard to join events that were already joint before
> the queue? Is there really a technical challenge in queueing the two events
> together?

We can try queuing these together but it might not be that easy. If two
elements are not available at the time of the queuing, then you will
to let go the lock, put that element back in the queue and retry later.

To me, it is much simpler and more flexible to not guarantee strict
ordering and let the events be joined by cookie. BTW, we are using
cookie anyway. So strict ordering should not be required.

All I am saying is that implementation can still choose to send two
events together one after the other, but this probably should not be
a requirement on the part of the protocol.

So what's the concern with joining the event with cookie API? I am
not aware what went wrong in the past.

One thing simpler with atomic event is that if second event does not
come right away, we can probably discard first event saying some
error happened. But if we join them by cookie and second event does
not come, its not clear how do to error handling and how long guest
driver should wait for second event to arrive.

With the notion of enforcing atomicity, I am concerned about some
deadlock/starvation possibility where you can't get two elements
together at all. For example, some guest driver decides to instantiate
queue only with 1 element. 

So is it doable, it most likely is. Still, I am not sure we should try to
enforce atomicity. Apart from error handling, I am unable to seek
what other issues exist with non-atomic joined events. Maybe you can
help me understand better why requiring atomicity is a better option.

> 
> > means that these broken down events will have to be joined back, possibly
> > by some fsnotify helper.
> >
> 
> Currently, for local events, fsnotify() gets from vfs old dir inode and old name
> and the moved dentry, from which fanotify extracts all other information.
> Same for events on child (e.g. FS_OPEN).
> 
> Getting that moved (or opened) fuse dentry may be a challenge.
> Driver can look for a dentry with the parent dir and child inode and name,
> but there may not be such an entry in dcache or no such entry at all,
> by the time the event is read by the driver.
> 
> I guess in that case, we could allow passing a disconnected dentry
> and teach fanotify how to deal with it and not report the NEW_DFID
> record or the child FID record, so I think it's doable.
> 
> > We will probably need a flag to differentiate whether its the case of
> > broken down FAN_RENAME or not. Because in this case driver will wait
> > for second event to arrive. But if it is regular FS_MOVED_FROM event,
> > then don't wait and deliver it to user space.
> >
> 
> Yes, a "multi part event" flag.
> 
> > Driver will have to be careful to not block actual event queue event
> > while waiting for pair event to arrive. It should create a copy and
> > add virtqueue element back to notification queue. Otherwise deadlock
> > is possible where all elements in virtqueue are being used to wait for
> > pair event and no free elements are available to actually send paired
> > event.
> >
> 
> See, this is the unneeded complexity I am talking about.
> Letting the server wait until there are swo slots available in the queue
> and always queue the two parts together seems a lot easier, unless
> I am missing something?

This reminds me that in remote posix lock patches (not merged yet), I
had to deal with similar complexity. It was possible that lock
notification arrives before request reply came. So in that case, 
I was queuing notification in an internal list and pair it later with
a request reponse. Difference was that I was not creating a copy and
instead holding that virtqueue element back.

I am not sure whether waiting for two consecutive elements is more
complex or waiting in driver for second event is more complex. Anyway,
I am not particular about it. Anything is fine as long as it does
not add too much of complexity.

> 
> > >
> > > You see, I don't mind using the rename cookie API as long as rejoining
> > > the disjoint events is possible for reporting the joint event to fanotify user.
> >
> > Right this will allow server to join independent FAN_MOVED_FROM and
> > FAN_MOVED_TO if need be.
> >
> 
> Yes, if the server wants, it can work harder to join independent inotify events,
> but it is not a must.
> 
> > >
> > > In case virtiofsd backend is implemented with inotify, it will receive and
> > > report only disjoint events and in that case, FAN_RENAME cannot be
> > > requested by fanotify user which is fine, as long as it will be possible
> > > with another implementation of virtiofsd server down the road.
> >
> > Fair enough. In simplest form, virtiofsd will support FAN_RENAME only if
> > host kernel fanotify supports FAN_RENAME.
> 
> Correct.
> Or as I wrote before, a multi-client server can also report FS_RENAME
> after executing a rename request from another client.
> You need to think of the remote fsnotify service in a manner that is completely
> detached from the backend facility used to provide the notifications.

Fair enough. One can imagine a single daemon servicing multiple clients
and in that case it can report FS_RENAME event without relying on kernel
notifications.

> 
> >
> > In more advanced form, virtiofsd (or other server) can wait for two
> > events and then join and report as FAN_RENAME with user space generated
> > cookie.
> >
> 
> Yeh, that's possible.
> 
> > I think I like this idea of reporting two events joined by cookie to
> > reduce the size of event. Will give it a try.
> >
> 
> I am glad we seem to be converging :)

Me too. I think there are many low level issues to be figured out. Once
we implement it these will surface and we will ping you back. But for
now atleast we agree on fsnotify_out so that it can support both
inotify/fanotify and that's good. Time to look into making those
changes.

Vivek

