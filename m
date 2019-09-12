Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F40B0F8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 15:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfILNHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 09:07:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731880AbfILNHI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:07:08 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD5EA81F25
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2019 13:07:07 +0000 (UTC)
Received: by mail-io1-f70.google.com with SMTP id l9so32879439ioj.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2019 06:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7psrB107qoUXTXtGsO3BRLVcmarqnF4Se1XIyDsSCI=;
        b=O6oh0sVbF8yNw7XqQ6gjeQP3Se0ZtASP9hwKsaRmmh8O+D+SeJzCZ0tUd/gMHmdmr4
         TWSZqLdvcoa3Nlqj+SdEMIow5CVfQ3Z1lVuy1MLiY16c9aApbmIJYEGI01uZ/CvPnm9e
         X9fm2dcl6psrcshQUyMOK9ogPTd1rIfzYzVmL6zb0352MIXXYPHQlj6QQ01yOMLtSIpS
         XpxWOMXynffzs9JS+0h5QURDjOYsc5znnSmFUhX6eFpKAbwXYIDJ9U0mqoizYBZRyHyw
         XRdWKOZVpqLHxkKl1t0RHRRGCV/oG08qu6pUXo6TivSlx29Q3Q09Nu0K2JYvUOU1Ec0k
         /QwA==
X-Gm-Message-State: APjAAAUtUNQ1gKpUjVnpnqvhgKiO7KHGzEt4mYl85pzTtUwX6OQ00awP
        2sgUtxxQ3a3QS5J2fMz31z/ZMKx45fp0NzLnUUIyV3gZCGZiLG5j28O4k5EpTYgmlwBRfM3RXr9
        sSzGXarwLbbPsBLnMpP+d1U3hXR69P2oG3OG7yrAdgQ==
X-Received: by 2002:a02:94e5:: with SMTP id x92mr42004838jah.11.1568293627265;
        Thu, 12 Sep 2019 06:07:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyHaDOKZaqN3diRE/2sD4mIWvbKD+CUCgkaJxl6XFHrzSeZ2SDNVFSeka1ZaXW+NWLNLcQWwWVdaznDSaUwZng=
X-Received: by 2002:a02:94e5:: with SMTP id x92mr42004811jah.11.1568293626966;
 Thu, 12 Sep 2019 06:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190910151206.4671-1-mszeredi@redhat.com> <20190911155208.GA20527@stefanha-x1.localdomain>
 <CAJfpegsorJKWoqRyThCfgLUyXiK7TLjSwmh5DqC8cytYRE4TLw@mail.gmail.com> <20190912125424.GJ23174@stefanha-x1.localdomain>
In-Reply-To: <20190912125424.GJ23174@stefanha-x1.localdomain>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Thu, 12 Sep 2019 15:06:55 +0200
Message-ID: <CAOssrKc=jv7RfzUWp-SoH7Bo-58XspSKpN1Asz-QMrA6wsVXdQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] virtio-fs: shared file system for virtual machines
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 12, 2019 at 2:54 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Sep 12, 2019 at 10:14:11AM +0200, Miklos Szeredi wrote:
> > On Wed, Sep 11, 2019 at 5:54 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >
> > > On Tue, Sep 10, 2019 at 05:12:02PM +0200, Miklos Szeredi wrote:
> > > > I've folded the series from Vivek and fixed a couple of TODO comments
> > > > myself.  AFAICS two issues remain that need to be resolved in the short
> > > > term, one way or the other: freeze/restore and full virtqueue.
> > >
> > > I have researched freeze/restore and come to the conclusion that it
> > > needs to be a future feature.  It will probably come together with live
> > > migration support for reasons mentioned below.
> > >
> > > Most virtio devices have fairly simply power management freeze/restore
> > > functions that shut down the device and bring it back to the state held
> > > in memory, respectively.  virtio-fs, as well as virtio-9p and
> > > virtio-gpu, are different because they contain session state.  It is not
> > > easily possible to bring back the state held in memory after the device
> > > has been reset.
> > >
> > > The following areas of the FUSE protocol are stateful and need special
> > > attention:
> > >
> > >  * FUSE_INIT - this is pretty easy, we must re-negotiate the same
> > >    settings as before.
> > >
> > >  * FUSE_LOOKUP -> fuse_inode (inode_map)
> > >
> > >    The session contains a set of inode numbers that have been looked up
> > >    using FUSE_LOOKUP.  They are ephemeral in the current virtiofsd
> > >    implementation and vary across device reset.  Therefore we are unable
> > >    to restore the same inode numbers upon restore.
> > >
> > >    The solution is persistent inode numbers in virtiofsd.  This is also
> > >    needed to make open_by_handle_at(2) work and probably for live
> > >    migration.
> > >
> > >  * FUSE_OPEN -> fh (fd_map)
> > >
> > >    The session contains FUSE file handles for open files.  There is
> > >    currently no way of re-opening a file so that a specific fh is
> > >    returned.  A mechanism to do so probably isn't necessary if the
> > >    driver can update the fh to the new one produced by the device for
> > >    all open files instead.
> > >
> > >  * FUSE_OPENDIR -> fh (dirp_map)
> > >
> > >    Same story as for FUSE_OPEN but for open directories.
> > >
> > >  * FUSE_GETLK/SETLK/SETLKW -> (inode->posix_locks and fcntl(F_OFD_GET/SETLK))
> > >
> > >    The session contains file locks.  The driver must reacquire them upon
> > >    restore.  It's unclear what to do when locking fails.
> > >
> > > Live migration has the same problem since the FUSE session will be moved
> > > to a new virtio-fs device instance.  It makes sense to tackle both
> > > features together.  This is something that can be implemented in the
> > > next year, but it's not a quick fix.
> >
> > Right.   The question for now is: should the freeze silently succeed
> > (as it seems to do now) or should it fail instead?
> >
> > I guess normally freezing should be okay, as long as the virtiofsd
> > remains connected while the system is frozen.
> >
> > I tried to test this with "echo -n mem > /sys/power/state", which
> > indeed resulted in the virtio_fs_freeze() callback being called.
> > However, I couldn't find a way to wake up the system...
>
> The issue occurs only on restore.  The core virtio driver code resets
> the device so we lose state and cannot resume.
>
> virtio-9p and virtio-gpu do not implement the .freeze() callback but
> this is problematic since the system will think freeze succeeded.  It's
> safer for virtio-fs to implement .freeze() and return -EOPNOTSUPP.
>
> Can you squash in a trivial return -EOPNOTSUPP .freeze() function?

Sure.

Is this a regression from 9p?  How easy would it be to restore state
in virtques and reconnect to existing virtiofsd (no saving of FUSE
state should be required in this case)?

Thanks,
Miklos
