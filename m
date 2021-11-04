Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00218444E28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 06:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhKDFW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 01:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhKDFW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 01:22:26 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16215C061714;
        Wed,  3 Nov 2021 22:19:49 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id q203so5479390iod.12;
        Wed, 03 Nov 2021 22:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAk5/osJZq4gVCoii5+s2PH0Pm1YjVcsN6t5OCUDyZc=;
        b=V9s4kTZyRzgPv0jMoeyWoFlHUpjs92Fa96lGXL6b/N0v6WABgS/X35nmdrJ6I221rU
         0fSa6WgWd4eZsumy+f90w4t7c8TiRpZ/QnBCskfqitrmBptdaPoD5d4taHYlm6a+OtqI
         6kPmHx7136SfGlHm9r4zAYNJdxFJDuuhmDqW7l8Zw5cmc1NvjKwbAt6cu+VTwbGyeP0q
         rkt+Heb9ExtdsOXPxCAQTZjMqpoihft7Ri08/lC+yKhef8/MB4XyQcgdfWw8eXld3bYv
         QfO33OBzcVMT1PdpUrI/S7rTAXmX+UDmhrwGtN2WHXUiAoTGb8Ym9gvJKcgB/FqwNCUj
         P+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAk5/osJZq4gVCoii5+s2PH0Pm1YjVcsN6t5OCUDyZc=;
        b=ClRWHSgi3+tBZohp6iQH7IaGkH88QfsCut1hrKQSUNuv0P1VcdnVE+W4FnOs6H9GOj
         Q6e305R179VOc2BpfE2lp1OmW9YRW6OL5BjVxPmm+YB9AbrWEgDxCnFDh02J1tEoWlEv
         uC4IJcv2LJz7jd6nDH+hfCQqzeHm/IuMiQMkz/OSPOhu2/6+O/OtG591dqmD/a42yLfA
         sRIg7SnxlxK79JK2Bzmvz8eNtbzCbhp8ubDP2i5Hkn8lQTbDjxr0/Y/6IBhOwXTIHH/x
         Xb9ZFfrWeJEky2Ex7v63APdQXyxvraaZN23RVH2Pfv1vjcfBYFaBspLiSe0sdolHh6p9
         VWZg==
X-Gm-Message-State: AOAM531DtMmetSfXnikQqgXDO7rr4IAGHrTS5aHPoW0smtWn7+qTLlj9
        s/4fD5syQxq+ykHk85rVakdrQ63dBEbzCSOzvPB5v/Xzbjo=
X-Google-Smtp-Source: ABdhPJzXL0rW/i5L7VGc9E5w7geJK7pJl8tuFE+6e9T0eoeItHquDmwugueG2+qEdywG8B7Nx5+3SlfXXUFuRZW12EA=
X-Received: by 2002:a05:6638:1249:: with SMTP id o9mr2128265jas.47.1636003188415;
 Wed, 03 Nov 2021 22:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhpCKK2MYxSmRJYYMEWaHKy5ezyKgxaM+YAKtpjsZkD-g@mail.gmail.com>
 <YXhIm3mOvPsueWab@redhat.com> <CAO17o20sdKAWQN6w7Oe0Ze06qcK+J=6rrmA_aWGnY__MRVDCKw@mail.gmail.com>
 <CAOQ4uxhA+f-GZs-6SwNtSYZvSwfsYz4_=8_tWAUqt9s-49bqLw@mail.gmail.com>
 <20211027132319.GA7873@quack2.suse.cz> <YXm2tAMYwFFVR8g/@redhat.com>
 <20211102110931.GD12774@quack2.suse.cz> <CAOQ4uxiYQYG8Ta=MNJKpa_0pAPd0MS9PL2r_0ZRD+_TKOw6C7g@mail.gmail.com>
 <YYGg1w/q31SC3PQ8@redhat.com> <CAOQ4uxg_KAg34TgmVRQ5nrfgHddzQepVv_bAUAhqtkDfHB7URw@mail.gmail.com>
 <YYMNPqVnOWD3gNsw@redhat.com>
