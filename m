Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE2917704A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 08:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgCCHqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 02:46:23 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:33503 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgCCHqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:46:22 -0500
Received: by mail-il1-f195.google.com with SMTP id r4so1950358iln.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2020 23:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ELZPyz+JMM9KR/Aq1ALyZfnG+hF1PW/nIOxRAiYMFlA=;
        b=h//WCX1u89UHh6CAN0ekseTsItC2J5xMQfHl6n0s1N9AX+zx70w8Zxu0fuym78HBDv
         ZEt42SF+RPlW0mcOJcki5T5Usfq7aLeqO1zd9I0brS5E9QMGuQHA63EHHUADxREX/OqS
         gy0aUO+wM4MvJT1ssK9MvsaXJZqHt+TItge3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ELZPyz+JMM9KR/Aq1ALyZfnG+hF1PW/nIOxRAiYMFlA=;
        b=hpnpXRt4MZ2VXSpS8+5UlU8Yr42EiHi8RPFXrrLpqj7lLEyKyA3XQ6m9XRIH3lJL7z
         64OV0wuRfCq2QE4+cxB1y6Bi5T/VFXtTCqpVOjZ/6MP9DciSG+RgcYEjTTiJA5Z+12e+
         W7YGJVYE9KNi5XuLnH3cJnhHROu+vP22RyJtv0UkYkOJpWPWoRikkl0kxZwCYPqZ6Uip
         x0p9O6TzLvrrovM3bQ+BnbuGrWLclHCmpRxgB6vMyT+YE9MlHB3JD4K/ZqF++7ftlvt/
         /65sOmM6aLJixkhTl2PDUkOCMVklp1a+rMSVKDkzJ4FdH0AqZUUxHnwVvyZh7+6XzXDw
         HGYA==
X-Gm-Message-State: ANhLgQ3QuQ6FXUyMq8KVhC6W+OTO2/Q0EabFPWgDjJWUTOMv2eWleE3c
        QzkVfy2AtCTXcl0GMn4+nhcXNyejLqQOPAcqANyLNQ==
X-Google-Smtp-Source: ADFU+vvEp1VOCUcDcLeAQYAAy2siLYtK8Vfu/WGfBBl0ZwK2hZRppZiOkMiVlWL/6lKu5Nh0cVOfH98k5NauZOHJE88=
X-Received: by 2002:a05:6e02:f43:: with SMTP id y3mr3580059ilj.174.1583221580782;
 Mon, 02 Mar 2020 23:46:20 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com> <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com> <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein> <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com> <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
In-Reply-To: <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 3 Mar 2020 08:46:09 +0100
Message-ID: <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 3, 2020 at 6:28 AM Ian Kent <raven@themaw.net> wrote:
>
> On Mon, 2020-03-02 at 10:09 +0100, Miklos Szeredi wrote:
> > On Fri, Feb 28, 2020 at 5:36 PM David Howells <dhowells@redhat.com>
> > wrote:
> > > sysfs also has some other disadvantages for this:
> > >
> > >  (1) There's a potential chicken-and-egg problem in that you have
> > > to create a
> > >      bunch of files and dirs in sysfs for every created mount and
> > > superblock
> > >      (possibly excluding special ones like the socket mount) - but
> > > this
> > >      includes sysfs itself.  This might work - provided you create
> > > sysfs
> > >      first.
> >
> > Sysfs architecture looks something like this (I hope Greg will
> > correct
> > me if I'm wrong):
> >
> > device driver -> kobj tree <- sysfs tree
> >
> > The kobj tree is created by the device driver, and the dentry tree is
> > created on demand from the kobj tree.   Lifetime of kobjs is bound to
> > both the sysfs objects and the device but not the other way round.
> > I.e. device can go away while the sysfs object is still being
> > referenced, and sysfs can be freely mounted and unmounted
> > independently of device initialization.
> >
> > So there's no ordering requirement between sysfs mounts and other
> > mounts.   I might be wrong on the details, since mounts are created
> > very early in the boot process...
> >
> > >  (2) sysfs is memory intensive.  The directory structure has to be
> > > backed by
> > >      dentries and inodes that linger as long as the referenced
> > > object does
> > >      (procfs is more efficient in this regard for files that aren't
> > > being
> > >      accessed)
> >
> > See above: I don't think dentries and inodes are pinned, only kobjs
> > and their associated cruft.  Which may be too heavy, depending on the
> > details of the kobj tree.
> >
> > >  (3) It gives people extra, indirect ways to pin mount objects and
> > >      superblocks.
> >
> > See above.
> >
> > > For the moment, fsinfo() gives you three ways of referring to a
> > > filesystem
> > > object:
> > >
> > >  (a) Directly by path.
> >
> > A path is always representable by an O_PATH descriptor.
> >
> > >  (b) By path associated with an fd.
> >
> > See my proposal about linking from /proc/$PID/fdmount/$FD ->
> > /sys/devices/virtual/mounts/$MOUNT_ID.
> >
> > >  (c) By mount ID (perm checked by working back up the tree).
> >
> > Check that perm on lookup of /sys/devices/virtual/mounts/$MOUNT_ID.
> > The proc symlink would bypass the lookup check by directly jumping to
> > the mountinfo dir.
> >
> > > but will need to add:
> > >
> > >  (d) By fscontext fd (which is hard to find in sysfs).  Indeed, the
> > > superblock
> > >      may not even exist yet.
> >
> > Proc symlink would work for that too.
>
> There's mounts enumeration too, ordering is required to identify the
> top (or bottom depending on terminology) with more than one mount on
> a mount point.
>
> >
> > If sysfs is too heavy, this could be proc or a completely new
> > filesystem.  The implementation is much less relevant at this stage
> > of
> > the discussion than the interface.
>
> Ha, proc with the seq file interface, that's already proved to not
> work properly and looks difficult to fix.

I'm doing a patch.   Let's see how it fares in the face of all these
preconceptions.

Thanks,
Miklos
