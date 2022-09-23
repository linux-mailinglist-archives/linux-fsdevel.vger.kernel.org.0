Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6FA5E7981
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 13:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiIWLX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 07:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiIWLXm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:23:42 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD5613745E
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 04:22:57 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id j17so13352814vsp.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 04:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=biGiF25UByUVLuqZgIntNNvPyuUxtRzh+2fHm5R4Epc=;
        b=WN2I2u2j48gWn+XCoT39W7F/u9CaHNNCtD6taNjZU2r8kTDPP/ORqHvdY3Tiqktx1s
         zff1ZdaYD1c0vbmzhjwHGadWj/cnOS0YwGBPNtMlEn1srOer3iRNjGavo+pnxrD7cy/3
         TAOVq0AqC9iLFohKyH2P0HxaV9R02af0U1ohkU02oTz8bqW7GioeI97rlcuQ7kwDvsoK
         XjWF+GPzG4wrUfDhIZJ8vj96/UNUSZJT7Uj+RMI56SoaS7Asq2burNSWGMWRKRkJQCpd
         pUhFKjDzVhZUTxKZGf3pVbW8YUiV5EZl1B5Gs3SRYcy1U5OfkqXzPoQRRiLDdFoAUVe/
         e/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=biGiF25UByUVLuqZgIntNNvPyuUxtRzh+2fHm5R4Epc=;
        b=0OdQjolGVrycfVYRu7/YdP3deH4QVSizXl3fPXjs3keUYGTdp7ldwDRCW0Og05TIkn
         Ul+vLKn+KCdE//PRL+s0xzxs0xZ+PG0GL5gIEU1cOIb7yn5G8P/C4F1OAWqr+Lj1HnGZ
         xhL22Dv7kE6pnUqEvVrVTJkV76tFUxQoNPF53mJYalLF6c+MeM1Vmz1JpcRdsVtuZIN1
         BMVUUcRojw95uHokXcZJ8OvtlQLH2ZyymetZ7qBmJmQnHHvFLy+ofSGIhUEnMyi1Ue51
         yKKcgBbsNZgCaR2hYVF8Tc7wRqLHPrPvkLDjThzi7u7R3xPEXjxI82tQiuPgIQ+2uP5N
         Hd+w==
X-Gm-Message-State: ACrzQf01BRFbqcNsBEvaKvVDwCE6IT882ti/4Ry8Ve0y87yI1lu688bu
        zBbTO990uL/D81AmcohCfSD9Ry0pLOLgQpG9QGM=
X-Google-Smtp-Source: AMsMyM7Kp1CsTNQEipvksfSsrjfCiznUUoWcUfOcR7QTqpvyZn1Vv5mLiLYVTOuHrU8++b/X4fsPglp2dMVEad5MOaU=
X-Received: by 2002:a05:6102:14b:b0:398:2e7c:4780 with SMTP id
 a11-20020a056102014b00b003982e7c4780mr2942329vsr.72.1663932171269; Fri, 23
 Sep 2022 04:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
 <20220921232729.GE3144495@dread.disaster.area> <CAOQ4uxgip1Hfvtjf=XvXSbGpBoJrN0Zc7JD_z9QqtW5U7mSN5Q@mail.gmail.com>
 <20220923075753.GF3144495@dread.disaster.area>
In-Reply-To: <20220923075753.GF3144495@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 23 Sep 2022 14:22:38 +0300
Message-ID: <CAOQ4uxisq=b90Z2iBuWKGoQoOUCS9j5Tzo0_hMgPEdoaehvrxA@mail.gmail.com>
Subject: Re: thoughts about fanotify and HSM
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Plaster, Robert" <rplaster@deepspacestorage.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 w


