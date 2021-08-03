Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B912B3DE65B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 07:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhHCFwS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 01:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhHCFwS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 01:52:18 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAF9C06175F;
        Mon,  2 Aug 2021 22:52:06 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r6so14739402ioj.8;
        Mon, 02 Aug 2021 22:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zsYFKRZRErviQ4N1s5eJX9CA3PoNkhv3tFG7eNDOLMM=;
        b=MAfkpPNBBSb98PkivwAb3x0iwflQFjrr8uUlF8jIadwZYGcXruGOPpjaohuNRH+PKz
         CgYd7Kci65cF5HO719LvHGg0uTIhNn2/8PoecphEAN+xTKNBbJ6yGq/nioSiK0/3Snbw
         N/gFwbS0RuC0EeLWEVwkOJc1Ir70rQqsZiRRiu8UnAvITvPl4INa1t3twmC3ojHBUuwy
         7FXLeyYzJWvRaH4iP6j1/TqhIXuXAbEWkN62gmDw+HbsIgCSPlDwWi29dD+8zplQB+dy
         I8pTkqKA/cjs01M7E//fgrmacgPrby90k8HEoMCqOcZTeyVuK02Vm2m5ljl0Zj2CtQBw
         yc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zsYFKRZRErviQ4N1s5eJX9CA3PoNkhv3tFG7eNDOLMM=;
        b=VVvUI4dRVwIbNF2awRtAuy5xQTTDRMRAo0R1Lu/CpXqsxSB5vTI7PLFhxa2fAPGB/h
         7KEHk0ROSsmU+V0G4B7Mp19ryGkY1clPbX02u1vSHB5mYukC38/NcZprCMkia853QIWJ
         5b5TPibcW2nnaXz8m35zEePd2hq4aYE6jr1FINVStYPEmfN96hPSCPM62kIZh+/VHgFV
         LoJ2P/W5T8iJia3W466+RKp7z+rBKhA+4PHyzdXUR3IeEPjCLACa7LMDwAoLbJqF6cB1
         nk8n+kFbXx8Z9Wj9iU8eZWyk6+6TwRc8eaJAX41zItR5D3lqHI2aCqZmrKripvw1nRod
         O+RA==
X-Gm-Message-State: AOAM532yE/uGzGaxbbb8HK6/DxMkQMvj9Hi4vzlXNP7rp6ZLZmiHBqTe
        z+gcpmlkMkEh6fXQ3d3GAnudKaTDde4W7JHWG48=
X-Google-Smtp-Source: ABdhPJxOJHQjhob/TwiYzayliufOag8Eepg9kX8h6MRjFqFGjv7JSIiljcAWEhU4Gf0mm1njsFJ7Ji1QrxFMak/6TsM=
X-Received: by 2002:a5e:9901:: with SMTP id t1mr642007ioj.5.1627969926189;
 Mon, 02 Aug 2021 22:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626845287.git.repnop@google.com> <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
 <CAG48ez3MsFPn6TsJz75hvikgyxG5YGyT2gdoFwZuvKut4Xms1g@mail.gmail.com>
 <CAOQ4uxhDkAmqkxT668sGD8gHcssGTeJ3o6kzzz3=0geJvfAjdg@mail.gmail.com>
 <20210729133953.GL29619@quack2.suse.cz> <CAOQ4uxi70KXGwpcBnRiyPXZCjFQfifaWaYVSDK2chaaZSyXXhQ@mail.gmail.com>
 <CAOQ4uxgFLqO5_vPTb5hkfO1Fb27H-h0TqHsB6owZxrZw4YLoEA@mail.gmail.com>
 <20210802123428.GB28745@quack2.suse.cz> <CAOQ4uxhk-vTOFvpuh81A2V5H0nfAJW6y3qBi9TgnZxAkRDSeKQ@mail.gmail.com>
 <20210802201002.GF28745@quack2.suse.cz> <YQicE1erp5ZecrZ3@google.com>
