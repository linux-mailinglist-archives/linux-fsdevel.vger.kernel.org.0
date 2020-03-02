Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A156E175698
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 10:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgCBJKD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 04:10:03 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33698 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgCBJKD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:10:03 -0500
Received: by mail-io1-f67.google.com with SMTP id r15so2046821iog.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2020 01:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3FNj0hxzVQQvLDDs/BJ20eFHA24zEIH58cnboIabkr4=;
        b=cgJULK2b4rwm17h2uu8AA5J4tW6jQKiYhohSPZsFXeZHuiXAEbsaVTRIJHl20Wqgc6
         LVswQ/97B4c0lP2Ov1burH1xuh6+bPHa9Zk4VJx/URCFZHihena+raNN4mZB/Yp3sKL0
         TgcmsstrZuGDPSwjIdkCnpwG9IZcjry9TNCG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3FNj0hxzVQQvLDDs/BJ20eFHA24zEIH58cnboIabkr4=;
        b=mQhDZu8/KrQ8O1fGHXIQY9bAeiYmgh/Mw7u6Rns7WoVjYDb+HyMJWzX/5oE93KNaTx
         m6ZUl/QE44Ufh/ib81aOGq7IWUTaf6yxMCfXnvKnFX1rsrVlJqJFKi9myyFi5fpm1B7X
         ffs9LpFW3qw6OGSaU4a7zVqdeL0n6AS1W7zbBomsguULyCDvUGKPDbghsvkIUr/wH7BQ
         RuDj14lTO3ycaxmYt99/Gtb5PAquVyCxzMh9RNxKw9nD9bcQIJjtM9pMWhLLJFO1qrSx
         oJ77Ac8tLtQReNQfjr4sPikNyd2seMtzy5H+i9uqUHLno4H7kwnx/WMwBepyHqNsuldM
         qOMw==
X-Gm-Message-State: APjAAAXh63e6G7ktp4J5aaFP4QS0zFyipLzAv1dUMeACRbCBo//shO0i
        +5Gu9ePeyVB9yPh0sERCkuFgjdc8m7+X5SslIsdQHA==
X-Google-Smtp-Source: APXvYqw24F9lWuP9ZU02aXyoDAyjVcSIObFEA54Qjf0OiC/jHdCOMjILcUuNsjutQKAGboqeMBKUh+6+TbW+K8vw6cY=
X-Received: by 2002:a05:6602:382:: with SMTP id f2mr12340952iov.174.1583140202384;
 Mon, 02 Mar 2020 01:10:02 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com> <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com> <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein> <107666.1582907766@warthog.procyon.org.uk>
In-Reply-To: <107666.1582907766@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 2 Mar 2020 10:09:51 +0100
Message-ID: <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
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

On Fri, Feb 28, 2020 at 5:36 PM David Howells <dhowells@redhat.com> wrote:
>
> sysfs also has some other disadvantages for this:
>
>  (1) There's a potential chicken-and-egg problem in that you have to create a
>      bunch of files and dirs in sysfs for every created mount and superblock
>      (possibly excluding special ones like the socket mount) - but this
>      includes sysfs itself.  This might work - provided you create sysfs
>      first.

Sysfs architecture looks something like this (I hope Greg will correct
me if I'm wrong):

device driver -> kobj tree <- sysfs tree

The kobj tree is created by the device driver, and the dentry tree is
created on demand from the kobj tree.   Lifetime of kobjs is bound to
both the sysfs objects and the device but not the other way round.
I.e. device can go away while the sysfs object is still being
referenced, and sysfs can be freely mounted and unmounted
independently of device initialization.

So there's no ordering requirement between sysfs mounts and other
mounts.   I might be wrong on the details, since mounts are created
very early in the boot process...

>
>  (2) sysfs is memory intensive.  The directory structure has to be backed by
>      dentries and inodes that linger as long as the referenced object does
>      (procfs is more efficient in this regard for files that aren't being
>      accessed)

See above: I don't think dentries and inodes are pinned, only kobjs
and their associated cruft.  Which may be too heavy, depending on the
details of the kobj tree.

>  (3) It gives people extra, indirect ways to pin mount objects and
>      superblocks.

See above.

> For the moment, fsinfo() gives you three ways of referring to a filesystem
> object:
>
>  (a) Directly by path.

A path is always representable by an O_PATH descriptor.

>
>  (b) By path associated with an fd.

See my proposal about linking from /proc/$PID/fdmount/$FD ->
/sys/devices/virtual/mounts/$MOUNT_ID.

>
>  (c) By mount ID (perm checked by working back up the tree).

Check that perm on lookup of /sys/devices/virtual/mounts/$MOUNT_ID.
The proc symlink would bypass the lookup check by directly jumping to
the mountinfo dir.

> but will need to add:
>
>  (d) By fscontext fd (which is hard to find in sysfs).  Indeed, the superblock
>      may not even exist yet.

Proc symlink would work for that too.

If sysfs is too heavy, this could be proc or a completely new
filesystem.  The implementation is much less relevant at this stage of
the discussion than the interface.

Thanks,
Miklos