On Fri, Sep 23, 2022 at 10:57 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Sep 22, 2022 at 07:35:39AM +0300, Amir Goldstein wrote:
> > On Thu, Sep 22, 2022 at 2:27 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Sun, Sep 11, 2022 at 09:12:06PM +0300, Amir Goldstein wrote:
> > > > Hi Jan,
> > > >
> > > > I wanted to consult with you about preliminary design thoughts
> > > > for implementing a hierarchical storage manager (HSM)
> > > > with fanotify.
> > > >
> > > > I have been in contact with some developers in the past
> > > > who were interested in using fanotify to implement HSM
> > > > (to replace old DMAPI implementation).
> > > >
> > > > Basically, FAN_OPEN_PERM + FAN_MARK_FILESYSTEM
> > > > should be enough to implement a basic HSM, but it is not
> > > > sufficient for implementing more advanced HSM features.
> > >
> > > Ah, I wondered where the people with that DMAPI application went all
> > > those years ago after I told them they should look into using
> > > fanotify to replace the dependency they had on the DMAPI patched
> > > XFS that SGI maintained for years for SLES kernels...
> > >
> >
> > Indeed. Robert has told that the fanotify HSM code would be uploaded
> > to github in the near future:
> >
> > https://deepspacestorage.com/resources/#downloads
> >
> > > > Some of the HSM feature that I would like are:
> > > > - blocking hook before access to file range and fill that range
> > > > - blocking hook before lookup of child and optionally create child
> > >
> > > Ok, so these are to replace the DMAPI hooks that provided a blocking
> > > userspace upcall to the HSM to allow it fetch data from offline
> > > teirs that wasn't currently in the filesystem itself. i.e. the inode
> > > currently has a hole over that range of data, but before the read
> > > can proceed the HSM needs to retreive the data from the remote
> > > storage and write it into the local filesystem.
> > >
> > > I think that you've missed a bunch of blocking notifications that
> > > are needed, though. e.g. truncate needs to block while the HSM
> > > records the file ranges it is storing offline are now freed.
> > > fallocate() needs to block while it waits for the HSM to tell it the
> > > ranges of the file that actually contain data and so should need to
> > > be taken into account. (e.g. ZERO_RANGE needs to wait for offline
> > > data to be invalidated, COLLAPSE_RANGE needs offline data to be
> > > recalled just like a read() operation, etc).
> > >
> > > IOWs, any operation that manipulates the extent map or the data in
> > > the file needs a blocking upcall to the HSM so that it can restore
> > > and invalidate the offline data across the range of the operation
> > > that is about to be performed....
> >
> > The event FAN_PRE_MODIFY mentioned below is destined to
> > take care of those cases.
> > It is destined to be called from
> > security_file_permission(MAY_WRITE) => fsnotify_perm()
> > which covers all the cases that you mentioned.
>
> That doesn't provide IO ranges to userspace, so does that mean
> write(1 byte) might trigger the recall of an entire TB sized file
> from offline storage?
>
> How do you support partial file migration with a scheme like this?

That would be handled by:
- FAN_PRE_ACCESS and FAN_PRE_MODIFY can have
  optional file range info

In the API extension proposal below

>
> > > > My thoughts on the UAPI were:
> > > > - Allow new combination of FAN_CLASS_PRE_CONTENT
> > > >   and FAN_REPORT_FID/DFID_NAME
> > > > - This combination does not allow any of the existing events
> > > >   in mask
> > > > - It Allows only new events such as FAN_PRE_ACCESS
> > > >   FAN_PRE_MODIFY and FAN_PRE_LOOKUP
> > > > - FAN_PRE_ACCESS and FAN_PRE_MODIFY can have
> > > >   optional file range info
> > > > - All the FAN_PRE_ events are called outside vfs locks and
> > > >   specifically before sb_writers lock as in my fsnotify_pre_modify [1]
> > > >   POC
> > > >
> > > > That last part is important because the HSM daemon will
> > > > need to make modifications to the accessed file/directory
> > > > before allowing the operation to proceed.
> > >
> > > Yes, and that was the biggest problem with DMAPI - the locking
> > > involved. DMAPI operations have to block without holding any locks
> > > that the IO path, truncate, fallocate, etc might need, but once they
> > > are unblocked they need to regain those locks to allow the operation
> > > to proceed. This was by far the ugliest part of the DMAPI patches,
> > > and ultimately, the reason why it was never merged.
> >
> > Part of the problem is that the DMAPI hooks were inside fs code.
> > My intention for fanotify blocking hooks to be in vfs before taking any
> > locks as much as possible.
> >
> > I already have a poc project that added those pre-modify hooks
> > for the change tracking journal thing.
> >
> > For most of the syscalls, security_file_permission(MAY_WRITE) is
> > called before taking vfs locks (sb_writers in particular), except for
> > dedupe and clone and that one is my fault - 031a072a0b8a
> > ("vfs: call vfs_clone_file_range() under freeze protection"), so
> > I'll need to deal with it.
>
> This looks like a farly large TOCTOU race condition.  i.e. what's to
> prevent a "move offline" operation run by a userspace HSM agent
> racing with an application read that has done it's FAN_PRE_MODIFY
> call but hasn't yet started/completed it's physical read from the
> filesystem? This sort of race can result in the data in the file
> being migrated and punched out by the HSM before the read gets the
> i_rwsem or page locks it needs to read the data into cache....
>
> What am I missing here? How does this "no filesystem locks"
> notification scheme avoid these sorts of spurious user data
> corruption events from occurring?
>

