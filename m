Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D11E475383
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Dec 2021 08:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbhLOHLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Dec 2021 02:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbhLOHK7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:10:59 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4A9C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Dec 2021 23:10:59 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id x10so28572035ioj.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Dec 2021 23:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HLzkZwxUORSuAaMga1zZZgHl5SrVra1DV3qXR9oBK4E=;
        b=bvkmtkKyhwwp20nFZcpttLJ9ahPgY7YGMwR2dOLRtvbBp0GS5cM/ApJmUfycc/w5ou
         p1vnYA3unPaU0Mx1RJ4Ir7Ed6QX5396oNCoCoZQDo9AXd8Gbp6+X23Uza1eOiTMc1RhW
         3S6qUgzIgWNfz46S75xudpKHcUnDGS3YpQ6C4FCM71aprLnaZjnannVx70ccDWJY+zoM
         1q5l0RIcn3O6mg2p6vRuLxkGHxvIhozCORRUsgkMvplUMtf3yIrmJ0pMuy/mkgYCcdrF
         I746fQXaT6oDbYPtjBB/J/4O7sbalUuKmk4Hm5cJPClHSk9cp3jV6RISRjtbRR9zOeYT
         ImDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HLzkZwxUORSuAaMga1zZZgHl5SrVra1DV3qXR9oBK4E=;
        b=KchfQqEkhIUZFLGm3Gdv/GyhtB5gt4ZIrIKfEZLYOcij97eYBAdKD6hv8pATCdA6QA
         ef84xb2efuDTz9KuG+rNl+j9m2RyaKcXJRJUPUsIGC3wBFqH0LW481F8N4irOHP71cmu
         VP/M/I+jcB3Omft/Nh83BaATW946Tg2lm7pVetYiw45IHYIVF+5/yJaVTx9VPPR8lmzN
         IJSlIqEs3ULGXIqs3Owd1/j57dByIlfcfMS8/8Lb3tAugxBHe/LdKfr0owQR0UPk8IPH
         SyzTLrxomJRy8Fbe9IAKW/YlVRoNg5VihZK6nzt1QYlCDY1hepkW6m+duMekOt0pUQ7z
         AFKA==
X-Gm-Message-State: AOAM531ERV++0GH9ZRcR10xfxj1pJKZu9kUX59IG70DUnAgccOJaRICR
        G1ZLav8z6Ar37ymNdGdHrtgcWgCl/RTha6iBCB0=
X-Google-Smtp-Source: ABdhPJzX8RiOerZOQ324GvOQjhsq54480M9XCZWaqlpxA/qkhIrnfPfGO1q2dQx1D6AhjlvBdZUUi0thGa8/sF0GNug=
X-Received: by 2002:a6b:d904:: with SMTP id r4mr5980403ioc.52.1639552259169;
 Tue, 14 Dec 2021 23:10:59 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxjsULgLuOFUYkEePySx6iPXRczgCZMxx8E5ncw=oarLPg@mail.gmail.com>
 <YYMO1ip9ynXFXc8f@redhat.com> <20211104100316.GA10060@quack2.suse.cz>
 <YYU/7269JX2neLjz@redhat.com> <CAOQ4uxiM_i+6Zs+ewg8mfA5aKs-gY7yj3kdrmPLO8Zn+bz4DbA@mail.gmail.com>
 <20211111173043.GB25491@quack2.suse.cz> <CAOQ4uxiOUM6=190w4018w4nJRnqi+9gzzfQTsLh5gGwbQH_HgQ@mail.gmail.com>
 <CANXojcy9JzXeLQ6bz9+UOekkpqo8NkgQbhugmGmPE+x3+_=h3Q@mail.gmail.com>
 <CAO17o21YVczE2-BTAVg-0HJU6gjSUkzUSqJVs9k-_t7mYFNHaA@mail.gmail.com>
 <CAOQ4uxjpGMYZrq74S=EaSO2nvss4hm1WZ_k+Xxgrj2k9pngJgg@mail.gmail.com>
 <YaZC+R7xpGimBrD1@redhat.com> <CAO17o21uh3fJHd0gMu-SmZei5et6HJo91DiLk_YyfUqrtHy2pQ@mail.gmail.com>
In-Reply-To: <CAO17o21uh3fJHd0gMu-SmZei5et6HJo91DiLk_YyfUqrtHy2pQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 15 Dec 2021 09:10:47 +0200
Message-ID: <CAOQ4uxjfCs=+Of69U6moOJ9T6_zDb1wcrLXWu4DROVme1cNnfQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
To:     Ioannis Angelakopoulos <iangelak@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Stef Bon <stefbon@gmail.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>,
        Nathan Youngman <git@nathany.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 15, 2021 at 1:22 AM Ioannis Angelakopoulos
