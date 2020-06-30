Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD18D20F732
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 16:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388967AbgF3O21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 10:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388956AbgF3O2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:28:22 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A26AC061755;
        Tue, 30 Jun 2020 07:28:22 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id e18so7198252ilr.7;
        Tue, 30 Jun 2020 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJGxdE2zhF1OWSiyBvXLiEVFkZjHjVdukvz6hayuIpI=;
        b=DL/YRFX3zWB+1beCdpv+E37M+LOOjRuNqHqq/SfNIZgajEnX6s2IlHb6fNRMMMWxGE
         4AzYf440Q7iKP2/9/e7Cil+lKvg8348iuRpT9aCsj7pG3dEVrX1ApgRi5EqFvyRB4Ciw
         o7IV6zr2zN0Z55YYU8YHDwhx5n9woT+xsiozx9LyGoRsc2mKYEG8Y+7V4+Dki+TdmpyO
         L3tZx1AUzaqU6jTUEb3PfQQNFbDAccxcElfF2gzF+XzZEIPLziBJjb6egypi6JDEHNF6
         tNIUsWP0LJbjygNXpG9urCWck5unK3xlC0p9ISGstcdupsvfxrXPL+XMRX+Okei8G62x
         H3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJGxdE2zhF1OWSiyBvXLiEVFkZjHjVdukvz6hayuIpI=;
        b=imM4SW4wdnDTlLs8TIjBVL7eq/i0UwAd1Jg/wsTWPYFfWxa4XHd2KmpgnB0YuuBcfo
         yuwGxFKrDkq1xSbHwLenOwZ/Dx2uAFW/9XVVVmaY0aOwQF1djkW5W+DtnF5yA1ufkDPK
         7lW1HKbkfDki64+TX7x52YN/iHNP4BOXlKfgpUes35wnP/rJ5K8W0G0swzVGC+jO4F0D
         /HM0r9kWhgI/8yYQz3wj1jMQIVftvbEn/DkrFsQHp5cVBCzUH1aJrDMy76onwsuTHZr6
         UP30iRXonacMgfAgDDSHIivDbPgNUgqXza4CHFwTt/NqdfLi0dQwOPvXd3I121IlIjkB
         hYBA==
X-Gm-Message-State: AOAM530Cy1MZfsA6QBv7VdycbGOb1ujQGiUV66RtypvCLp4OTzgn263r
        C9rvVFdYaSwrQeabWKo1ilkjkEWyUsjNPlhNQ30=
X-Google-Smtp-Source: ABdhPJwB6NQUwSjMCoZwHmFe2Q0X6v417pHxOWgPMaDrLN5c9jUAsIRXQOfkkTxdsebMp8JRb4p1McDLq35Ri9ocQ04=
X-Received: by 2002:a92:2a0c:: with SMTP id r12mr2752884ile.275.1593527301732;
 Tue, 30 Jun 2020 07:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
 <20190416154513.GB13422@quack2.suse.cz> <CAOQ4uxh66kAozqseiEokqM3wDJws7=cnY-aFXH_0515nvsi2-A@mail.gmail.com>
 <20190417113012.GC26435@quack2.suse.cz> <CAOQ4uxgsJ7NRtFbRYyBj_RW-trysOrUTKUnkYKYR5OMyq-+HXQ@mail.gmail.com>
 <20200630092042.GL26507@quack2.suse.cz>
In-Reply-To: <20200630092042.GL26507@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 Jun 2020 17:28:10 +0300
Message-ID: <CAOQ4uxjO6Y6js-txx+_tuCx50cDobQpGMHnBe6R5fBA09-4yDA@mail.gmail.com>
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

