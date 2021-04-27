Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6280436BE38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 06:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhD0EMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 00:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbhD0EMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 00:12:44 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE6CC061574;
        Mon, 26 Apr 2021 21:12:01 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id p15so12777177iln.3;
        Mon, 26 Apr 2021 21:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8MVuBFR2XxKHPkmaoZoMN5oaF3fTaviuOF9+iTNKqE=;
        b=MGHYaICOSywJMEtfJjDWDqRg7X57cqS2M64gXOeGnRkEeYQ2ovNDhob12+2VFcq4nM
         rqY3dg39CafOXGR8CqA0Bqg+LxdTR2liWP5MCEWUPHHwBqiz5qede0LY4orK5beQzLrU
         LJySyhsLgqRAHqmF/vUBQrMn+4BzcvAlCrBByskenkhOFweEl1KHKW161clZci2+lIJI
         7ZmspeihRj1A9WkohMwRCuoZqrcMIelMqrZoDkv83pTYUq8GqFW94JybbbTrfqWNUkJl
         eafUw/N+Jx9BowubaiCnQn1BpQr8/95zVC4H2yM0bBy6X5XfAoRoKW1P8ipPPJB832q3
         8b3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8MVuBFR2XxKHPkmaoZoMN5oaF3fTaviuOF9+iTNKqE=;
        b=VTHbvKAAN9cltQ6Ucj+ffM7ng2/rVFFRMAGIW9NupX9ixd5X5IT5WieoxhH42yFKeL
         MEZFXbtOsi/UGYA59iJXwhkiBCJ1ELNgjmEbkQj6u0sNsp3f55rk//G+1R8VFFerbjFg
         T7GYhWguI78QCLtnVV/ZG4pbjOUwGYNiiRqWFtIh1IGfMURN/5tKQig0wZrdY81anCkG
         b2PDe4mY6TszNv44bf6MS+2mYnx+GzNJpr8A9+86tGCmFIFUr4r7jwQ0AZkAcI1fkyYy
         othkW5POFJ0SVDcZ2qUEHM0DxwtLC9BKDT16OvLJVcEMJRh4MPnZbR/NTJFrQ0jSHp0x
         +4dg==
X-Gm-Message-State: AOAM533qbwOqHqU9Mx0rFrhV+xAKfZsGCI+A+A3jgoVb1IJgAjSIbjGT
        OKCS4cxJRZtEaSRgEoU+o+0lqc/deLlW3h451aE=
X-Google-Smtp-Source: ABdhPJwmX+lC823QrQoif49Y8Mpt0o8w/u7ttccXa2DuEzeF//Rzd9Duz34FFZHJNqln76XjbbuzVZvZHkfw0tj2hlw=
X-Received: by 2002:a92:d352:: with SMTP id a18mr4565256ilh.9.1619496720807;
 Mon, 26 Apr 2021 21:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210426184201.4177978-1-krisman@collabora.com>
In-Reply-To: <20210426184201.4177978-1-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Apr 2021 07:11:49 +0300
Message-ID: <CAOQ4uxi3yigb2gUjXHJQOVbPHR3RFDeyKc5i0X-k8CSLwurejg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/15] File system wide monitoring
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 9:42 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Hi,
>
> In an attempt to consolidate some of the feedback from the previous
> proposals, I wrote a new attempt to solve the file system error reporting
> problem.  Before I spend more time polishing it, I'd like to hear your
> feedback if I'm going in the wrong direction, in particular with the
> modifications to fsnotify.
>

IMO you are going in the right direction, but you have gone a bit too far ;-)

My understanding of the requirements and my interpretation of the feedback
from filesystem maintainers is that the missing piece in the ecosystem is a
user notification that "something went wrong". The "what went wrong" part
is something that users and admins have long been able to gather from the
kernel log and from filesystem tools (e.g. last error recorded).