<iangelak@redhat.com> wrote:
>
> Hello Amir and Jan,
>
> After testing some of your proposals, related to extending the remote not=
ification to fanotify as well, we came across some issues that are not stra=
ightforward to overcome:
>
> 1) Currently fuse does not support persistent file handles.  This means t=
hat file handles become stale if an inode is flushed out of the cache. The =
file handle support is very limited at the moment in fuse. Thus, the only o=
ption left is to implement fanotify both in server and guest with file desc=
riptors.

That premise is not completely accurate...

>
> 2) Since we can only use file descriptors, to support fanotify in viritof=
sd we need CAP_SYS_ADMIN enabled. The virtiofs developers are not very posi=
tive about the idea of using CAP_SYS_ADMIN for security reasons. Thus we at=
tempted to support some basic fanotify functionality on the client/guest by=
 modifying our existing implementation with inotify/fsnotify.
>
> 3) Basically, we continue to use inotify on the virtiofsd/fuse server but=
 we add support on the client/guest kernel to be able to support simple fan=
otify events (i.e., for now the same events as inotify). However, two impor=
tant problems arise from the use of the fanotify file descriptor mode in a =
guest process:

You may use whatever implementation you like is the server.
inotify, fanotify, pub/sub to notify one client on changes from other clien=
ts.
My comments are only about the protocol and vfs API, which affect all
other FUSE servers
that would want to implement fsnotify support in the future and other remot=
e
filesystems that would want to implement remote fsnotify in the future.

>
> 3a) First, to be able to support fanotify in the file descriptor mode we =
need to pass to a "struct path" to the fsnotify call (within the guest kern=
el) that corresponds to the inode that we are monitoring. Unfortunately, wh=
en the guest receives the remote event from the server it only has informat=
ion about the target inode. Since there is more than one mapping of "struct=
 path" to a "struct inode" we do not know which path information to pass to=
 the fsnotify call.
>
> 3b) Second, since the guest kernel needs to pass an open file descriptor =
back to the guest user space as part of the fanotify event data, internally=
 the guest kernel (through fanotify's "create_fd" function) issues a "dentr=
y_open" which will result in an additional FUSE_OPEN call to the server and=
 subsequently the generation of an open event on the server (If the server =
monitors for an open event). This will inevitably cause an infinite loop of=
 FUSE_OPEN requests and generation of open events on the server. One idea w=
as to modify the open syscall (on the host kernel) to allow the use of FMOD=
E_NONOTIFY flag from user space (currently it is used internally in the ker=
nel code only), to be able to suppress open events. However, a malicious gu=
est might be able to exploit that flag to disrupt the event generation for =
a file (I am not entirely sure if this is possible, yet).
>

Supporting event->fd and permission events for that matter was never
my intention when I suggested limited fanotify support.

> To sum up, it seems that the support for fanotify causes some problems th=
at are very difficult to mitigate at the moment. The fanotify file handles =
mode would probably solve most if not all of the above problems we are faci=
ng, however as Vivek pointed out the file handle support in virtiofs/fuse i=
s another project altogether.
>
> So we would like to ask you for any suggestions related to the aforementi=
oned problems. If there are no "easy" solutions in sight for these fanotify=
 issues, we would like to at least continue to support the remote inotify i=
n the next version of the patches and try to solve issues around it.
>

The mistake in your premise at 1) is to state that "fuse does not
support persistent file handles"
without looking into what that statement means.
What it really means is that user cannot always open_by_handle_at()
from a previously
obtained file handle, which has obvious impact on exporting fuse to NFS (*)=
.

But there is no requirement of fanotify for the user to be able to
open_by_handle_at()
from the information in the event, in fact, it is a non-requirement, becaus=
e
open_by_handle_at() requires CAP_DAC_READ_SEARCH and fanotify supports
non privileged users.
Quoting the fanotify.7 man page:
"file_handle
              ...It is an opaque handle that corresponds to a
specified object on a filesystem
              as returned by name_to_handle_at(2).  It can  be  used
to uniquely identify a file
              on a filesystem and can be passed as an argument to
open_by_handle_at(2).
"
It CAN be passed to open_by_handle_at() - it does not have to be passed, be=
cause
a unique object id is useful enough without being able to open_by_handle_at=
() as
long as the user who set up the watch on the object keeps a record of
that unique id.
So the project of file handle support in virtiofs/fuse is completely indepe=
ndent
and complementary to supporting remote fanotify in file handle mode.

I hope I was able to explain myself.
Let me know if anything is not clear.

Thanks,
Amir.

(*) It is correct to state that "FUSE support for persistent file
handles is limited",
and FUSE protocol does need to be extended to provide better file
handle support,
but actually, it would be more accurate to say that virtiofs (and most
other fuse servers)
support for persistent file handles is limited.
I wrote a generic framework called fuse_passthrough [1] that can be
used to write a fuse
server that does export persistent file handles to NFS when passing
through to xfs/ext4
(and the server has CAP_SYS_ADMIN).

[1] https://github.com/amir73il/libfuse/commits/fuse_passthrough
