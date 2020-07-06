Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CE02155DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 12:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgGFKvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 06:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbgGFKva (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:51:30 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7BBC061794;
        Mon,  6 Jul 2020 03:51:30 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k23so38753921iom.10;
        Mon, 06 Jul 2020 03:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KjO+bcI8oqGmq0DyG8Hz97cKfR9WyJ+d4jRvopPSb/M=;
        b=XNrg7thsKn3rHwu8zujkBPvFtp1VQfGUE63LsLV6HxL/juo6VT3v7LDNqQ2As/fyqW
         NSFEPoqOongy46z5YP9j2/QqXlxKikdCH8N2KJaYMCwYOoUWviiWrhhnSswXh5HR2WlL
         2bCCSL1mrNpibWNOKY+fb63/rlMP4vxNAQ1jD22k5Vh8yNhmJFPZrKK2d+3QpoiXVczC
         jI0OhJTvykRE3hW+kPLIs9P+SvPWLwtYpsFwTHHxrwR7H/xp8KMxHPijzlNeKsisLJIV
         ERPEwICHDnTe8SoOZgRtiF8pEt2S5NDwKAur5OkoFzeej4TjCv4lO38iGQOTOcU/u3Hz
         Losg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KjO+bcI8oqGmq0DyG8Hz97cKfR9WyJ+d4jRvopPSb/M=;
        b=fy3eNPHqttVwmiC7iQujhhxG0c59A8CUN3c74yn8n8xKRTBM2Y5Yuq3oEDiM4Cv7/h
         vD3C2UacIbks3aiU4IdBNWMMndE7TBpYe2FlcNEaC9d/yQG9RK2u8rlf/w5dKsO+MSSV
         7MejD49iR15n5dEsBCgxb6hbdneC2S+c3Mz/PO9qeculFesj6TnipDfXsP0O6EsQ9RFQ
         +3p7SSohCAXFOK3mqBc8vUS4xx4bCZc2Ciwk0KAFmsYqxN4QVHaaWkPjdv7NQqe4pAoP
         HIOEZmZz1NxgUqZIZrClc9gwJ15ttAZdUshKTikSaB2aIniRSMnUuSziB6mFnPBdlvm3
         gKMw==
X-Gm-Message-State: AOAM530KU2FRwfPCSZlad0KlHRXW6YI7oK2VrvOLjWfiVjzILsOZp8hp
        HELOFwn8AIVbJDkpfYz48FGv0KruwiJOSHtJN4I=
X-Google-Smtp-Source: ABdhPJzIv9FRAbN++bw00Q4LqoqDja7FyHipQQU79EYWPnqtlolZfpIJT+FA15lutfLCyqpDRu7XLyYCAyI7qCqDPsI=
X-Received: by 2002:a05:6638:1488:: with SMTP id j8mr24319237jak.123.1594032689650;
 Mon, 06 Jul 2020 03:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
 <20190416154513.GB13422@quack2.suse.cz> <CAOQ4uxh66kAozqseiEokqM3wDJws7=cnY-aFXH_0515nvsi2-A@mail.gmail.com>
 <20190417113012.GC26435@quack2.suse.cz> <CAOQ4uxgsJ7NRtFbRYyBj_RW-trysOrUTKUnkYKYR5OMyq-+HXQ@mail.gmail.com>
 <20200630092042.GL26507@quack2.suse.cz> <CAOQ4uxjO6Y6js-txx+_tuCx50cDobQpGMHnBe6R5fBA09-4yDA@mail.gmail.com>
 <20200703133836.GB21364@quack2.suse.cz>
In-Reply-To: <20200703133836.GB21364@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 6 Jul 2020 13:51:18 +0300
Message-ID: <CAOQ4uxj1YLwsWOQB9EobMsBi=M7Ob42bRZx4ChpJrJdCAZoWvg@mail.gmail.com>
Subject: Re: fsnotify pre-modify VFS hooks (Was: fanotify and LSM path hooks)
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 3, 2020 at 4:38 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 30-06-20 17:28:10, Amir Goldstein wrote:
> > On Tue, Jun 30, 2020 at 12:20 PM Jan Kara <jack@suse.cz> wrote:
> > > the number of variants you have to introduce and then pass NULL in some
> > > places because you don't have the info available and then it's not
> > > immediately clear what semantics the event consumers can expect... That
> > > would be good to define and then verify in the code.
> > >
> >
> > I am not sure I understand what you mean.
> > Did you mean that mnt_want_write_at() mnt_want_write_path() should be
> > actual functions instead of inline wrappers or something else?
>
> Now looking at it, I find mnt_want_write_at2() the most confusing one. Also
> the distinction between mnt_want_write_at() and mnt_want_write_path() seems
> somewhat arbitrary at the first sight (how do you decide where to use
> what?) but there I guess I see where you are coming from...

OK, I renamed the wrappers and documented them as follows:

 * mnt_want_write_path - get write access to a path's mount
 * mnt_want_write_name - get write access to a path's mount before link/unlink
 * mnt_want_write_rename - get write access to a path's mount before rename

Pushed this to branch fsnotify_pre_modify.

I can see why the use of mnt_want_write_at() and mnt_want_write_path() seems
arbitrary. This is because in VFS code, @path argument can mean the path of the
object or path of the parent, depending on the function.
It is just by examining the code that you can figure that out, but in
practice path
means parent in link/unlink/rename functions.

>
> > > Also given you have the requirement "no fs locks on event generation", I'm
> > > not sure how reliable this can be. If you don't hold fs locks when
> > > generating event, cannot it happen that actually modified object is
> > > different from the reported one because we raced with some other fs
> > > operations? And can we prove that? So what exactly is the usecase and
> > > guarantees the event needs to provide?
> >
> > That's a good question. Answer is not trivial.
> > The use case is "persistent change tracking snapshot".
> > "snapshot" because it tracks ALL changes since a point in time -
> > there is no concept of "consuming" events.
>
> So you want to answer question like: "Which paths changed since given point
> in time?" 100% reliably (no false negatives) in a power fail safe manner? So
> effectively something like btrfs send-receive?
>

It's the same use case of btrfs send-receive (power fail safe
incremental backup),
but semantics are quite different.
btrfs send-receive information contains the actual changes.
Persistent change tracking only contains the information of where changes are
possible. IOW, there is potentially much more comparing to do with the target.
And of course, it is filesystem agnostic.