See my answer to Jan to the same question.
HSM will take a write lease on the file before punching out a file.
It is an existing API that I do not even need to extend.
I do need to POC this method though...

> > > > Naturally that opens the possibility for new userspace
> > > > deadlocks. Nothing that is not already possible with permission
> > > > event, but maybe deadlocks that are more inviting to trip over.
> > > >
> > > > I am not sure if we need to do anything about this, but we
> > > > could make it easier to ignore events from the HSM daemon
> > > > itself if we want to, to make the userspace implementation easier.
> > >
> > > XFS used "invisible IO" as the mechanism for avoiding sending DMAPI
> > > events for operations that we initiated by the HSM to move data into
> > > and out of the filesystem.
> > >
> > > No doubt you've heard us talk about invisible IO in the past -
> > > O_NOCMTIME is what that invisible IO has eventually turned into in a
> > > modern Linux kernel. We still use that for invisible IO - xfs_fsr
> > > uses it for moving data around during online defragmentation. The
> > > entire purpose of invisible IO was to provide a path for HSMs and
> > > userspace bulk data movers (e.g. HSM aware backup tools like
> > > xfsdump) to do IO without generating unnecessary or recursive DMAPI
> > > events....
> > >
> > > IOWs, if we want a DMAPI replacement, we will need to formalise a
> > > method of performing syscall based operations that will not trigger
> > > HSM notification events.
> >
> > This concept already exists in fanotify.
> > This is what FMODE_NONOTIFY is for.
> > The event->fd handed in FAN_ACCESS_PERM event can be use to
> > read the file without triggering a recursive event.
> > This is how Anti-Malware products scan files.
>
> So all that you need is to enable invisible IO for the data
> migration operations, then?

Correct.

>
> BTW, where does the writable fd that is passed to the userspace
> event that the HSM can use to do IO to/from the inode come from? How
> does fanotify guarantee that the recipient has the necessary
> permissions to read/write to the file it represents?
>

fanotify opens the file and installs it in the event reader process.
That has always been like that.
That's one of the reasons that fanotify requires CAP_SYS_ADMIN
for subscribing for permission events, so IOW, only CAP_SYS_ADMIN
can create fd for fanotify invisible IO and fanotify invisible lookup.

> > I have extended that concept in my POC patch to avoid recursive
> > FAN_LOOKUP_PERM event when calling Xat() syscall with
> > a dirfd with FMODE_NONOTIFY:
> >
> > https://github.com/amir73il/linux/commits/fanotify_pre_content
> >
> > > The other thing that XFS had for DMAPI was persistent storage in the
> > > inode of the event mask that inode should report events for. See
> > > the di_dmevmask and di_dmstate fields defined in the on-disk inode
> > > format here:
> > >
> > > https://git.kernel.org/pub/scm/fs/xfs/xfs-documentation.git/tree/design/XFS_Filesystem_Structure/ondisk_inode.asciidoc
> > >
> > > There's no detail for them, but the event mask indicated what DMAPI
> > > events the inode should issue notifications for, and the state field
> > > held information about DMAPI operations in progress.
> > >
> > > The event field is the important one here - if the event field was
> > > empty, access to the inode never generated DMAPI events. When the
> > > HSM moved data offline, the "READ" event mask bit was set by the HSM
> > > and that triggered DMAPI events for any operation that needed to
> > > read data or manipulate the extent map. When the data was brought
> > > entirely back online, the event masks count be cleared.
> > >
> >
> > HSM can and should manage this persistent bit, but it does not
> > have to be done using a special ioctl.
> > We already use xattr and/or fileattr flags in our HSM implementation.
> >
> > I've mentioned this in my reply to Jan.
> > The way I intend to address this "persistent READ hook" in
> > fanotify side is by attaching an HSM specific BFP program to
> > an fanotify filesystem mark.
>
> How is that fanotify mark and BPF hook set? What triggers it?
> What makes it persistent? Why does it need a BPF program? What is
> the program actually intended to do?
>

Currently, fanotify is able to place a (non persistent) "mark" on an
inode or a mount or a filesystem to subscribe for permission events.

The BFP program is intended to be attached to a filesystem mark
to filter in the kernel the events that the user gets.

It is something we discussed and need in fanotify for other reasons
as well (e.g. subtree filtering).

When I am talking about a "persistent mark" on a file I do not mean
that after reboot, access to a file will generate a permission event.