I do not see the need to duplicate existing functionality in fsmonitor.
Don't get me wrong, I understand why it would have been nice for fsmonitor
to be able to get all the errors nicely without looking anywhere else, but I
don't think it justifies the extra complexity.

> This RFC follows up on my previous proposals which attempted to leverage
> watch_queue[1] and fsnotify[2] to provide a mechanism for file systems
> to push error notifications to user space.  This proposal starts by, as
> suggested by Darrick, limiting the scope of what I'm trying to do to an
> interface for administrators to monitor the health of a file system,
> instead of a generic inteface for file errors.  Therefore, this doesn't
> solve the problem of writeback errors or the need to watch a specific
> subsystem.
>
> * Format
>
> The feature is implemented on top of fanotify, as a new type of fanotify
> mark, FAN_ERROR, which a file system monitoring tool can register to

You have a terminology mistake throughout your series.
FAN_ERROR is not a type of a mark, it is a type of an event.
A mark describes the watched object (i.e. a filesystem, mount, inode).

> receive notifications.  A notification is split in three parts, and only
> the first is guaranteed to exist for any given error event:
>
>  - FS generic data: A file system agnostic structure that has a generic
>  error code and identifies the filesystem.  Basically, it let's
>  userspace know something happen on a monitored filesystem.

I think an error seq counter per fs would be a nice addition to generic data.
It does not need to be persistent (it could be if filesystem supports it).

>
>  - FS location data: Identifies where in the code the problem
>  happened. (This is important for the use case of analysing frequent
>  error points that we discussed earlier).
>
>  - FS specific data: A detailed error report in a filesystem specific
>  format that details what the error is.  Ideally, a capable monitoring
>  tool can use the information here for error recovery.  For instance,
>  xfs can put the xfs_scrub structures here, ext4 can send its error
>  reports, etc.  An example of usage is done in the ext4 patch of this
>  series.
>
> More details on the information in each record can be found on the
> documentation introduced in patch 15.
>
> * Using fanotify
>
> Using fanotify for this kind of thing is slightly tricky because we want
> to guarantee delivery in some complicated conditions, for instance, the
> file system might want to send an error while holding several locks.
>
> Instead of working around file system constraints at the file system
> level, this proposal tries to make the FAN_ERROR submission safe in
> those contexts.  This is done with a new mode in fsnotify that
> preallocates the memory at group creation to be used for the
> notification submission.
>
> This new mode in fsnotify introduces a ring buffer to queue
> notifications, which eliminates the allocation path in fsnotify.  From
> what I saw, the allocation is the only problem in fsnotify for
> filesystems to submit errors in constrained situations.
>

The ring buffer functionality for fsnotify is interesting and it may be
useful on its own, but IMO, its too big of a hammer for the problem
at hand.

The question that you should be asking yourself is what is the
expected behavior in case of a flood of filesystem corruption errors.
I think it has already been expressed by filesystem maintainers on
one your previous postings, that a flood of filesystem corruption
errors is often noise and the only interesting information is the first error.

For this reason, I think that FS_ERROR could be implemented
by attaching an fsnotify_error_info object to an fsnotify_sb_mark:

struct fsnotify_sb_mark {
        struct fsnotify_mark fsn_mark;
        struct fsnotify_error_info info;
}

Similar to fd sampled errseq, there can be only one error report
per sb-group pair (i.e. fsnotify_sb_mark) and the memory needed to store
the error report can be allocated at the time of setting the filesystem mark.

With this, you will not need the added complexity of the ring buffer
and you will not need to limit FAN_ERROR reporting to a group that
is only listening for FAN_ERROR, which is an unneeded limitation IMO.

Anyway, in case, others do like the ring buffer approach, I do have
some technical comments on the implementation.
I will comment on individual patches.

Thanks,
Amir.