In-Reply-To: <YQicE1erp5ZecrZ3@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 3 Aug 2021 08:51:54 +0300
Message-ID: <CAOQ4uxiNPmuXii+SOzi=oxvJc+QGFQ8zV_LKzOvRxO-UUHex0g@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 3, 2021 at 4:30 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Mon, Aug 02, 2021 at 10:10:02PM +0200, Jan Kara wrote:
> > On Mon 02-08-21 17:38:20, Amir Goldstein wrote:
> > > On Mon, Aug 2, 2021 at 3:34 PM Jan Kara <jack@suse.cz> wrote:
> > > > On Fri 30-07-21 08:03:01, Amir Goldstein wrote:
> > > > > On Thu, Jul 29, 2021 at 6:13 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > > On Thu, Jul 29, 2021 at 4:39 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > > Well, but pidfd also makes sure that /proc/<pid>/ keeps belonging to the
> > > > > > > same process while you read various data from it. And you cannot achieve
> > > > > > > that with pid+generation thing you've suggested. Plus the additional
> > > > > > > concept and its complexity is non-trivial So I tend to agree with
> > > > > > > Christian that we really want to return pidfd.
> > > > > > >
> > > > > > > Given returning pidfd is CAP_SYS_ADMIN priviledged operation I'm undecided
> > > > > > > whether it is worth the trouble to come up with some other mechanism how to
> > > > > > > return pidfd with the event. We could return some cookie which could be
> > > > > > > then (by some ioctl or so) either transformed into real pidfd or released
> > > > > > > (so that we can release pid handle in the kernel) but it looks ugly and
> > > > > > > complicates things for everybody without bringing significant security
> > > > > > > improvement (we already can pass fd with the event). So I'm pondering
> > > > > > > whether there's some other way how we could make the interface safer - e.g.
> > > > > > > so that the process receiving the event (not the one creating the group)
> > > > > > > would also need to opt in for getting fds created in its file table.
> > > > > > >
> > > > > > > But so far nothing bright has come to my mind. :-|
> > > > > > >
> > > > > >
> > > > > > There is a way, it is not bright, but it is pretty simple -
> > > > > > store an optional pid in group->fanotify_data.fd_reader.
> > > > > >
> > > > > > With flag FAN_REPORT_PIDFD, both pidfd and event->fd reporting
> > > > > > will be disabled to any process other than fd_reader.
> > > > > > Without FAN_REPORT_PIDFD, event->fd reporting will be disabled
> > > > > > if fd_reaader is set to a process other than the reader.
> > > > > >
> > > > > > A process can call ioctl START_FD_READER to set fd_reader to itself.
> > > > > > With FAN_REPORT_PIDFD, if reaader_fd is NULL and the reader
> > > > > > process has CAP_SYS_ADMIN, read() sets fd_reader to itself.
> > > > > >
> > > > > > Permission wise, START_FD_READER is allowed with
> > > > > > CAP_SYS_ADMIN or if fd_reader is not owned by another process.
> > > > > > We may consider YIELD_FD_READER ioctl if needed.
> > > > > >
> > > > > > I think that this is a pretty cheap price for implementation
> > > > > > and maybe acceptable overhead for complicating the API?
> > > > > > Note that without passing fd, there is no need for any ioctl.
> > > > > >
> > > > > > An added security benefit is that the ioctl adds is a way for the
> > > > > > caller of fanotify_init() to make sure that even if the fanotify_fd is
> > > > > > leaked, that event->fd will not be leaked, regardless of flag
> > > > > > FAN_REPORT_PIDFD.
> > > > > >
> > > > > > So the START_FD_READER ioctl feature could be implemented
> > > > > > and documented first.
> > > > > > And then FAN_REPORT_PIDFD could use the feature with a
> > > > > > very minor API difference:
> > > > > > - Without the flag, other processes can read fds by default and
> > > > > >   group initiator can opt-out
> > > > > > - With the flag, other processes cannot read fds by default and
> > > > > >   need to opt-in
> > > > >
> > > > > Or maybe something even simpler... fanotify_init() flag
> > > > > FAN_PRIVATE (or FAN_PROTECTED) that limits event reading
> > > > > to the initiator process (not only fd reading).
> > > > >
> > > > > FAN_REPORT_PIDFD requires FAN_PRIVATE.
> > > > > If we do not know there is a use case for passing fanotify_fd
> > > > > that reports pidfds to another process why implement the ioctl.
> > > > > We can always implement it later if the need arises.
> > > > > If we contemplate this future change, though, maybe the name
> > > > > FAN_PROTECTED is better to start with.
> > > >
> > > > Good ideas. I think we are fine with returning pidfd only to the process
> > > > creating the fanotify group. Later we can add an ioctl which would indicate
> > > > that the process is also prepared to have fds created in its file table.
> > > > But I have still some open questions:
> > > > Do we want threads of the same process to still be able to receive fds?
> > >
> > > I don't see why not.
> > > They will be bloating the same fd table as the thread that called
> > > fanotify_init().
> >
> > I agree. So do we store thread group leader PID in fanotify group? What if
> > thread group leader changes? I guess I have to do some reading as I don't
> > know how all these details work internally.
> >
> > > > Also pids can be recycled so they are probably not completely reliable
> > > > identifiers?
> > >
> > > Not sure I follow. The group hold a refcount on struct pid of the process that
> > > called fanotify_init() - I think that can used to check if reader process is
> > > the same process, but not sure. Maybe there is another way (Christian?).
> >
> > Yes, if we hold refcount on struct pid, it should be safe against recycling.
> > But cannot someone (even unpriviledged process in this case) mount some
> > attack by creating a process which creates fanotify group, passes fanotify fd,
> > and dies but pid would be still blocked because fanotify holds reference to
> > it? I guess this is not practical as the number of fanotify groups is limited
> > as well as number of fds.
> >
> > > > What if someone wants to process events from fanotify group by
> > > > multiple processes / threads (fd can be inherited also through fork(2)...)?
> > >
> > > That's the same as passing fd between processes, no?
> > > If users want to do that, we will need to implement the ioctl or
> > > fanotify_init() flag FAN_SHARED.
> >
> > Well, FAN_SHARED would be the current behavior so I don't think there's any
> > point in that (we'd loose much of the security benefit gained by this
> > excercise). I agree we'd need to implement the ioctl for such usecase
> > but my point was that we could have a relatively sensible setup in which
> > multiple pids may need to read events from fanotify queue and so fanotify
> > group would need to track multiple pids allowed to read from it.
> >
> > I'm sorry if I sound negative at times. I'm not settled on any particular
> > solution.  I'm just trying to brainstorm various pros and cons of possible
> > solutions to settle on what's going to be the best :).
>
> Quite honestly, I'm struggling to understand what problem we're trying to
> solve here... That is, whether this is an actual "security" problem, or
> whether it's just attempting to come up with a solution which conforms to
> the "general" rule of not modifying a callers fdtable upon calling
> functions like read().
>
> Can someone please elaborate a little on the exact "security" implications
> or "threats" we're attempting to alleviate through the implementation of
> the additional aforementioned group initialization flags and ioctls? What
> is the exact scenario we're attempting to avoid which could lead to a
> compromise in the systems overall integrity?
>
> Also, I can understand this as a "general" rule:
>
>   "A process should be able to receive a file descriptor from an untrusted
>    source and call functions like read() on it without worrying about
>    affecting its own file descriptor table state with that."
>
> But, in instances where event processing is offloaded to a separate
> dedicated "reader" process, does that actually fall under receiving a file
> descriptor from an "untrusted" source? I don't think so. Modification of a
> callers fdtable upon calling functions like read() may be considered
> "undesired" in general, but this is just how fanotify has always worked, is
> it not?
>

