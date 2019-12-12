Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 296A211C5BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 06:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfLLF5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 00:57:11 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38123 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfLLF5K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 00:57:10 -0500
Received: by mail-yw1-f66.google.com with SMTP id 10so358599ywv.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 21:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zm0qEX92qICAl9nyheKmb5LkPFSgPbn2zB3BBn7Y5LI=;
        b=t+WZfV8KdDGTKCaHlRyZO/6so7thiz6j6oJ7AxRXc3v29Bk8kRLZNzTkt7aF/jWjsH
         t1D/npjMMOrGTPmQCx5J0egHsgZfDcNoRr33+K6HdjsqqtQaZx8PN8sx8OaQt3xumYq3
         yG4sAgNGwDiVOKY2mK/Gw2GduFoyFJ6kXjWyyLmbq792/8ntSL0IEGABqLb+tD9ewbYZ
         YIjO2T2wb9Y+IBxYuMvt9F8Ids72Sch14PzpnasSl0ol9pGVpZAWu5xuo8Yp4WBWuqGu
         PMhlVBnZvNr2okO/zfm6El/hQGqd+c6akbL3KxbDlWxn2UjNfVKbOqGJa849HAwC3foC
         11TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zm0qEX92qICAl9nyheKmb5LkPFSgPbn2zB3BBn7Y5LI=;
        b=cJXzGV+BmJdnktyZ47pXXHLlweLLSdwT0+NcTtM+NufHXCx2ljJT7L6a3l0reRMOHP
         XXWN0Fu1O0Qxew2Dd5OHF1o32NCnDcD2ep6XIdWkyuClPe+Ds4uN3aTw7tS+wGA6aNs8
         aKZkXkKTdaCBr/6TqgZCCR7B6eMyVe0HGV65Ar4qUDb72BI5xCwEWZeISaJV3fLqH/9I
         m3gwAeVhC1BuuQSoOlJXF+AwuJer60nox6cnhHW6X8kxkdVXnkwSaTS/kGrRmzUktTFX
         dKRJgteWQv9qOSVsp/5kwo0zzGnMjjbuoZHiFJhwIFzGx70m0mfN55kUL4udEhHyRn0i
         WONg==
X-Gm-Message-State: APjAAAUWe2PlMh+kC2MKkl27ppgOv7iLC3YJrQEtCsAw57SI4mImPRBV
        E5ZU8rCy23lWk7Pxf6oWlD/H52R2YZw4lgHHQKs=
X-Google-Smtp-Source: APXvYqxeRSOUHrbuA+maSP1+UtS4G5rC5wpMukpeQcAomCo4IPt2umh32zMJbhU1o0wGVf6r8/NHM8XYAbtZb2ZSC0o=
X-Received: by 2002:a81:5488:: with SMTP id i130mr2786793ywb.181.1576130229093;
 Wed, 11 Dec 2019 21:57:09 -0800 (PST)
MIME-Version: 1.0
References: <CADKPpc2RuncyN+ZONkwBqtW7iBb5ep_3yQN7PKe7ASn8DpNvBw@mail.gmail.com>
 <CAOQ4uxiKqEq9ts4fEq_husQJpus29afVBMq8P1tkeQT-58RBFg@mail.gmail.com>
 <CADKPpc33UGcuRB9p64QoF8g88emqNQB=Z03f+OnK4MiCoeVZpg@mail.gmail.com>
 <20191204173455.GJ8206@quack2.suse.cz> <CADKPpc2EU6ijG=2bs6t8tXr32pB1ufBJCjEirPyoHdMtMr83hw@mail.gmail.com>
 <20191210165538.GK1551@quack2.suse.cz> <CAOQ4uximwdf37JdVVfHuM_bxk=X7pz21hnT3thk01oDs_npfhw@mail.gmail.com>
 <8486261f-9cf2-e14e-c425-d9df7ba7b277@fb.com>