What I mean is that after reboot, if the HSM is running and has placed
a filesystem mark with a BFP filter on the filesystem, then it will get
events on that file.

So "persistent mark" can be just about anything that HSM chooses
it to be, as long as a BFP program has a way to check that marker.

> You're making big assumptions that people actually know what you are
> trying to implement, also how and why. Perhaps you should write a
> design overview that connects all the dots and explains why things
> like custom BPF programs are necessary...

Yes. I most definitely should. That will be my next step.
And I will provide a demo HSM implementation with it.
I just wanted to send out a heads up to see if there are any
immediate reasons to shoot down the idea.

>
> > We could standartize a fileattr flag just the same as NODUMP
> > was for the use of backup applications (e.g. NODATA), but it
> > is not a prerequite, just a standard way for HSM to set the
> > persistent READ hook bit.
>
> So you do actually need the filesystem to store information about
> HSM events that need to be generated, but then all the events are
> generated at the VFS without holding filesysetm locks? That seems
> like it could be racy, too.
>

The filesystem is just a host for the flag/xattr.
Setting that marker and clearing it is completely under the responsibility
of HSM.

"no filesystem locks" is referring only to the period that the user is
handling the event. It does not mean that there are no locks
and other synchronization involved when checking the mark.

HSM will only set or remove that mark with exclusive write lease,
so I do not think checking for the mark in a race free manner is going
to be a problem. We'll see...

> > An HSM product could be configured to reappropriate NODUMP
> > for that matter or check for no READ bits in st_mode or xattr.
>
> You know better than to try to redefine the meaning of a well known
> attribute that has been exposed to userspace for 25+ years and is
> widely used...
>

I do. That means that I will not propose to reappropriate NODUMP
in kernel code, but an HSM implementation can do whatever it wants
to do, as long as we let it control the flag and check it with a BFP program.

To be fair, even a backup application cannot know that it is the only
backup application on the system, so it has always been the responsibility
of the sysadmin (or the distro) to make sure that backup applications
do not step on each other.

I will definitely push for defining a new flag that is dedicated
for HSM applications, but again, it would be the responsibility
of the sysadmin (or the distro) to make sure that HSM applications
do not step on each other.

> > > However, DMAPI also supports dual state operation, where the
> > > data in the local filesystem is also duplicated in the offline
> > > storage (e.g. immediately after a recall operation). This state can
> > > persist until data or layout is changed in the local filesystem,
> > > and so there's a "WRITE" event mask as well that allows the
> > > filesystem to inform the HSM that data it may have in offline
> > > storage is being changed.
> > >
> > > The state field is there to tell the HSM that an operation was in
> > > progress when the system crashed. As part of recovery, the HSM needs
> > > to find all the inodes that had DM operations in progress and either
> > > complete them or revert them to bring everything back to a
> > > consistent state. THe SGI HSMs used the bulkstat interfaces to scan
> > > the fs and find inodes that had a non-zero DM state field. This is
> > > one of the reasons that having bulkstat scale out to scanning
> > > millions of inodes a second ends up being important - coherency
> > > checking between the ondisk filesystem state and the userspace
> > > offline data tracking databases is a very important admin
> > > operation..
> > >
> >
> > Normally, HSM will be listening on a filesystem mark to async
> > FAN_MODIFY and FAN_CLOSE_WRITE events.
> >
> > To cover the case of crash and missing fanotify events, we use
> > the persistent change tracking journal.
> > My current prototype is in overlayfs driver using pre-modify
> > fsnotify hooks, as we discussed back in LSFMM 2018:
> >
> > https://github.com/amir73il/overlayfs/wiki/Overlayfs-watch
>
> Yup, which lead to the conclusion that the only way it could work
> was "synchronous write of the change intent to the change journal
> before the change is made".
>

Yes, but this is not a performance killer, because the performance
penalty is only paid on first modification to file in a directory
The fast path (directory is already marked dirty) does not need
any writing to the change tracking journal at all.

This is something that I am confident about, because the
overlayfs watch code is already in production for a long time
and we have lots of performance regression tests for large scale
setups (i.e. many concurrent users, many files and dirs).

> > The idea is to export those pre-modify hooks via fanotify
> > and move this implementation from the overlayfs driver to
> > userspace HSM daemon.
> >
> > Note that the name "Change Tracking Journal" may be confusing -
> > My implementation does not store a time sequence of events like
> > the NTFS Change Journal - it only stores a map of file handles of
> > directories containing new/changed/deleted files.
> >
> > Iterating this "Changed dirs map" is way faster then itereating
> > bulkstat of all inodes and looking for the WRITE bit.
>
> Maybe so, but you haven't ever provided data to indicate what sort
> of filesystem modification rate this change journal can sustain.
> Just from my understanding of what it needs to do (sync updates), I
> can't see how it could be implemented without affecting overall
> runtime file and directory modification rates adversely.
>