Thanks,
Amir.

> > It is important to note that this is complementary to real time fs events.
> > A user library may combine the two mechanisms to a stream of changes
> > (either recorded or live), but that is out of scope for this effort.
> > Also, userspace would likely create periodic snapshots, so that e.g.
> > current snapshot records changes, while previous snapshot recorded
> > changes are being scanned.
> >
> > The concept is to record every dir fid *before* an immediate child or directory
> > metadata itself may change, so that after a crash, all recorded dir fids
> > may be scanned to search for possibly missed changes.
> >
> > The dir fid is stable, so races are not an issue in that respect.
> > When name is recorded, change tracking never examines the object at that
> > name, it just records the fact that there has been a change at [dir fid;name].
> > This is mostly needed to track creates.
>
> You're right that by only tracking dir fids where something changed you've
> elliminated most of problems since once we lookup a path, the change is
> definitely going to happen in the dir we've looked up. If it really happens
> or on which inode in the dir is not determined yet but the dir fid is. I'm
> not yet 100% sure how you'll link the dir fids to actual paths on query or
> how the handling of leaf dir entries is going to work but it seems possible
> :)
>
> > Other than that, races should be handled by the backend itself, so proof is
> > pending the completion of the backend POC, but in hand waving:
> > - All name changes in the filesystem call the backend before the change
> >   (because backend marks sb) and backend is responsible for locking
> > against races
> > - My current implementation uses overlayfs upper/index as the change
> >   track storage, which has the benefit that the test "is change recorded"
> >   is implemented by decode_fh and/or name lookup, so it is already very much
> >   optimized by inode and dentry cache and shouldn't need any locking for
> >   most  pre_modify calls
> > - It is also not a coincidence that overlayfs changes to upper fs do not
> >   trigger pre_modify hooks because that prevents the feedback loop.
> >   I wrote in commit message that "is consistent with the fact that overlayfs
> >   sets the FMODE_NONOTIFY flag on underlying open files" - that is needed
> >   because the path in underlying files is "fake" (open_with_fake_path()).
> >
> > If any of this hand waving sounds terribly wrong please let me know.
> > Otherwise I will report back after POC is complete with a example backend.
>
> It sounds like it could work :).
>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
