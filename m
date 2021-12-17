Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3290B47840A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 05:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhLQEVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 23:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhLQEVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:21:41 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8210C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Dec 2021 20:21:41 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id y16so1265880ioc.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Dec 2021 20:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqDmBivzng2XR0rT0C/5y1tKFxU70C4Ltba0a2wm1Hg=;
        b=VhtwVoJcFW64OIcl+6Asb90qSSA8AiJEDqOM/w8SazCELHSw89xN2/UuaO+SWlMYRC
         rHYLRR1G54l5NG4OSGP+pnxR1vBql/7dQFtbiqpeFmZG6H/l1tRWHixXPKp7HppRU8oF
         XB8PChJXDLRN2LiRFnJBt1vOeoEogJ0DH2KU2z6yJTIceHKzza61IShk3kwkJRQS0tyh
         cIyrJT/VItWOxtxX7PQJWjRenU6LxioWztdxAFUj6bjfcixkVwgS90ex4+/8VmNepUkv
         8KzKhAGwOQQUyyEksU25jJVQy7vDqzsgymc2zigMu3LVz1wAKrAS1O4Px4H2+4h3QPOW
         /YKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqDmBivzng2XR0rT0C/5y1tKFxU70C4Ltba0a2wm1Hg=;
        b=DG/mGhNTmBnFa5dfGaHEw4lDfnsBVOZaFJzrS1murZKCZJz3fsOwXyPblJPRB8aplS
         P6J84xoPxdDG4uFB5VKJgIhrPyUITTDvaZgi+BFzE4Wy1gIUrP5BRxbu1MRSzn6m+OQr
         6Dl2BY9fItYSids3C/KtzyUNFznLIf/hf3Lpk4q53YYHAP/V/7SaqJw0YNs3v2Ov8aTo
         gkStexb1epHTWxLi6zQjY2pgmpjkPscRmKNwQGcbDWl1Eu3z5KF2DjBToaowxeDv+syp
         42Kduvlq7V0GroJZ12hMVL8/SPKuwCiW0V78N0tRG+B/pg3J8KOLrhsFLYJXwVYIthz1
         5U1g==
X-Gm-Message-State: AOAM531XYZqjJ9wFv0+Da4Pd5L1ZKLp/P+IoV+l3YT79IkM5h07L/Cha
        GaFe0JdEPPJQlnhCrcJ9FYfDQpLx+9ADeWFXqSs=
X-Google-Smtp-Source: ABdhPJyoKYkAYGLFSRzEd4wMazrVgbXzlBb75mfdvPOk5oIEpGfs7IBbhvvccBDMZpKVrG3KaiqAgnPxKiw0USMVLOA=
X-Received: by 2002:a05:6602:29c2:: with SMTP id z2mr733312ioq.196.1639714901028;
 Thu, 16 Dec 2021 20:21:41 -0800 (PST)
MIME-Version: 1.0
References: <YaZC+R7xpGimBrD1@redhat.com> <CAO17o21uh3fJHd0gMu-SmZei5et6HJo91DiLk_YyfUqrtHy2pQ@mail.gmail.com>
 <CAOQ4uxjfCs=+Of69U6moOJ9T6_zDb1wcrLXWu4DROVme1cNnfQ@mail.gmail.com>
 <YbobZMGEl6sl+gcX@redhat.com> <CAOQ4uxj9XZNhHB3y9LuGcUJYp-i4f-LXQa2tzX8AkZpRERH+8w@mail.gmail.com>
 <Ybo/5h9umGlinaM4@redhat.com> <CAOQ4uxheVq-YHkT9eOu3vUNt1RU4Wa6MkyzXXLboHE_Pj6-6tw@mail.gmail.com>
 <CAOQ4uxjzW7mt0pqA+K_sEJokYcv_D3e7axAOWLXxQ84bZDnfcw@mail.gmail.com>
 <YbtoQGKflkChU8lZ@redhat.com> <CAOQ4uxhucsMYO1YdHdLDPBJEaoOOyXb57wFJgijQznis2feE1A@mail.gmail.com>
 <Ybu8gBglHi+xikww@redhat.com>
