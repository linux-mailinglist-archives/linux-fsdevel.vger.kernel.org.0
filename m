Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2316C5FC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 07:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCWGfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 02:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCWGfg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:35:36 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0453E5587
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 23:35:35 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id c10so10968664vsh.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 23:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679553334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPt6is3U2U1XQQNwxQuUdtjMS8Jc52BFaQYbPEHRFE4=;
        b=bGXGwxgqZdOovtJi3cs21gyWM7YM57r5K1O6oAugD9vEYUHRSEF/XOGbjVGh7wpi/u
         lTotFOWz+7A3/abW9ssy9M6sUXHB26xkixQf5SduwIOkxCv/5Ubg8v1Gu2342d4rsJSm
         AkBUoNwsz/cZBQEvqRZIBYmdtSVudshOFaDjFHte2a9ec/2fyn+Kjv8S+YYaveZeSMtv
         fVzEcCAH2IjzuoyVWhgh/wPNEyti/zcslV/VxVJLsq6WVEpRpazWb8X/02iZXnha6iG7
         czCKk0j7gtjSW6tzPBIqmSMbzZ6WVo3yxmX957gU7LUR64EniZY8gQOYJphdhvFRaZAS
         iHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679553334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPt6is3U2U1XQQNwxQuUdtjMS8Jc52BFaQYbPEHRFE4=;
        b=oDWMUvSMfYdUs6mmubuEKRlfEen21p+XbReCu86o+5kseMe2vaYWoffoghxnnw/pR5
         gVDYN75YaHgDlobzFKl+vnJ24Kh7ha1yIuIm4OxL0RGyGqh8sIUV0j0IKKKC/0zNjBpa
         eZ0BtBDYHwsHig01cf/acf9BFpxQkCBeBZvkJ34KSlrYpG629/IhQQuXa6YktYTTNi1J
         7OOzlvkFatZOY5KCbsJ3IGb556rQUmv5QI423PTU6DB1T+qhYfrgOaoOaWY8CNxNcqa+
         xGRJM1dDJeazH7EzlY3uy9uE2yXLQX2Zl2dx4qbEgtBxom+9O7OoxafMiIzCYkfDclLN
         XFwQ==
X-Gm-Message-State: AO0yUKUZDbJTy3bfzeTT/K07KH0s2nUhCLA8g0JsDu1Gb28BlowEidNL
        Nyq+kyRs48+Qfi5BHqoaLToCp8i/8GOQV5ATTXtai79v1MY=
X-Google-Smtp-Source: AK7set/5VZbLL9EDIdMkbhDUZopLgSr4MIdwf793dlFUevIlAEEnJF4WY+wh3rR62Ymc5JD8/w8u/AycRiSYi+/4p+A=
X-Received: by 2002:a67:d395:0:b0:412:5424:e58e with SMTP id
 b21-20020a67d395000000b004125424e58emr1246545vsj.0.1679553333746; Wed, 22 Mar
 2023 23:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <CADNhMOuFyDv5addXDX3feKGS9edJ3nwBTBh7AB1UY+CYzrreFw@mail.gmail.com>
 <CAOQ4uxjF=oTm8wTJvVd0swfcDP0bRUmHSwq5GATYLzvUOsQfXg@mail.gmail.com>
 <CADNhMOvp3k7fuodMiSzaP-mpf5j1Z7g-_wB5gpJc9p2en6szoA@mail.gmail.com>
 <CAOQ4uxhjMfBKYmnvpX29JQkiw+ihFUo5E2RAsoOSxiW+fpzU_w@mail.gmail.com> <CADNhMOtZrRbVdFAR3VmzDtHKShedViyT5B9+JQ79STx=3x=2JQ@mail.gmail.com>
In-Reply-To: <CADNhMOtZrRbVdFAR3VmzDtHKShedViyT5B9+JQ79STx=3x=2JQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 23 Mar 2023 08:35:22 +0200
Message-ID: <CAOQ4uxhLf1qVc0x-H0jEq+NVOn-sunarzYF-1b9VTWdq0gf0=w@mail.gmail.com>
Subject: Re: inotify on mmap writes
To:     Amol Dixit <amoldd@gmail.com>
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

> On Wed, Mar 22, 2023 at 2:12=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Wed, Mar 22, 2023 at 9:43 PM Amol Dixit <amoldd@gmail.com> wrote:
> > >
> > > On Wed, Mar 22, 2023 at 12:16=E2=80=AFAM Amir Goldstein <amir73il@gma=
il.com> wrote:
> > > >
> > > > On Wed, Mar 22, 2023 at 4:13=E2=80=AFAM Amol Dixit <amoldd@gmail.co=
m> wrote:
> > > > >
> > > > > Hello,
> > > > > Apologies if this has been discussed or clarified in the past.
> > > > >
> > > > > The lack of file modification notification events (inotify, fanot=
ify)
> > > > > for mmap() regions is a big hole to anybody watching file changes=
 from