> * Visibility
>
> Since the usecase is limited to a tool for whole file system monitoring,
> errors are associated with the superblock and visible filesystem-wide.
> It is assumed and required that userspace has CAP_SYS_ADMIN.
>
> * Testing
>
> This was tested with corrupted ext4 images in a few scenarios, which
> caused errors to be triggered and monitored with the sample tool
> provided in the next to final patch.
>
> * patches
>
> Patches 1-4 massage fanotify attempt to refactor fanotify a bit for
> the patches to come.  Patch 5 introduce the ring buffer interface to
> fsnotify, while patch 6 enable this support in fanotify.  Patch 7, 8 wire
> the FS_ERROR event type, which will be used by filesystems.  In
> sequennce, patches 9-12 implement the FAN_ERROR record types and create
> the new event.  Patch 13 is an ext4 example implementation supporting
> this feature.  Finally, patches 14 and 15 document and provide examples
> of a userspace tool that uses this feature.
>
> I also pushed the full series to:
>
>   https://gitlab.collabora.com/krisman/linux -b fanotify-notifications
>
> [1] https://lwn.net/Articles/839310/
> [2] https://www.spinics.net/lists/linux-fsdevel/msg187075.html
>
> Gabriel Krisman Bertazi (15):
>   fanotify: Fold event size calculation to its own function
>   fanotify: Split fsid check from other fid mode checks
>   fsnotify: Wire flags field on group allocation
>   fsnotify: Wire up group information on event initialization
>   fsnotify: Support event submission through ring buffer
>   fanotify: Support submission through ring buffer
>   fsnotify: Support FS_ERROR event type
>   fsnotify: Introduce helpers to send error_events
>   fanotify: Introduce generic error record
>   fanotify: Introduce code location record
>   fanotify: Introduce filesystem specific data record
>   fanotify: Introduce the FAN_ERROR mark
>   ext4: Send notifications on error
>   samples: Add fs error monitoring example
>   Documentation: Document the FAN_ERROR framework
>
>  .../admin-guide/filesystem-monitoring.rst     | 103 ++++++
>  Documentation/admin-guide/index.rst           |   1 +
>  fs/ext4/super.c                               |  60 +++-
>  fs/notify/Makefile                            |   2 +-
>  fs/notify/dnotify/dnotify.c                   |   2 +-
>  fs/notify/fanotify/fanotify.c                 | 127 +++++--
>  fs/notify/fanotify/fanotify.h                 |  35 +-
>  fs/notify/fanotify/fanotify_user.c            | 319 ++++++++++++++----
>  fs/notify/fsnotify.c                          |   2 +-
>  fs/notify/group.c                             |  25 +-
>  fs/notify/inotify/inotify_fsnotify.c          |   2 +-
>  fs/notify/inotify/inotify_user.c              |   4 +-
>  fs/notify/notification.c                      |  10 +
>  fs/notify/ring.c                              | 199 +++++++++++
>  include/linux/fanotify.h                      |  12 +-
>  include/linux/fsnotify.h                      |  15 +
>  include/linux/fsnotify_backend.h              |  63 +++-
>  include/uapi/linux/ext4-notify.h              |  17 +
>  include/uapi/linux/fanotify.h                 |  26 ++
>  kernel/audit_fsnotify.c                       |   2 +-
>  kernel/audit_tree.c                           |   2 +-
>  kernel/audit_watch.c                          |   2 +-
>  samples/Kconfig                               |   7 +
>  samples/Makefile                              |   1 +
>  samples/fanotify/Makefile                     |   3 +
>  samples/fanotify/fs-monitor.c                 | 135 ++++++++
>  26 files changed, 1034 insertions(+), 142 deletions(-)
>  create mode 100644 Documentation/admin-guide/filesystem-monitoring.rst
>  create mode 100644 fs/notify/ring.c
>  create mode 100644 include/uapi/linux/ext4-notify.h
>  create mode 100644 samples/fanotify/Makefile
>  create mode 100644 samples/fanotify/fs-monitor.c
>
> --
> 2.31.0
>