In-Reply-To: <8486261f-9cf2-e14e-c425-d9df7ba7b277@fb.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 12 Dec 2019 07:56:57 +0200
Message-ID: <CAOQ4uxgtc1SWtPf90ib41zuNFP4LYB9m7HmW23JU54GPf2WPUw@mail.gmail.com>
Subject: Re: File monitor problem
To:     Wez Furlong <wez@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Mo Re Ra <more7.rev@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 12:06 AM Wez Furlong <wez@fb.com> wrote:
>
> On 12/10/19 12:49, Amir Goldstein wrote:
>
> > [cc: Watchman maintainer]
>
> Hi, I'm the Watchman creator and maintainer, and I also work on a FUSE
> based virtual filesystem called EdenFS that works with the source
> control systems that we use at Facebook.
>

Hi Wez!

Thank you for joining.

> I don't have much context on fanotify yet, but I do have a lot of
> practical experience with Watchman on various operating systems with
> very large recursive directory trees.
>
>
> Amir asked me to participate in this discussion, and I think it's
> probably helpful to give a little bit of context on how we deal with
> some of the different watcher interfaces, and also how we see the
> consumers of Watchman making use of this sort of data.  There are tens
> of watchman consuming applications in common use inside FB, and a long
> tail of ad-hoc consumers that are not on my radar.
>
> I don't want to flood you with data that may not feel relevant so I'm
> going to try to summarize some key points; I'd be happy to elaborate if
> you'd like more context!  These are written out as numbered statements
> to make it easier to reference in further discussion, and are not
> intended to be taken as any kind of prescriptive manifesto!
>

I will try to explain how fanotify may be able to address some of these
points. Many times, new kernel APIs are written years before the actual
users start using them and sometimes when that time comes, the actual
users find that the new API doesn't quite fit their needs. My hope is
that with this early discussion, we will be able to avoid this pattern.

> 1. Humans think in terms of filenames.  Applications largely only care
> about filenames.  It's rare (it came up as a hypothetical for only one
> integrating application at FB in the past several years) that they care
> about optimizing for the various rename cases so long as they get
> notified that the old name is no longer visible in the filesystem and
> that a new name is now visible elsewhere in the portion of the
> filesystem that they are watching.
>

The current plan is to add a new event that notifies on namepsace
changes. At the moment there is no intention to distinguish between
name made visible and name made invisible. That is something that
application can easily figure out with fstatat(2) and avoid rename cookies
etc.

The information in the event will be the parent's fid (NFS file handle)
and name of child.
For a privileged super block watch, parent fid can be resolved to current
directory path (as opposed to path at the time of the change).
For unprivileged directory watches, the parent fid is the key by which
the monitoring app identifies a "watch" (like the inotify wd).

File modifications can now (since kernel 5.1) be reported with the file's
fid (FAN_REPORT_FID). It is a bit more challenging to resolve a
file's fid to its current path, especially by an unprivileged directory
watcher. My plan is to provide a way to report parent fid + name
also for file modifications.

It that doesn't sound right, please shout.

If you are asking yourself, what do I gain from replacing inotify with
unprivileged fanotify, you are not alone.
I cannot sell this as a major functionality improvement over inotify for
unprivileged users.

A minor improvement is that if watchman process can be granted
CAP_DAC_READ_SEARCH, then handling a watched directory rename
on FAN_MOVE_SELF would be less racy and far simpler than the
current rename cookie dance.

The major functionality improvements to end users will have to be
mediated by a privileged service.

Did you ever consider making Watchman a system service?
After all, if several users on the same machine are watching the same
directory tree than spawning multiple watchman processes, each one
indexing the same tree is not as efficient.
I realize that that creates a security issue - no idea how to solve it.

> 2. Application authors don't want to deal with the complexities of file
> watching, they just want to reliably know if/when a named file has
> changed.  Rename cookies and overflow events are too difficult for most
> applications to deal with at all/correctly.
>

...and the fanotify man page gets harder and harder to follow...
I believe that for advanced filesystem monitoring, the kernel provided API
would be better used by expert mediator library/service.

> 3. Overflow events are painful to deal with.  In Watchman we deal with
> inotify overflow by re-crawling and examining the directory structure to
> re-synchronize with the filesystem state.  For very large trees this can
> take a very long time.
>

