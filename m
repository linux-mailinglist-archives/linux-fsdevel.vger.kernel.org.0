Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D201F9504
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 13:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgFOLIF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 07:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgFOLID (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:08:03 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B289C061A0E;
        Mon, 15 Jun 2020 04:08:01 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id h3so14824944ilh.13;
        Mon, 15 Jun 2020 04:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1GSlgnChKZMK7jaTTe5He0DByIYqID5vbplEZNg5lVs=;
        b=bYSgKqK1+jvdbtcWrn1GIPSxztncneIRXXAjtE/WsFPpjsE279NYPG+cCaLPmWAclV
         ce45cMTTYcysPt1GMwjWIBLANu27bbz7LIhCGatpd1M3g4mb/ESNa60S1x/ni78QAz28
         8VxaNteqKXHmEGnKYLZEPd/3UC0bBMKkA4Th+Msmb5vjQ5vEWISEpeM6UU5YSADqbF0c
         H8I5ckZRpxA+mfjqRlLs2X1N4sx73DCD5yRqBdIExNTeoho8kXFaltT5wqjKXen+1NYY
         2ScibA5y2/cOap52yitnML8wEHILzaIjkKmtVBYT07JTYg9tunrFqrX0fVrUyNxOzBy5
         7tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1GSlgnChKZMK7jaTTe5He0DByIYqID5vbplEZNg5lVs=;
        b=l/ycIsqMMb0LvHJcLzV8tQGq/t1WhWUSd+cjf4p6eW5f8nBRhDSaH3U/P/8U/fF6Du
         eH9HwqBO/rGr53NfmpIF51aUVv7Wea/Rtboe62V2rA9oi8MS9xxzuV9WV5vZKb6T0HSv
         7RKLpZwPPra523poQGLV6HixWMfeYWblSjVG7KkEuEm0z2C3DBdp3PC5OBvM4cs+wLj9
         h8M/PMAjYXpJRF4o/7CfyTmt4oxXqfPZDTNgpBwC8ZyQA2SZphj8+9YxPNuVQ3SkVjAM
         lgvs2GlsoQKkVRPGrE8/dXoXwHHng9XbOemP/dEO1u0OEToKEneJTS02oMmvf3GZPvp1
         Po+g==
X-Gm-Message-State: AOAM5323+WyVoK3nIoHKhTemoIR7vFEZ16s0/0+ltxIUL1+yUfoNMEP/
        TkeRubfljMFn14UXoiRFAMQvTAy28mBHSlUvAh0=
X-Google-Smtp-Source: ABdhPJwXwfqTvm2WMwbYGFkCNXVbcd70mrOxIv+h9XKC3PchOMLd+Jcgc7tNQu3V5UzfsEu8IVsAUaRbsWBPt6V3kU8=
X-Received: by 2002:a92:c9ce:: with SMTP id k14mr25596963ilq.250.1592219279152;
 Mon, 15 Jun 2020 04:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200612092603.GB3183@techsingularity.net> <CAOQ4uxikbJ19npQFWzGm6xnqXm0W8pV3NOWE0ZxS9p_G2A39Aw@mail.gmail.com>
 <20200612131854.GD3183@techsingularity.net> <CAOQ4uxghy5zOT6i=shZfFHsXOgPrd7-4iPkJBDcsHU6bUSFUFg@mail.gmail.com>
 <CAOQ4uxhm+afWpnb4RFw8LkZ+ZJtnFxqR5HB8Uyj-c44CU9SSJg@mail.gmail.com> <20200615081202.GE9449@quack2.suse.cz>
In-Reply-To: <20200615081202.GE9449@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 Jun 2020 14:07:46 +0300
Message-ID: <CAOQ4uxibBL7W0DR4RhC5ZP7Y68ob5Xj6VncWjepgOj=RB8jrGQ@mail.gmail.com>
Subject: Re: [PATCH] fs: Do not check if there is a fsnotify watcher on pseudo inodes
To:     Jan Kara <jack@suse.cz>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:12 AM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 12-06-20 23:34:16, Amir Goldstein wrote:
> > > > > So maybe it would be better to list all users of alloc_file_pseudo()
> > > > > and say that they all should be opted out of fsnotify, without mentioning
> > > > > "internal mount"?
> > > > >
> > > >
> > > > The users are DMA buffers, CXL, aio, anon inodes, hugetlbfs, anonymous
> > > > pipes, shmem and sockets although not all of them necessary end up using
> > > > a VFS operation that triggers fsnotify.  Either way, I don't think it
> > > > makes sense (or even possible) to watch any of those with fanotify so
> > > > setting the flag seems reasonable.
> > > >
> > >
> > > I also think this seems reasonable, but the more accurate reason IMO
> > > is found in the comment for d_alloc_pseudo():
> > > "allocate a dentry (for lookup-less filesystems)..."
> > >
> > > > I updated the changelog and maybe this is clearer.
> > >
> > > I still find the use of "internal mount" terminology too vague.
> > > "lookup-less filesystems" would have been more accurate,
> >
> > Only it is not really accurate for shmfs anf hugetlbfs, which are
> > not lookup-less, they just hand out un-lookable inodes.
>
> OK, but I still think we are safe setting FMODE_NONOTIFY in
> alloc_file_pseudo() and that covers all the cases we care about. Or did I
> misunderstand something in the discussion? I can see e.g.
> __shmem_file_setup() uses alloc_file_pseudo() but again that seems to be
> used only for inodes without a path and the comment before d_alloc_pseudo()
> pretty clearly states this should be the case.
>
> So is the dispute here really only about how to call files using
> d_alloc_pseudo()?
>

Yes, semantics, no technical dispute on the patch.

> > > because as you correctly point out, the user API to set a watch
> > > requires that the marked object is looked up in the filesystem.
> > >
> > > There are also some kernel internal users that set watches
> > > like audit and nfsd, but I think they are also only interested in
> > > inodes that have a path at the time that the mark is setup.
> > >
> >
> > FWIW I verified that watches can be set on anonymous pipes
> > via /proc/XX/fd, so if we are going to apply this patch, I think it
> > should be accompanied with a complimentary patch that forbids
> > setting up a mark on these sort of inodes. If someone out there
> > is doing this, at least they would get a loud message that something
> > has changed instead of silently dropping fsnotify events.
> >
> > So now the question is how do we identify/classify "these sort of
> > inodes"? If they are no common well defining characteristics, we
> > may need to blacklist pipes sockets and anon inodes explicitly
> > with S_NONOTIFY.
>
> We already do have FS_DISALLOW_NOTIFY_PERM in file_system_type->fs_flags so
> adding FS_DISALLOW_NOTIFY would be natural if there is a need for this.

Yes, it is possible, but for the specified use case, it is probably easier
to classify by inode type (and maybe IS_ROOT()) than by filesystem type.
Also, in the case of shmem, the same file_system_type is used for user
mountable tmpfs and the kernel internal shm_mnt instance - only the
latter is used for handing out anonymous shmem files.

>
> I don't think using fsnotify on pipe inodes is sane in any way. You'd
> possibly only get the MODIFY or ACCESS events and even those would not be
> quite reliable because with pipes stuff like splicing etc. is much more
> common and that currently completely bypasses fsnotify subsystem. So
> overall I'm fine with completely ignoring fsnotify on such inodes.
>

Agreed for MODIFY ACCESS. Not so sure about other events.
I see that nfsd filecache backend only marks regular files, so that's fine.
I *think* audit only marks directories and exe files, but completely unsure.

Maybe there is no need to optimize out special inodes from all events
and only exclude them from MODIFY/ACCESS, which are the only
events where performance may be a concern?
Or maybe you did not mean to skip events on special inodes in general?

I am not sure how important OPEN events are on special inodes, but
it is scary to stop sending OPEN_PERM events.

Do you agree that we should also actively disallow setting a mark
on special disconnected inodes? instead of silently dropping events
that current kernel does deliver?

We could disallow setting a mark on a disconnected inode
(one that user is trying to configure by using a /proc/$pid/fd/X path).
We can enforce this restriction for all backends in the common helper
fsnotify_add_mark_locked().

Thanks,
Amir.
