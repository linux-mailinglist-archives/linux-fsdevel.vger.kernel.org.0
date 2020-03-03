Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC41176ECD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 06:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgCCFf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 00:35:59 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:60435 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725440AbgCCFf7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 00:35:59 -0500
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2020 00:35:58 EST
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 63E5B787;
        Tue,  3 Mar 2020 00:28:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 03 Mar 2020 00:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        tggywWKtWN6rOIFQkxL1pkuJH5gISL+DxeYq7A1sess=; b=BT76Yia40KWvlkva
        zxMUOgQ2cGh1G4CgkSd9LSzdv6pa1NSdycnVvMLIAVXgY/qhSZv23Enfe5LwvSnP
        EnOyOczk5IZPIJRHEDJkuzShBusCvGpFbRToi16x1NH36tS8pUdzBY1l+MY3l/hn
        3FMSPuh2SfVOobkPUkwnGw/UccwiqHsKL4E9hDUsBQ0iLvArw7joxKkF16ZHoYv2
        E2El88/+YeVWpdiv+bC97e7YkaCsEUXGNpEZTBNPOzuVRQDwQOeYnz/yCLphwOjh
        LbUyx0HxZiXgrSsL8xISkG5XZw0P3tPw8lObQw3cHKcF94+LuBDHiJ2hJk5DLQjk
        get+tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=tggywWKtWN6rOIFQkxL1pkuJH5gISL+DxeYq7A1se
        ss=; b=QYQzeOweAI6VXarA2WPokNZgWLn9+9ymb4ttoNqRCfHxTNHhxuA1BuqNe
        xTzy0j8EY5psHGRl0hN3M9HQ75NBopgkUJe99IZ9mrMkMrDTVIKTN1fbqJnbwIsK
        ZinT2nK5jeO/rgN9iP9tYYdgXipgMH6bd61QrW8MZs7aWgHrr6O6AhUcaEs6NMxJ
        xMmh+N17h9gyHfggea6TB/h1iXycAMPYuCaV3AOoLb6/B9LjninTWgnJHHnJW79G
        J+gJYgCH7vyGZUxIZN2kDUBkelGsy+vdobfXYqltBvRVI2itWDPNbqub+VVshRsp
        SuGV0KQiaOgwoPizuH00f9zHo8JPg==
X-ME-Sender: <xms:5-pdXob4_nYgt6Xv3olZHafeY_RAXl33XID-x9IQfj-50psJfCWBZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddthedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtke
    drudekkedruddufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:5-pdXjtjPUhJpUrat2dtwXqjRd7o7dkdXYQl5BCmRTlhLtqRiA46mQ>
    <xmx:5-pdXqklOYvRTdr_YfOo66U3N9UpaBO0MiXA2l2MTD-ORWFcBBWZ2w>
    <xmx:5-pdXtSQKK-8LkAHPy4LgZi-xc-kfvOQfipkBj6UYVTlgBWOyS23AA>
    <xmx:6OpdXmO82PQkDUhPw6K3YcoKRcEXvaxWUsOnkooWBiT2W0PMJfmVhAEzQgDBqNWa>
Received: from mickey.themaw.net (unknown [118.208.188.113])
        by mail.messagingengine.com (Postfix) with ESMTPA id 76C9A328005A;
        Tue,  3 Mar 2020 00:28:02 -0500 (EST)
Message-ID: <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications
 [ver #17]
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
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
Date:   Tue, 03 Mar 2020 13:27:59 +0800
In-Reply-To: <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
         <1582316494.3376.45.camel@HansenPartnership.com>
         <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
         <1582556135.3384.4.camel@HansenPartnership.com>
         <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
         <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
         <1582644535.3361.8.camel@HansenPartnership.com>
         <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein>
         <107666.1582907766@warthog.procyon.org.uk>
         <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-03-02 at 10:09 +0100, Miklos Szeredi wrote:
> On Fri, Feb 28, 2020 at 5:36 PM David Howells <dhowells@redhat.com>
> wrote:
> > sysfs also has some other disadvantages for this:
> > 
> >  (1) There's a potential chicken-and-egg problem in that you have
> > to create a
> >      bunch of files and dirs in sysfs for every created mount and
> > superblock
> >      (possibly excluding special ones like the socket mount) - but
> > this
> >      includes sysfs itself.  This might work - provided you create
> > sysfs
> >      first.
> 
> Sysfs architecture looks something like this (I hope Greg will
> correct
> me if I'm wrong):
> 
> device driver -> kobj tree <- sysfs tree
> 
> The kobj tree is created by the device driver, and the dentry tree is
> created on demand from the kobj tree.   Lifetime of kobjs is bound to
> both the sysfs objects and the device but not the other way round.
> I.e. device can go away while the sysfs object is still being
> referenced, and sysfs can be freely mounted and unmounted
> independently of device initialization.
> 
> So there's no ordering requirement between sysfs mounts and other
> mounts.   I might be wrong on the details, since mounts are created
> very early in the boot process...
> 
> >  (2) sysfs is memory intensive.  The directory structure has to be
> > backed by
> >      dentries and inodes that linger as long as the referenced
> > object does
> >      (procfs is more efficient in this regard for files that aren't
> > being
> >      accessed)
> 
> See above: I don't think dentries and inodes are pinned, only kobjs
> and their associated cruft.  Which may be too heavy, depending on the
> details of the kobj tree.
> 
> >  (3) It gives people extra, indirect ways to pin mount objects and
> >      superblocks.
> 
> See above.
> 
> > For the moment, fsinfo() gives you three ways of referring to a
> > filesystem
> > object:
> > 
> >  (a) Directly by path.
> 
> A path is always representable by an O_PATH descriptor.
> 
> >  (b) By path associated with an fd.
> 
> See my proposal about linking from /proc/$PID/fdmount/$FD ->
> /sys/devices/virtual/mounts/$MOUNT_ID.
> 
> >  (c) By mount ID (perm checked by working back up the tree).
> 
> Check that perm on lookup of /sys/devices/virtual/mounts/$MOUNT_ID.
> The proc symlink would bypass the lookup check by directly jumping to
> the mountinfo dir.
> 
> > but will need to add:
> > 
> >  (d) By fscontext fd (which is hard to find in sysfs).  Indeed, the
> > superblock
> >      may not even exist yet.
> 
> Proc symlink would work for that too.

There's mounts enumeration too, ordering is required to identify the
top (or bottom depending on terminology) with more than one mount on
a mount point.

> 
> If sysfs is too heavy, this could be proc or a completely new
> filesystem.  The implementation is much less relevant at this stage
> of
> the discussion than the interface.

Ha, proc with the seq file interface, that's already proved to not
work properly and looks difficult to fix.

Ian

