Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924CA6C5951
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 23:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCVWNr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 18:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVWNp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:13:45 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4E46584
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 15:13:44 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c4so12058205pfl.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 15:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679523224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+IqeTopehTCJAmHP/RqG+OXZdTgMc61GkCmKFE+/ns=;
        b=ZfC1HXD9wd1zYuR3Y3J+dos10qG783QBc7taaT/fRHKpnIxXWoVIGJdxd2OW1n87jK
         BGc/QXNu4LvA8Os3rw2zp+uTvClOk0AlYwYusFstiOoO/R6o8ge9p4bmPxi5Lpll7FS/
         5YZP716d54ZoJRN2aNT3OeQv6nNJHOYYp4VIoFS+i4TDjTDwZ1K+cZR6Nm9ARjPaaMaD
         0Jp4RJhn/MLSg64ht8f9oqxyY8hslvCxyaDw+KA6ZaQh2ziXoIm4YFallzjXBEqgqiwl
         YtbjumlMflUre+c6XKDxhPrTSREbJYuOlW2B7FWi8UpXA3f/bIzMmFqIG4FuYtse0jVK
         kzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679523224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+IqeTopehTCJAmHP/RqG+OXZdTgMc61GkCmKFE+/ns=;
        b=DCucMUgXaague4To/dEM038oH5OOOifwo1Gq1f+4NMuwRWJ/Oiy00AhhINNd0p2o5v
         YAGKvqigAmEmYBFFS79RB7P/uUSRyg1iBCS8qlAkEW627AQ+vVuvqHaAnyn3L7jUVTum
         TNPtPmMOomaHYYmYg8KJOzFuNLtihpVCNXZJ8a7jIFjYf8hCzgqpZbv9wenZaOTgaZRg
         UKo+EHVV+Y4GvaBJt0onElgq8BVM2HiYh5SwaJPZyiktr2exPyVJZ4lj61fJLjH1TeBN
         NGhjdcaegqkrC2rCM/YBMW+VSYpokvCHAG8lv/JW7mb2l30gQerHako1mlcTgNelYI8E
         9/rQ==
X-Gm-Message-State: AO0yUKW5/XNNSM89k1Pxt1Zl5BnmPD5A2I9ynoJlAlbuzg1EDLy0XXbc
        NU7x8nDeIW8z9OWDbsZ4H8KtWlCHI2y0AG9z0bA=
X-Google-Smtp-Source: AK7set9i+SX2CEVlQt2+knbghlcfjSXAPuuiZYDxiiw9N4JzB9NvN6YX01HIjPCeWnAewQnpTikEOF8fOtYdb+fJcCk=
X-Received: by 2002:a05:6a00:2d1c:b0:622:f66f:25a1 with SMTP id
 fa28-20020a056a002d1c00b00622f66f25a1mr2866871pfb.0.1679523224133; Wed, 22
 Mar 2023 15:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <CADNhMOuFyDv5addXDX3feKGS9edJ3nwBTBh7AB1UY+CYzrreFw@mail.gmail.com>
 <CAOQ4uxjF=oTm8wTJvVd0swfcDP0bRUmHSwq5GATYLzvUOsQfXg@mail.gmail.com>
 <CADNhMOvp3k7fuodMiSzaP-mpf5j1Z7g-_wB5gpJc9p2en6szoA@mail.gmail.com> <CAOQ4uxhjMfBKYmnvpX29JQkiw+ihFUo5E2RAsoOSxiW+fpzU_w@mail.gmail.com>
In-Reply-To: <CAOQ4uxhjMfBKYmnvpX29JQkiw+ihFUo5E2RAsoOSxiW+fpzU_w@mail.gmail.com>
From:   Amol Dixit <amoldd@gmail.com>
Date:   Wed, 22 Mar 2023 15:13:32 -0700
Message-ID: <CADNhMOtZrRbVdFAR3VmzDtHKShedViyT5B9+JQ79STx=3x=2JQ@mail.gmail.com>
Subject: Re: inotify on mmap writes
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you Amir for taking the time. I will take another stab at the motivat=
ion.

Say I am writing an efficient real time file backup application, and
monitoring changes to certain files. The best rsync can do is to chunk
and checksum and gather delta regions to transfer. What if, through
inotify, the application is alerted of precise extents written to a
certain file. This would take the form of <logical file offset,
length> tuples in the metadata attached with each MODIFY event. That
should be easily possible (just like we add file names to CREATE
events). For mmaped regions 'length' would be in page granularity
since the kernel wouldn't know precise regions written within a given
page.

