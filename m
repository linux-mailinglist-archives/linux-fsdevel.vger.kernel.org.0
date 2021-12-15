Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62AA475DBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Dec 2021 17:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244953AbhLOQoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Dec 2021 11:44:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231883AbhLOQod (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639586672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0wrhPrBGstjU5fVqFoOLdvYawVNuixDo0noIGDB7eI=;
        b=dkjiVSu1OO/JxYJweFMaHTg7knobeLMhgYPzu2HP62tZEIicc+ZokJZPClGJR3wcseUrEv
        ohvNKaYNe6cyDT1PPL4CbDh9RK800E50tlWHgXuCA4cpokkC+nL0myTUEJQ3mYDjiHZUjW
        AIRFG0TP8zGs+06PUdgyeTC97BLZ8+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-tcKiKTxdOVyGWbwDcysb_Q-1; Wed, 15 Dec 2021 11:44:29 -0500
X-MC-Unique: tcKiKTxdOVyGWbwDcysb_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA1A6593AE;
        Wed, 15 Dec 2021 16:44:27 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 163995BE0B;
        Wed, 15 Dec 2021 16:44:21 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A5D802206B8; Wed, 15 Dec 2021 11:44:20 -0500 (EST)
Date:   Wed, 15 Dec 2021 11:44:20 -0500
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
Message-ID: <YbobZMGEl6sl+gcX@redhat.com>
References: <YYU/7269JX2neLjz@redhat.com>
 <CAOQ4uxiM_i+6Zs+ewg8mfA5aKs-gY7yj3kdrmPLO8Zn+bz4DbA@mail.gmail.com>
 <20211111173043.GB25491@quack2.suse.cz>
 <CAOQ4uxiOUM6=190w4018w4nJRnqi+9gzzfQTsLh5gGwbQH_HgQ@mail.gmail.com>
 <CANXojcy9JzXeLQ6bz9+UOekkpqo8NkgQbhugmGmPE+x3+_=h3Q@mail.gmail.com>
 <CAO17o21YVczE2-BTAVg-0HJU6gjSUkzUSqJVs9k-_t7mYFNHaA@mail.gmail.com>
 <CAOQ4uxjpGMYZrq74S=EaSO2nvss4hm1WZ_k+Xxgrj2k9pngJgg@mail.gmail.com>
 <YaZC+R7xpGimBrD1@redhat.com>
 <CAO17o21uh3fJHd0gMu-SmZei5et6HJo91DiLk_YyfUqrtHy2pQ@mail.gmail.com>
 <CAOQ4uxjfCs=+Of69U6moOJ9T6_zDb1wcrLXWu4DROVme1cNnfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjfCs=+Of69U6moOJ9T6_zDb1wcrLXWu4DROVme1cNnfQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 15, 2021 at 09:10:47AM +0200, Amir Goldstein wrote:
> On Wed, Dec 15, 2021 at 1:22 AM Ioannis Angelakopoulos
> <iangelak@redhat.com> wrote:
> >
> > Hello Amir and Jan,
> >
> > After testing some of your proposals, related to extending the remote notification to fanotify as well, we came across some issues that are not straightforward to overcome:
> >
> > 1) Currently fuse does not support persistent file handles.  This means that file handles become stale if an inode is flushed out of the cache. The file handle support is very limited at the moment in fuse. Thus, the only option left is to implement fanotify both in server and guest with file descriptors.
> 
> That premise is not completely accurate...
> 
> >
> > 2) Since we can only use file descriptors, to support fanotify in viritofsd we need CAP_SYS_ADMIN enabled. The virtiofs developers are not very positive about the idea of using CAP_SYS_ADMIN for security reasons. Thus we attempted to support some basic fanotify functionality on the client/guest by modifying our existing implementation with inotify/fsnotify.
> >
> > 3) Basically, we continue to use inotify on the virtiofsd/fuse server but we add support on the client/guest kernel to be able to support simple fanotify events (i.e., for now the same events as inotify). However, two important problems arise from the use of the fanotify file descriptor mode in a guest process:
> 
> You may use whatever implementation you like is the server.
> inotify, fanotify, pub/sub to notify one client on changes from other clients.
> My comments are only about the protocol and vfs API, which affect all
> other FUSE servers
> that would want to implement fsnotify support in the future and other remote
> filesystems that would want to implement remote fsnotify in the future.
> 
> >
> > 3a) First, to be able to support fanotify in the file descriptor mode we need to pass to a "struct path" to the fsnotify call (within the guest kernel) that corresponds to the inode that we are monitoring. Unfortunately, when the guest receives the remote event from the server it only has information about the target inode. Since there is more than one mapping of "struct path" to a "struct inode" we do not know which path information to pass to the fsnotify call.
> >
> > 3b) Second, since the guest kernel needs to pass an open file descriptor back to the guest user space as part of the fanotify event data, internally the guest kernel (through fanotify's "create_fd" function) issues a "dentry_open" which will result in an additional FUSE_OPEN call to the server and subsequently the generation of an open event on the server (If the server monitors for an open event). This will inevitably cause an infinite loop of FUSE_OPEN requests and generation of open events on the server. One idea was to modify the open syscall (on the host kernel) to allow the use of FMODE_NONOTIFY flag from user space (currently it is used internally in the kernel code only), to be able to suppress open events. However, a malicious guest might be able to exploit that flag to disrupt the event generation for a file (I am not entirely sure if this is possible, yet).
> >
> 
> Supporting event->fd and permission events for that matter was never
> my intention when I suggested limited fanotify support.
> 
> > To sum up, it seems that the support for fanotify causes some problems that are very difficult to mitigate at the moment. The fanotify file handles mode would probably solve most if not all of the above problems we are facing, however as Vivek pointed out the file handle support in virtiofs/fuse is another project altogether.
> >
> > So we would like to ask you for any suggestions related to the aforementioned problems. If there are no "easy" solutions in sight for these fanotify issues, we would like to at least continue to support the remote inotify in the next version of the patches and try to solve issues around it.
> >
> 
> The mistake in your premise at 1) is to state that "fuse does not
> support persistent file handles"
> without looking into what that statement means.
> What it really means is that user cannot always open_by_handle_at()
> from a previously
> obtained file handle, which has obvious impact on exporting fuse to NFS (*).