The new FAN_MARK_FILESYSTEM feature partially solves that.
I wrote a "global watch" demo using inotifywait to show how.
It requires privileged user.

> 4. Partially related to 3., restarting the watchman server is an
> expensive event because we have to re-crawl everything to re-create the
> directory watches with inotify.  If the system provided a recursive
> watch function and some kind of a change journal that told watchman a
> set of N directories to crawl (where N < the M overall number of
> directories) and we had a stable identifier for files, then we could
> persist state across restarts and cheaply re-synchronize.
>

See: https://lwn.net/Articles/755277/
We do that in CTERA using my other project, Overlayfs snapshots:
https://lwn.net/Articles/719772/
An overlay snapshot maintains a persistent "changed subtree" since the
last crawl started.
The current crawler consults the "changed subtree" and skips
unmodified subtrees.
An fanotify super block watch notifies on all changes since this crawl started.

I have long wanted to publish a working demo with git fsmonitor, but
never got to it. This also requires privileged user as well as some other
limitations, so its not a general purpose solution. We can discuss this
solution in another thread.

> 5. Is also related to 3. and 4.  We use btrfs subvolumes in our CI to
> snapshot large repos and make them available to jobs running in
> different containers potentially on different hosts.  If the journal
> mechanism from 4. were available in this situation it would make it
> super cheap to bring up watchman in those environments.
>

I suppose you use btrfs send/recv to transfer the subvolume snapshots.
While those are block level snapshots, I believe btrfs has enough metadata
information to be able to link all changed blocks back to inodes and inodes
back to parent dirs, so in theory, a btrfs tool can be written to compose the
"changed subtree" from a subvolume diff.

> 6. A downside to recursive watches on macOS is that fseventsd has very
> limited ability to add exceptions.  A common pattern at FB is that the
> buck build system maintains a build artifacts directory called
> `buck-out` in the repo.  On Linux we can ignore change notifications for
> this directory with zero cost by simply not registering it with
> inotify.  On macOS, the kernel interface allows for a maximum of 8
> exclusions.  The rest of the changes are delivered to fseventsd which
> stats and records everything in a sqlite database.  This is a
> performance hotspot for us because the number of excluded directories in
> a repo exceeds 8, and the uninteresting bulky build artifact writes then
> need to transit fseventsd and into watchman before we can decide to
> ignore them.
>

fanotify has "ignore masks" that could be used to some extent.
For example, FAN_MARK_FILESYSTEM watch with FAN_CREATE mask
and FAN_MARK_INODE watch on `buck-out` directory with FAN_CREATE
in ignore mask.

> 7. Windows has a journal mechanism that could potentially be used as
> suggested in 4. above, but it requires privileged access.  I happen to
> know from someone at MS that worked on a similar system that there is
> also a way to access a subset of this data that doesn't require
> privileged access, but that isn't documented.  I mention this because
> elsewhere in this thread is a discussion about privileged access to
> similar sounding information.
>

Persistent change journal for Linux is a long term goal of mine.
It will require some support at filesystem level.
I see no reason for the kernel to provide unprivileged access to this sort
of information. IMO, it should be the job of a system service to hand out
filtered information to unprivileged users, according to their credentials.

> 8. Related to 6. and 7., if there is a privileged system daemon to act
> as the interface between userspace<->kernel, care needs to be taken to
> avoid the sort of performance hotspot we see on macOS with 6. above.
>

Some people use FAN_MARK_MOUNT to filter events on file modifications
by path, but that only works for modified files, not for create/delete/rename.
I spent a lot of time trying to figure out an efficient way to filter events
by subtree in the kernel. No success yet.

> OK, hopefully that doesn't feel too off the mark!  I don't think
> everything above needs to be handled directly at the kernel interface.
> Some of these details could be handled on the userspace side, either by
> a daemon (eg: watchman) or a suitably well designed client library
> (although that can make it difficult to consume in some programming
> environments).
>

Thank you Wez for this excellent summary.
Hopefully, I did not overwhelm you with too much information.
I will keep you posted when I have a POC of the new API.

Amir.