> > > > > userspace. I can imagine atleast 2 reasons why that support may b=
e
> > > > > lacking, perhaps there are more:
> > > > >
> > > > > 1. mmap() writeback is async (unless msync/fsync triggered) drive=
n by
> > > > > file IO and page cache writeback mechanims, unlike write system c=
alls
> > > > > that get funneled via the vfs layer, whih is a convenient common =
place
> > > > > to issue notifications. Now mm code would have to find a common g=
round
> > > > > with filesystem/vfs, which is messy.
> > > > >
> > > > > 2. writepages, being an address-space op is treated by each file
> > > > > system independently. If mm did not want to get involved, onus wo=
uld
> > > > > be on each filesystem to make their .writepages handlers notifica=
tion
> > > > > aware. This is probably also considered not worth the trouble.
> > > > >
> > > > > So my question is, notwithstanding minor hurdles (like lost event=
s,
> > > > > hardlinks etc.), would the community like to extend inotify suppo=
rt
> > > > > for mmap'ed writes to files? Under configs options, would a fix o=
n a
> > > > > per filesystem basis be an acceptable solution (I can start with =
say
> > > > > ext4 writepages linking back to inode/dentry and firing a
> > > > > notification)?
> > > > >
> > > > > Eventually we will have larger support across the board and
> > > > > inotify/fanotify can be a reliable tracking mechanism for
> > > > > modifications to files.
> > > > >
> > > >
> > > > What is the use case?
> > > > Would it be sufficient if you had an OPEN_WRITE event?
> > > > or if OPEN event had the O_ flags as an extra info to the event?
> > > > I have a patch for the above and I personally find this information
> > > > missing from OPEN events.
> > > >
> > > > Are you trying to monitor mmap() calls? write to an mmaped area?
> > > > because writepages() will get you neither of these.
> > >
> > > OPEN events are not useful to track file modifications in real time,
> > > although I can do see the usefulness of OPEN_WRITE events to track
> > > files that can change.
> > >
> > > I am trying to track writes to mmaped area (as these are not notified
> > > using inotify events). I wanted to ask the community of the
> > > feasibility and usefulness of this. I had some design ideas of
> > > tracking writes (using jbd commit callbacks for instance) in the
> > > kernel, but to make it generic sprucing up the inotify interface is a
> > > much better approach.
> > >
> > > Hope that provides some context.
> >
> > Not enough.
> >
> > For a given file mmaped writable by a process that is writing
> > to that mapped memory all the time for a long time.
> >
> > What do you expect to happen?
> > How many events?
> > On first time write to a page? To the memory region?
> > When dirty memory is written back to disk?
> >
> > You have mixed a lot of different things in your question.
> > You need to be more specific about what the purpose
> > of this monitoring is.
> >
> > From all of the above, only MODIFY on mmap() call
> > seems reasonable to me and MODIFY on first write to
> > an mmaped area is something that we can consider if
> > there is very good justification.
> >
> > FYI, the existing MODIFY events are from after the
> > write system call modified the page cache and there is
> > no guarantee about when writeback to disk is done.
> >


On Thu, Mar 23, 2023 at 12:13=E2=80=AFAM Amol Dixit <amoldd@gmail.com> wrot=
e:
>
> Thank you Amir for taking the time. I will take another stab at the motiv=
ation.

Please do not "top post" on fsdevel discussions.

>
> Say I am writing an efficient real time file backup application, and
> monitoring changes to certain files. The best rsync can do is to chunk
> and checksum and gather delta regions to transfer. What if, through
> inotify, the application is alerted of precise extents written to a
> certain file. This would take the form of <logical file offset,
> length> tuples in the metadata attached with each MODIFY event. That
> should be easily possible (just like we add file names to CREATE
> events). For mmaped regions 'length' would be in page granularity
> since the kernel wouldn't know precise regions written within a given
> page.
>
> > What do you expect to happen?
> Notifications can be collapsed until they are read. So if first IO is
> <0, 20> and second IO is <20, 20>, then the event can be collapsed
> in-place to read <0, 40>. If they are not contiguous, say second IO is

That can be done.
I already have patches for FAN_EVENT_INFO_TYPE_RANGE.

> <30, 10>, then we will have 2 extent entries in the metadata of MODIFY
> event - <0, 20> and <30, 10>, and so on.
>

That seems like an overkill.
More than a single extent could just drop the granular range info.

> > How many events?
> Events are always opportunistic. If too many events of the same kind,
> a generic "Too many changes" event is enough (CIFS change notification
> has something similar) to alert the reader.
>
> > On first time write to a page?
> Doesn't help ongoing activity tracking.
>
> > To the memory region?
> Precision as much as possible for offsets and lengths is nice to have.
>
> > When dirty memory is written back to disk?
> Events are more like hints (as you said they do not guarantee
> writeback to disk anyway). Applications will do their own integrity
> checks on top of these hints.
>

Hints, yes, but event do need to guarantee that a change is
not missed, so in the context of mmaped memory writes that
means that after the event is consumed by application or after
the application reads the file content, PTE may need to be setup to
trigger a new event on the next write.

Doing that on page level seems like an unacceptable overkill
for the use case of backup applications.

Perhaps a more feasible option is to generate an event when
an inode or mapping change state into "dirty pages", then backup
application needs to do:

1. consume pending MODIFY events on file
2. call fsdatasync()/msync()/sync_file_range()
3. read content of file to backup

And then we should be able to provide a guarantee
that if there is any write after #2 returned success,
a new MODIFY event will be generated.

We should probably make this a new event (e.g. FAN_WRITE)
because it has different semantics than FAN_MODIFY and it can also
be useful to non-mmapped writes use case.

None of this is going to be simple though, so to answer your
original questions:

> So my question is, notwithstanding minor hurdles (like lost events,
> hardlinks etc.), would the community like to extend inotify support
> for mmap'ed writes to files?

If you are willing to do the work and you can prove that it does not
hurt performance of any existing workload when the new feature
is not in use, I think it would be a nice improvement.

> Under configs options,

No config options please.
If you cannot make it work without hurting performance, no go.

> would a fix on a per filesystem basis be an acceptable solution
> (I can start with say ext4 writepages linking back to inode/dentry
> and firing a notification)?

Solution should be generic in vfs.
It is possible that this will not be supported for all filesystems,
but only on some filesystems that implement some vfs operation
or opt-in with some fs flag, but not a fs specific implementation.

Thanks,
Amir.