> What do you expect to happen?
Notifications can be collapsed until they are read. So if first IO is
<0, 20> and second IO is <20, 20>, then the event can be collapsed
in-place to read <0, 40>. If they are not contiguous, say second IO is
<30, 10>, then we will have 2 extent entries in the metadata of MODIFY
event - <0, 20> and <30, 10>, and so on.

> How many events?
Events are always opportunistic. If too many events of the same kind,
a generic "Too many changes" event is enough (CIFS change notification
has something similar) to alert the reader.

> On first time write to a page?
Doesn't help ongoing activity tracking.

> To the memory region?
Precision as much as possible for offsets and lengths is nice to have.

> When dirty memory is written back to disk?
Events are more like hints (as you said they do not guarantee
writeback to disk anyway). Applications will do their own integrity
checks on top of these hints.

With precise written extents available in userspace, the backup
application is very happy to just incrementally backup written extents
at byte granularity (or page granularity for mmaped events).

Amol





On Wed, Mar 22, 2023 at 2:12=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Mar 22, 2023 at 9:43 PM Amol Dixit <amoldd@gmail.com> wrote:
> >
> > On Wed, Mar 22, 2023 at 12:16=E2=80=AFAM Amir Goldstein <amir73il@gmail=
.com> wrote:
> > >
> > > On Wed, Mar 22, 2023 at 4:13=E2=80=AFAM Amol Dixit <amoldd@gmail.com>=
 wrote:
> > > >
> > > > Hello,
> > > > Apologies if this has been discussed or clarified in the past.
> > > >
> > > > The lack of file modification notification events (inotify, fanotif=
y)
> > > > for mmap() regions is a big hole to anybody watching file changes f=
rom
> > > > userspace. I can imagine atleast 2 reasons why that support may be
> > > > lacking, perhaps there are more:
> > > >
> > > > 1. mmap() writeback is async (unless msync/fsync triggered) driven =
by
> > > > file IO and page cache writeback mechanims, unlike write system cal=
ls
> > > > that get funneled via the vfs layer, whih is a convenient common pl=
ace
> > > > to issue notifications. Now mm code would have to find a common gro=
und
> > > > with filesystem/vfs, which is messy.
> > > >
> > > > 2. writepages, being an address-space op is treated by each file
> > > > system independently. If mm did not want to get involved, onus woul=
d
> > > > be on each filesystem to make their .writepages handlers notificati=
on
> > > > aware. This is probably also considered not worth the trouble.
> > > >
> > > > So my question is, notwithstanding minor hurdles (like lost events,
> > > > hardlinks etc.), would the community like to extend inotify support
> > > > for mmap'ed writes to files? Under configs options, would a fix on =
a
> > > > per filesystem basis be an acceptable solution (I can start with sa=
y
> > > > ext4 writepages linking back to inode/dentry and firing a
> > > > notification)?
> > > >
> > > > Eventually we will have larger support across the board and
> > > > inotify/fanotify can be a reliable tracking mechanism for
> > > > modifications to files.
> > > >
> > >
> > > What is the use case?
> > > Would it be sufficient if you had an OPEN_WRITE event?
> > > or if OPEN event had the O_ flags as an extra info to the event?
> > > I have a patch for the above and I personally find this information
> > > missing from OPEN events.
> > >
> > > Are you trying to monitor mmap() calls? write to an mmaped area?
> > > because writepages() will get you neither of these.
> >
> > OPEN events are not useful to track file modifications in real time,
> > although I can do see the usefulness of OPEN_WRITE events to track
> > files that can change.
> >
> > I am trying to track writes to mmaped area (as these are not notified
> > using inotify events). I wanted to ask the community of the
> > feasibility and usefulness of this. I had some design ideas of
> > tracking writes (using jbd commit callbacks for instance) in the
> > kernel, but to make it generic sprucing up the inotify interface is a
> > much better approach.
> >
> > Hope that provides some context.
>
> Not enough.
>
> For a given file mmaped writable by a process that is writing
> to that mapped memory all the time for a long time.
>
> What do you expect to happen?
> How many events?
> On first time write to a page? To the memory region?
> When dirty memory is written back to disk?
>
> You have mixed a lot of different things in your question.
> You need to be more specific about what the purpose
> of this monitoring is.
>
> From all of the above, only MODIFY on mmap() call
> seems reasonable to me and MODIFY on first write to
> an mmaped area is something that we can consider if
> there is very good justification.
>
> FYI, the existing MODIFY events are from after the
> write system call modified the page cache and there is
> no guarantee about when writeback to disk is done.
>
> Thanks,
> Amir.