On Tue, Jun 30, 2020 at 12:20 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 26-06-20 14:06:37, Amir Goldstein wrote:
> > On Wed, Apr 17, 2019 at 2:30 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 16-04-19 21:24:44, Amir Goldstein wrote:
> > > > > I'm not so sure about directory pre-modification hooks. Given the amount of
> > > > > problems we face with applications using fanotify permission events and
> > > > > deadlocking the system, I'm not very fond of expanding that API... AFAIU
> > > > > you want to use such hooks for recording (and persisting) that some change
> > > > > is going to happen and provide crash-consistency guarantees for such
> > > > > journal?
> > > > >
> > > >
> > > > That's the general idea.
> > > > I have two use cases for pre-modification hooks:
> > > > 1. VFS level snapshots
> > > > 2. persistent change tracking
> > > >
> > > > TBH, I did not consider implementing any of the above in userspace,
> > > > so I do not have a specific interest in extending the fanotify API.
> > > > I am actually interested in pre-modify fsnotify hooks (not fanotify),
> > > > that a snapshot or change tracking subsystem can register with.
> > > > An in-kernel fsnotify event handler can set a flag in current task
> > > > struct to circumvent system deadlocks on nested filesystem access.
> > >
> > > OK, I'm not opposed to fsnotify pre-modify hooks as such. As long as
> > > handlers stay within the kernel, I'm fine with that. After all this is what
> > > LSMs are already doing. Just exposing this to userspace for arbitration is
> > > what I have a problem with.
> > >
> >
> > Short update on that.
> >
> > I decided to ditch the LSM hooks approach because I realized that for
> > the purpose of persistent change tracking, the pre-modify hooks need
> > to be called before the caller is taking filesystem locks.
> >
> > So I added hooks inside mnt_want_write and file_start_write wrappers:
> > https://github.com/amir73il/linux/commits/fsnotify_pre_modify
>
> FWIW I've glanced through the series. I like the choice of mnt_want_write()
> and file_start_write() as a place to generate the event. I somewhat dislike

Thanks. I was looking for this initial feedback to know if direction in sane.

> the number of variants you have to introduce and then pass NULL in some
> places because you don't have the info available and then it's not
> immediately clear what semantics the event consumers can expect... That
> would be good to define and then verify in the code.
>

I am not sure I understand what you mean.
Did you mean that mnt_want_write_at() mnt_want_write_path() should be
actual functions instead of inline wrappers or something else?

> Also given you have the requirement "no fs locks on event generation", I'm
> not sure how reliable this can be. If you don't hold fs locks when
> generating event, cannot it happen that actually modified object is
> different from the reported one because we raced with some other fs
> operations? And can we prove that? So what exactly is the usecase and
> guarantees the event needs to provide?
>

That's a good question. Answer is not trivial.
The use case is "persistent change tracking snapshot".
"snapshot" because it tracks ALL changes since a point in time -
there is no concept of "consuming" events.
It is important to note that this is complementary to real time fs events.
A user library may combine the two mechanisms to a stream of changes
(either recorded or live), but that is out of scope for this effort.
Also, userspace would likely create periodic snapshots, so that e.g.
current snapshot records changes, while previous snapshot recorded
changes are being scanned.

The concept is to record every dir fid *before* an immediate child or directory
metadata itself may change, so that after a crash, all recorded dir fids
may be scanned to search for possibly missed changes.

The dir fid is stable, so races are not an issue in that respect.
When name is recorded, change tracking never examines the object at that
name, it just records the fact that there has been a change at [dir fid;name].
This is mostly needed to track creates.

Other than that, races should be handled by the backend itself, so proof is
pending the completion of the backend POC, but in hand waving:
- All name changes in the filesystem call the backend before the change
  (because backend marks sb) and backend is responsible for locking
against races
- My current implementation uses overlayfs upper/index as the change
  track storage, which has the benefit that the test "is change recorded"
  is implemented by decode_fh and/or name lookup, so it is already very much
  optimized by inode and dentry cache and shouldn't need any locking for
  most  pre_modify calls
- It is also not a coincidence that overlayfs changes to upper fs do not
  trigger pre_modify hooks because that prevents the feedback loop.
  I wrote in commit message that "is consistent with the fact that overlayfs
  sets the FMODE_NONOTIFY flag on underlying open files" - that is needed
  because the path in underlying files is "fake" (open_with_fake_path()).

If any of this hand waving sounds terribly wrong please let me know.
Otherwise I will report back after POC is complete with a example backend.

Thanks,
Amir.