This does seem like an impossible trade off.
The key to getting it right is making sure that most of the directory
modifications are not "first modifications" and that depends on
the frequency of the change tracking snapshots.

> At which point I ponder what is worse - always taking the runtime
> overhead for the change journal operations to be propagated to the
> HSM to record persistently and then replaying that journal after a
> mount, or the HSM just needing to run a bulkstat scan in the
> background after mount to do a coherency check and resolution scan?
>

My solution to that was "a little bit of both" and experience from the
fields shows that there is a way to get to a good balance.
Even with weekly change tracking snapshots, the worse case
"scan at mount" times become much smaller and the once per week
per dir performance penalty is in the noise.

Essentially, the change tracking journal is most useful for users that
have massive amounts of cold and rarely accessed files.
Surely, a filesystem implementation of "smart inode iterator" that
includes user defined filters (e.g. ctime > T) would have been a very
efficient way to achieve the same thing, but I prefer a filesystem agnostic
solution.

> > The responsibility of maintaining per file "dirty" state is on HSM
> > and it can be done using the change tracking journal and an
> > external database. Filesystem provided features such as ctime
> > and iversion can be used to optimize the management of "dirty"
> > state, but they are not a prerequisite and most of the time the
> > change journal is sufficient to be able to scale up, because it
> > can give you the answer to the question:
> > "In which of the multi million dirs, do I need to look for changes
> >  to be synced to secondary storage?".
>
> Sure, it's not every file that gets recorded, but it still sounds
> like this could be a significant percentage of the filesystem
> contents that need scanning. And the HSM would still have to scan
> them by the directory structure operations, which typically costs
> about 3-4x as much IO, CPU and wall time overhead per scanned inode
> compared to bulkstat.
>

You are very much correct.

There is another advantage to directory structure traversal.
It helps HSM detect path changes, which is needed for some HSMs.

If you take into account that you need to resolve the back path from
directory inode then bulkstat loses big time to directory traversal.

An important property of overlayfs watch that I did not get into
but it is crucial to the HSM scanning stage - The journal does not only
record the changed dir, but all of its ancestors as well, so the much more
important question that the journal can answer is:
"Are there any changed files under this (huge) tree?".

Modifications to files with hardlinks or disconnected paths are trickier,
but it's workable, because those are the corner cases.

> Please note that I'm not saying that either mechanism is better, nor
> am I saying that bulkstat scanning is a perfect solution, just that
> I've got zero information about how this change journal performs and
> what impact it has on runtime operation. Bulkstat scans, OTOH, I
> understand intimately and especially in the context of HSM
> operations. i.e. I know that scanning a billion inodes only takes a
> few minutes of wall time with modern SSDs and CPUs...
>

I have also considered using bulkstat many times.
In the end it's a matter of balance. Some HSMs/data sets/workloads
may be better off with bulkstat, but then again, I prefer that at least
a filesystem agnostic solution will be available.

> > > The XFS dmapi event and state mask control APIs are now deprecated.
> > > The XFS_IOC_FSSETDM ioctl could read and write the values, and the
> > > the XFS V1 bulkstat ioctl could read them. There were also flags for
> > > things like extent mapping ioctls (FIEMAP equivalent) that ensured
> > > looking at the extent map didn't trigger DMAPI events and data
> > > recall.
> > >
> > > I guess what I'm trying to say is that there's a lot more to an
> > > efficient implementation of a HSM event notification mechanism than
> > > just implementing a couple of blocking upcalls. IF we want something
> > > that will replace even simple DMAPI-based HSM use cases, we really
> > > need to think through how to support all the operations that a
> > > recall operation might needed for and hence have to block. ANd we
> > > really should think about how to efficiently filter out unnecessary
> > > events so that we don't drown the HSM in IO events it just doesn't
> > > need to know about....
> >
> > Thinking about efficient HSM implementation and testing prototypes is
> > what I have been doing for the past 6 years in CTERA.
>
> Great!
>
> It sounds like you'll have no trouble documenting the design to
> teach us all how you've solved these problems so we understand what
> you are asking us to review... :)
>

I will try to do even better - I plan to provide reference design
prototype code, but first a wiki!

Thanks,
Amir.