In-Reply-To: <Ybu8gBglHi+xikww@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 17 Dec 2021 06:21:28 +0200
Message-ID: <CAOQ4uxj6FKZr_QWRN_Ts14+dcT1cxR6PmtZCJEyp2chCGKVh7w@mail.gmail.com>
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

> Ok, lets spend some time on figuring out how the fsnotify_out struct
> should look like to meet the needs of fanotify as well.
>
> >
> > I thought you passed the name as buffer in iov array.
> > Or maybe that's not how it works?
> >
> > My suggestion:
> > 1. Reserve a zero padded 64bit member for future child nodeid
> >     in struct fuse_notify_fsnotify_out
>
> Ok, I think this doable. So right now it can send only one nodeid. You
> basically want to have capability to send two 64bit nodeids in same
> event, right. This is useful where you might want to send nodeid
> of dir and nodeid of child object, IIUC.

Correct, but I forgot to mention (I mentioned it earlier in review) that the
protocol should send nodeid+generation
this is not related to file handles.
It is needed to avoid reporting an event on the wrong object
when FUSE reuses nodeid.

>
> Maybe we should add a 64bit field for some sort of flags also which
> might give additional informatin about the event.
>
> It might look like.
>
> struct fuse_notify_fsnotify_out {
>         uint64_t inode;
>         uint64_t mask;

So you may want to cram 32bit gen above and make mask 32bit
depending on how much you really need to save space in the event queue.

>         uint32_t namelen;
>         uint32_t cookie;
>         /* Can carry additional info about the event */
>         uint64_t flags;
>         /* Reserved for future use. Possibly another inode node id */
>         uint64_t reserved;

Same here, we will need ino+gen for child

> };
>
> > 2. For FS_RENAME, will we be able to pass 4 buffers in iov?
> >     src_fuse_notify_fsnotify_out, src_name,
> >     dst_fuse_notify_fsnotify_out, dst_name
>
> So it is sort of two fsnotify events travelling in same event. We will
> have to have some sort of information in the src_fuse_notify_fsnotify_out
> which signals that another fsnotify_out is following. May be that's
> where fsnotify_flags->field can be used. Set a bit to signal another
> fsnotify_out is part of same event and this will also mean first one
> is src and second one is dst.
>
> Challenge I see is "src_name" and "dst_name", especially in the context
> of virtio queues.
>
> So we have a notification queue and for each notification, driver
> allocates a fixed amount of memory for each element and queues these
> elements in virtqueue. Server side pops these elements, places
> notification info in this vq element and sends back.
>
> So basically size of notification buffer needs to be known in advance,
> because these are allocated by driver (and not device/server). And
> that's the reason virtio spec has added a new filed "notify_buf_size"
> in device configuration space. Using this field device lets the driver
> know how much memory to allocate for each notification element.
>
> IOW, we can put variable sized elements in notifiation but max size
> of that variable length needs to be fixed in advance and needs to
> be told to driver at device initialization time.
>
> So what can be the max length of "src_name" and "dst_name"? Is it fair
> to use NAME_MAX to determine max length of name. So say "255" bytes
> (not including null) for each name. That means notify_buf_size will
> be.
>
> notify_buf_size = 2 * 255 + 2 * sizeof(struct fuse_notify_fsnotify_out);
>

Can you push two subsequent elements to the events queue atomically?
If you can, then it is not a problem to queue the FS_MOVED_FROM
event (with one name) followed by FS_MOVED_TO event with
a self generated cookie in response to FAN_RENAME event on virtiofsd
server and rejoin them in virtiofs client.

You see, I don't mind using the rename cookie API as long as rejoining
the disjoint events is possible for reporting the joint event to fanotify user.

In case virtiofsd backend is implemented with inotify, it will receive and
report only disjoint events and in that case, FAN_RENAME cannot be
requested by fanotify user which is fine, as long as it will be possible
with another implementation of virtiofsd server down the road.

Thanks,
Amir.