Hi Amir,

What good is file handle if one can't use it for open_by_handle_at(). I
mean, are there other use cases?

IIUC, file handle for the same object can change if inode had been flushed
out of guest cache and brought back in later. So if application say
generated file handle for an object and saved it and later put a watch
on that object, by that time file handle of the object might have changed
(as seen by fuse). So one can't even use to match it with previous saved
file handle.

So I can't use file handle for open_by_handle_at(). I can't use it to
match it with previously saved file handle. So what can I use it for?

IOW, I could not imagine supporting fanotify file handles without
fixing the file handles properly in fuse. And it needs fixing in 
virtiofs as well as we can't trust random file handles from guest
for regular files.

> 
> But there is no requirement of fanotify for the user to be able to
> open_by_handle_at()
> from the information in the event, in fact, it is a non-requirement, because
> open_by_handle_at() requires CAP_DAC_READ_SEARCH and fanotify supports
> non privileged users.
> Quoting the fanotify.7 man page:
> "file_handle
>               ...It is an opaque handle that corresponds to a
> specified object on a filesystem
>               as returned by name_to_handle_at(2).  It can  be  used
> to uniquely identify a file
>               on a filesystem and can be passed as an argument to
> open_by_handle_at(2).
> "
> It CAN be passed to open_by_handle_at() - it does not have to be passed, because
> a unique object id is useful enough without being able to open_by_handle_at() as
> long as the user who set up the watch on the object keeps a record of
> that unique id.

I think this is what I am referring to above. This unique id can change 
between user generating file handle and fanotify reporting the unique
id. Now there might be limited ways where you somehow ensure that
inode can't be flushed out of guest and for that duration file handle
will be valid and ramain same. But that sounds like a very narrow use
case and very fragile.

> So the project of file handle support in virtiofs/fuse is completely independent
> and complementary to supporting remote fanotify in file handle mode.

I think it is base which needs to be fixed properly before supporting
fanotify, until and unless we are ready to live with a very narrow use
case where file handle for all objects being watched are saved in
such a way that they can't change between saving the file handle
and event generation.

Vivek
> 
> I hope I was able to explain myself.
> Let me know if anything is not clear.
> 
> Thanks,
> Amir.
> 
> (*) It is correct to state that "FUSE support for persistent file
> handles is limited",
> and FUSE protocol does need to be extended to provide better file
> handle support,
> but actually, it would be more accurate to say that virtiofs (and most
> other fuse servers)
> support for persistent file handles is limited.
> I wrote a generic framework called fuse_passthrough [1] that can be
> used to write a fuse
> server that does export persistent file handles to NFS when passing
> through to xfs/ext4
> (and the server has CAP_SYS_ADMIN).
> 
> [1] https://github.com/amir73il/libfuse/commits/fuse_passthrough
> 

