Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6AE477FFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 23:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhLPWYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 17:24:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230462AbhLPWYG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 17:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639693446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1G4t1Oa3RVrGC3J1Oz2TfziRSGtLHigJhXyM9pMDHuE=;
        b=Q7LkzV2lowtreTERhhBf1Hn4LcwF/cgirqso6zyNFKfZkqwRRbxKyDjvXkud2XqMFWUt3+
        ehzX/WrWbjsho7E408mJOGouIGBd1eJqS8w6NOSt8ljUQygyF2Uzpp9EDkPyp1YabDbin7
        S5wZ4P2zfOhORcycAVbx7GdV1ILClX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-xnJC62XkNWSxyXRzyt2K-Q-1; Thu, 16 Dec 2021 17:24:02 -0500
X-MC-Unique: xnJC62XkNWSxyXRzyt2K-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A1F5801B0C;
        Thu, 16 Dec 2021 22:24:01 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3FED1059140;
        Thu, 16 Dec 2021 22:24:00 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 81DDA2206B8; Thu, 16 Dec 2021 17:24:00 -0500 (EST)
Date:   Thu, 16 Dec 2021 17:24:00 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>,
        Stef Bon <stefbon@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>,
        Nathan Youngman <git@nathany.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
Message-ID: <Ybu8gBglHi+xikww@redhat.com>
References: <YaZC+R7xpGimBrD1@redhat.com>
 <CAO17o21uh3fJHd0gMu-SmZei5et6HJo91DiLk_YyfUqrtHy2pQ@mail.gmail.com>
 <CAOQ4uxjfCs=+Of69U6moOJ9T6_zDb1wcrLXWu4DROVme1cNnfQ@mail.gmail.com>
 <YbobZMGEl6sl+gcX@redhat.com>
 <CAOQ4uxj9XZNhHB3y9LuGcUJYp-i4f-LXQa2tzX8AkZpRERH+8w@mail.gmail.com>
 <Ybo/5h9umGlinaM4@redhat.com>
 <CAOQ4uxheVq-YHkT9eOu3vUNt1RU4Wa6MkyzXXLboHE_Pj6-6tw@mail.gmail.com>
 <CAOQ4uxjzW7mt0pqA+K_sEJokYcv_D3e7axAOWLXxQ84bZDnfcw@mail.gmail.com>
 <YbtoQGKflkChU8lZ@redhat.com>
 <CAOQ4uxhucsMYO1YdHdLDPBJEaoOOyXb57wFJgijQznis2feE1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhucsMYO1YdHdLDPBJEaoOOyXb57wFJgijQznis2feE1A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 16, 2021 at 08:22:19PM +0200, Amir Goldstein wrote:
[..]
> > So how much information we need to carry which covers all the existing
> > events. So for the case of rename, looks
> >
> > For the case of rename, it sounds like we will need to report
> > "node ids" of two directories and two names. Once we have space
> > to report two "node ids", this could also be used to report
> > node ids of parent dir as well as node id of file in question (if needed).
> > So will this be good enough.
> >
> > Carrying names will be little tricky I guess because namelen will be
> > variable. Until and unless we reserve some fixed amount of space for
> > each name say PATH_MAX. But that sounds like a lot of space.
> >

Ok, lets spend some time on figuring out how the fsnotify_out struct
should look like to meet the needs of fanotify as well.

> 
> I thought you passed the name as buffer in iov array.
> Or maybe that's not how it works?
> 
> My suggestion:
> 1. Reserve a zero padded 64bit member for future child nodeid
>     in struct fuse_notify_fsnotify_out

Ok, I think this doable. So right now it can send only one nodeid. You
basically want to have capability to send two 64bit nodeids in same
event, right. This is useful where you might want to send nodeid 
of dir and nodeid of child object, IIUC.

Maybe we should add a 64bit field for some sort of flags also which
might give additional informatin about the event.

It might look like.

struct fuse_notify_fsnotify_out {
        uint64_t inode;
        uint64_t mask;
        uint32_t namelen;
        uint32_t cookie;
	/* Can carry additional info about the event */
        uint64_t flags;
	/* Reserved for future use. Possibly another inode node id */
        uint64_t reserved;
};

> 2. For FS_RENAME, will we be able to pass 4 buffers in iov?
>     src_fuse_notify_fsnotify_out, src_name,
>     dst_fuse_notify_fsnotify_out, dst_name

So it is sort of two fsnotify events travelling in same event. We will
have to have some sort of information in the src_fuse_notify_fsnotify_out
which signals that another fsnotify_out is following. May be that's
where fsnotify_flags->field can be used. Set a bit to signal another
fsnotify_out is part of same event and this will also mean first one
is src and second one is dst. 

Challenge I see is "src_name" and "dst_name", especially in the context
of virtio queues. 

So we have a notification queue and for each notification, driver
allocates a fixed amount of memory for each element and queues these
elements in virtqueue. Server side pops these elements, places
notification info in this vq element and sends back.

So basically size of notification buffer needs to be known in advance,
because these are allocated by driver (and not device/server). And
that's the reason virtio spec has added a new filed "notify_buf_size"
in device configuration space. Using this field device lets the driver
know how much memory to allocate for each notification element.

IOW, we can put variable sized elements in notifiation but max size
of that variable length needs to be fixed in advance and needs to
be told to driver at device initialization time.

So what can be the max length of "src_name" and "dst_name"? Is it fair
to use NAME_MAX to determine max length of name. So say "255" bytes
(not including null) for each name. That means notify_buf_size will
be.

notify_buf_size = 2 * 255 + 2 * sizeof(struct fuse_notify_fsnotify_out);

I am currently creating 16 notification elements (VQ_NOTIFY_ELEMS) in
driver and pushing on notification queue. This number is arbitrary
and in future might have to be raised so that more events can travel
on notification queue in parallel.

Memory usage looks little high per notification due to name but not too
bad I guess.

Thanks
Vivek

