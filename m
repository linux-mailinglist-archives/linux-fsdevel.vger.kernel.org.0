Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 165A518B388
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 13:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgCSMhM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 08:37:12 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36719 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgCSMhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 08:37:10 -0400
Received: by mail-il1-f193.google.com with SMTP id h3so2064154ils.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 05:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2tuVxH0JdqTpL/q4Mhu8Jwtx1AVVUn0AWeX5OBSt298=;
        b=cMtY3qUcEmiCWPAEeCd5lhB7x3Biy4/6Het2lKK01B7wcpZG2RZMmWE3LV0gVxGIei
         UuMBMRql9WM+pRx9p4acPSg0mo4kZ7BHmdSm48TJO0cwwlRT82C+TUnt1Ixfd5tAZfQB
         qGlXYFxfI9xkqU5Rq8m22vi2BvEMfsNiNnE2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tuVxH0JdqTpL/q4Mhu8Jwtx1AVVUn0AWeX5OBSt298=;
        b=RO3Ew8T8fFtax2mcqlRAtCZLVj+8+FpMxaGfai0CtBkJZsDWzhJtx/fyJsVn4jm15U
         OWrdvkGbQkSj/g7r4UDhGUmJeAxNcE7qj+1mXTIEa3nFpUXOa9CQQizrLUXyhaHjqQiU
         FKmwd3f1XyeBT0/UEVWFRAN/wDTUn8uqc/mX4iT//QHo/0kmXa3lhPc8wiG2eLC5RZGo
         Wk4UIOQJCrbDxhWxHQRty6xCWQoZuacxjUoELLWi8FjG0aycktdcsafcKbYfPXiGEz+g
         CwJnYGGcAXr13p2F4Ag4ehy35Hq/IB7Hkv69zFdC7GXjvs4EpBKIaksCsJG0d3619jek
         DbkA==
X-Gm-Message-State: ANhLgQ1U8wB7jEpyYj6L30/8Misi47/S2ulOac/jweOFGpVOPP2p8bvq
        GVhdaoSxwRJXUsHSi4hofELVWPEBtjdBFGgt26vtlQ==
X-Google-Smtp-Source: ADFU+vsTsJqo2m1ETEsSuJlFNylEmftzB1ulJzyZd8sss8uJZS7aWDqz3pxVA9Gv6H7ICK0JOZMAndoK/X55keC9JJI=
X-Received: by 2002:a92:3b8c:: with SMTP id n12mr2899150ilh.186.1584621429946;
 Thu, 19 Mar 2020 05:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
 <CAJfpeguaiicjS2StY5m=8H7BCjq6PLxMsWE3Mx_jYR1foDWVTg@mail.gmail.com> <3085880.1584614257@warthog.procyon.org.uk>
In-Reply-To: <3085880.1584614257@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 19 Mar 2020 13:36:58 +0100
Message-ID: <CAJfpegv-_ai1LiW6=D+AnkozzmmXbB8=g8QDCS15bh==Wn3yoA@mail.gmail.com>
Subject: Re: [PATCH 00/13] VFS: Filesystem information [ver #19]
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux API <linux-api@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 19, 2020 at 11:37 AM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > >  (2) It's more efficient as we can return specific binary data rather than
> > >      making huge text dumps.  Granted, sysfs and procfs could present the
> > >      same data, though as lots of little files which have to be
> > >      individually opened, read, closed and parsed.
> >
> > Asked this a number of times, but you haven't answered yet:  what
> > application would require such a high efficiency?
>
> Low efficiency means more time doing this when that time could be spent doing
> other things - or even putting the CPU in a powersaving state.  Using an
> open/read/close render-to-text-and-parse interface *will* be slower and less
> efficient as there are more things you have to do to use it.
>
> Then consider doing a walk over all the mounts in the case where there are
> 10000 of them - we have issues with /proc/mounts for such.  fsinfo() will end
> up doing a lot less work.

Current /proc/mounts problems arise from the fact that mount info can
only be queried for the whole namespace, and hence changes related to
a single mount will require rescanning the complete mount list.  If
mount info can be queried for individual mounts, then the need to scan
the complete list will be rare.  That's *the* point of this change.

> > >  (3) We wouldn't have the overhead of open and close (even adding a
> > >      self-contained readfile() syscall has to do that internally
> >
> > Busted: add f_op->readfile() and be done with all that.   For example
> > DEFINE_SHOW_ATTRIBUTE() could be trivially moved to that interface.
>
> Look at your example.  "f_op->".  That's "file->f_op->" I presume.
>
> You would have to make it "i_op->" to avoid the open and the close - and for
> things like procfs and sysfs, that's probably entirely reasonable - but bear
> in mind that you still have to apply all the LSM file security controls, just
> in case the backing filesystem is, say, ext4 rather than procfs.
>
> > We could optimize existing proc, sys, etc. interfaces, but it's not
> > been an issue, apparently.
>
> You can't get rid of or change many of the existing interfaces.  A lot of them
> are effectively indirect system calls and are, as such, part of the fixed
> UAPI.  You'd have to add a parallel optimised set.

Sure.

We already have the single_open() internal API that is basically a
->readfile() wrapper.   Moving this up to the f_op level (no, it's not
an i_op, and yes, we do need struct file, but it can be simply
allocated on the stack) is a trivial optimization that would let a
readfile(2) syscall access that level.  No new complexity in that
case.    Same generally goes for seq_file: seq_readfile() is trivial
to implement without messing with current implementation or any
existing APIs.

>
> > >  (6) Don't have to create/delete a bunch of sysfs/procfs nodes each time a
> > >      mount happens or is removed - and since systemd makes much use of
> > >      mount namespaces and mount propagation, this will create a lot of
> > >      nodes.
> >
> > Not true.
>
> This may not be true if you roll your own special filesystem.  It *is* true if
> you do it in procfs or sysfs.  The files don't exist if you don't create nodes
> or attribute tables for them.

That's one of the reasons why I opted to roll my own.  But the ideas
therein could be applied to kernfs, if found to be generally useful.
Nothing magic about that.

>
> > > The argument for doing this through procfs/sysfs/somemagicfs is that
> > > someone using a shell can just query the magic files using ordinary text
> > > tools, such as cat - and that has merit - but it doesn't solve the
> > > query-by-pathname problem.
> > >
> > > The suggested way around the query-by-pathname problem is to open the
> > > target file O_PATH and then look in a magic directory under procfs
> > > corresponding to the fd number to see a set of attribute files[*] laid out.
> > > Bash, however, can't open by O_PATH or O_NOFOLLOW as things stand...
> >
> > Bash doesn't have fsinfo(2) either, so that's not really a good argument.
>
> I never claimed that fsinfo() could be accessed directly from the shell.  For
> you proposal, you claimed "immediately usable from all programming languages,
> including scripts".

You are right.  Note however: only special files need the O_PATH
handling, regular files are directories can be opened by the shell
without side effects.

In any case, I think neither of us can be convinced of the other's
right, so I guess It's up to Al and Linus to make a decision.

Thanks,
Miklos