In-Reply-To: <YYMNPqVnOWD3gNsw@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 4 Nov 2021 07:19:37 +0200
Message-ID: <CAOQ4uxjTw+4ReoxdMKN-EX0q1dwtLCZgZq4A9qdWhgnOiRb1vg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ioannis Angelakopoulos <iangelak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > If event queue becomes too full, we might drop these events. But I guess
> > > in that case we will have to generate IN_Q_OVERFLOW and that can somehow
> > > be used to cleanup such S_DEAD inodes?
> >
> > That depends on the server implementation.
> > If the server is watching host fs using fanotify filesystem mark, then
> > an overflow
> > event does NOT mean that other new events on inode may be missed only
> > that old events could have been missed.
> > Server should know about all the watched inodes, so it can check on overflow
> > if any of the watched inodes were deleted and notify the client using a reliable
> > channel.
>
> Ok. We have only one channel for notifications. I guess we can program
> the channel in such a way so that it does not drop overflow events but
> can drop other kind of events if things get crazy. If too many overflow
> events and we allocate too much of memory, I guess at some point of
> time, oom killer will kick in a kill server.
>

The kernel implementation of fsnotify events queue pre-allocates
a single overflow event and never queues more than a single overflow
event. IN_Q_OVERFLOW must be delivered reliably, but delivering one
overflow event is enough (until it is consumed).

> >
> > Given the current server implementation with inotify, IN_Q_OVERFLOW
> > means server may have lost an IN_IGNORED event and may not get any
> > more events on inode, so server should check all the watched inodes after
> > overflow, notify the client of all deleted inodes and try to re-create
> > the watches
> > for all inodes with known path or use magic /prod/pid/fd path if that
> > works (??).
>
> Re-doing the watches sounds very painful.

Event overflow is a painful incident and systems usually pay a large
penalty when it happens (e.g. full recrawl of watched tree).
If virtiofsd is going to use inotify, it is no different than any other inotify
application that needs to bear the consequence of event overflow.

> That means we will need to
> keep track of aggregated mask in server side inode as well. As of
> now we just pass mask to kernel using inotify_add_watch() and forget
> about it.
>

It costs nothing to keep the aggregated mask in server side inode
and it makes sense to do that anyway.
This allows an implementation to notify about changes that the server
itself handles even if there is no backing filesystem behind it or
host OS has no fs notification support.

> /proc/pid/fd should work because I think that's how ioannis is putting
> current watches on inodes. We don't send path info to server.
>
> >
> > >
> > > nodeid is managed by server. So I am assuming that FORGET messages will
> > > not be sent to server for this inode till we have seen FS_IN_IGNORED
> > > and FS_DELETE_SELF events?
> > >
> >
> > Or until the application that requested the watch calls
> > inotify_rm_watch() or closes
> > the inotify fd.
> >
> > IOW, when fs implements remote fsnotify, the local watch keeps the local deleted
> > inode object in limbo until the local watch is removed.
> > When the remote fsnotify server informs that the remote watch (or remote inode)
> > is gone, the local watch is removed as well and then the inotify
> > application also gets
> > an FS_IN_IGNORED event.
>
> Hmm.., I guess remote server will simply send IN_DELETE event when it
> gets it and forward to client. And client will have to then cleanup
> this S_DEAD inode which is in limbo waiting for IN_DELETE_SELF event.
> And that should trigger cleanup of marks/local-watches on the inode, IIUC.
>

In very broad lines, but the server notification must be delivered reliably.

> >
> > Lifetime of local inode is complicated and lifetime of this "shared inode"
> > is much more complicated, so I am not pretending to claim that I have this all
> > figured out or that it could be reliably done at all.
>
> Yes this handling of IN_DELETE_SELF is turning out to be the most
> complicated piece of this proposal. I wish initial implementation
> could just be designed that it does not send IN_DELETE_SELF and
> IN_INGORED is generated locally. And later enhance it to support
> reliable delivery of IN_DELETE_SELF.
>

Not allowing DELETE_SELF in the mask sounds reasonable, but
as Ioannis explained, other events can be missed on local file delete.
If you want to preserve inotify semantics, you could queue an overflow
event if a fuse inode that gets evicted still has inotify marks.
That's a bit harsh though.
Alternatively, you could document in inotify man page that IN_INGORED
could mean that some events were dropped and hope for the best...

Thanks,
Amir.