Yes, but IMO "it has always worked this way" cannot be used as a valid
argument to re-introduce the same bad pattern to a new interface.
If you want to report open pidfd to group without fid_mode go ahead -
it will not be a regression of any form, but I don't think this is what you
are aiming for.

Re-introducing open fds to reader is a regression, because the alleged
attacker does not have control over fanotify group flags, the alleged
attacker has no CAP_SYS_ADMIN, it gets an fanotify_fd somehow
and passes it on to an innocent reader, so the less programs out there
creating "unsafe" fanotify fd's the better.

If there is already a program out there handing out legacy fanotify fd's
there is nothing we can do about it, but we have a way to shape the
future:
Step #1: Provide new safer interface (i.e. FAN_REPORT_FID)
Step #2: Add shiny new features to new interface to "lure" application
              to switch to new interface (i.e. FAN_REPORT_PIDFD)

Don't get me wrong. I think that your doubts about severity of that
fd table bloat are perfectly valid - I am only opposing to using the
excuse that it has always been that way.

But is another argument that may be used to reject the claims:

Passing a fanotify fd irresponsibly to an untrusted process can have
far greater implications than bloating the victim process fd table.
fanotify events expose information about actions and identities of
other processes in the system and in the worst case (permission
events) enables severe DoS attack on the system.

So perhaps we need to address the specific problem of PIDFD
at all and only the more severe potential security aspects.

We could address them using fanotify_init flags FAN_PRIVATE
and FAN_SHARED and a Kconfig+sysfs knob to control the default
for fanotify groups.

A distro could audit all packages that use fanotify and once every
program that needs to use FAN_SHARED uses it explicitly, change
the system default and make the system more prone to future attacks.

Thanks,
Amir.
