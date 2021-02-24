Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F4332407B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 16:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhBXPHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 10:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbhBXNkO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:40:14 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680FDC06178A;
        Wed, 24 Feb 2021 05:38:11 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id u20so1982852iot.9;
        Wed, 24 Feb 2021 05:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7M8385ZroMAt+TxqtCzcJ3xPlrQMFGUWLZeb98E0ZKM=;
        b=OUOodPMUoznVpoSbKU3sWb9F2jalcce7znKehtmou0nCmp3esxBPCM257JUqBya9aX
         R9B+A+MJa+TFxb4Mt57L26Grrn7WRoqVWRJ1ZWQuhyEdasdwms/MS6Jy/2uecJPAlJ4p
         Y1pEh/3TMJWg1ABKrSml0vCNMlcgVNNEMfuy4wgG+1zwCNPQKiMGJ1EPHm7vn/GxPR9W
         +825RiaBJdLAqzmlAOAS/QV7x/HEm3xjJrEkmGecEJNsf7X+x49DNs8WKL5OO6gIZs/h
         Z982q5UsWwCPR0dVtj5seYVvX4BTFRbgm5a9Artt50Vct4IZ3kbwZY1JLIQhxhniMhJI
         kgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7M8385ZroMAt+TxqtCzcJ3xPlrQMFGUWLZeb98E0ZKM=;
        b=O+5Xg5bppRdfEHGWwdYK8hIsCt2HwfH5Cxi8k8wU38OmsfnD0lhXzm9GDXFrC9M7pV
         xcm1OoR9A1JrVQBkYG0D6u63E92rlQOwBIUZ+zhykuMiWEOZX3UkXEYut47gb/FZ7U0v
         UAK2bCDwVLCYXf8i/kJ4ychhUuMU27Fm/AhR0T6lExPAk0AH4bm8blVWzH+qFrLYflsA
         8u5dkkmkPAizUndY6vNrtgQ9kOiw95/t50VwBr82vR19waDvkRiIh5AKLiFhNhPXiI2L
         K/p5A3muDGGOOnAncxn0r/7PnLvNYfStcLAVTeMe5Ktu5Bk4iKMRW02xqrUVDZvOp3PL
         QSuQ==
X-Gm-Message-State: AOAM53162VKgUG282b4rK1nsLa7DQJjsQqnr+E2fBuDAjMRslXGYl/Hw
        rF/j038AjBM/fde4RytWv0c7vZUdk0WpAUyj5ERwNkwayY4=
X-Google-Smtp-Source: ABdhPJwAxKl0q6A7y2fr2MvebFflkny7A5OeK5WklxBMdH5ypqismVJjstWjMw88RfOBXYW+iiPHD5s6tFjRR4Lqv7U=
X-Received: by 2002:a5d:8d03:: with SMTP id p3mr10290073ioj.64.1614173890745;
 Wed, 24 Feb 2021 05:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20210124184204.899729-1-amir73il@gmail.com> <20210124184204.899729-3-amir73il@gmail.com>
 <20210216170154.GG21108@quack2.suse.cz> <CAOQ4uxhwZG=aC+ZpB90Gn_5aNmQrwsJUnniWVhFXoq454vuyHA@mail.gmail.com>
 <CAOQ4uxhnrZu0phZniiBEqPJJZwWfs3UbCJt0atkHirdHQVCWgw@mail.gmail.com>
 <CAOQ4uxgS5G2ajTfUWUPB5DsjjP0ji-Vu_9RjEzLJGfkNFz0P4w@mail.gmail.com>
 <20210224105204.GC20583@quack2.suse.cz> <CAOQ4uxjCB14RxJTSUfcfn39+N0BUN8LO_QmkpLT7S1-Ssm3DFg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjCB14RxJTSUfcfn39+N0BUN8LO_QmkpLT7S1-Ssm3DFg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Feb 2021 15:37:59 +0200
Message-ID: <CAOQ4uxgGAG8NVcjteJG5iXPGBS5hnEx+cazvjm4VDxNhwFDgjQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] fanotify: support limited functionality for
 unprivileged users
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 24, 2021 at 2:58 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Feb 24, 2021 at 12:52 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 23-02-21 19:16:40, Amir Goldstein wrote:
> > > On Fri, Feb 19, 2021 at 6:16 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > On Tue, Feb 16, 2021 at 8:12 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > On Tue, Feb 16, 2021 at 7:01 PM Jan Kara <jack@suse.cz> wrote:
> > > > > >
> > > > > > On Sun 24-01-21 20:42:04, Amir Goldstein wrote:
> > > > > > > Add limited support for unprivileged fanotify event listener.
> > > > > > > An unprivileged event listener does not get an open file descriptor in
> > > > > > > the event nor the process pid of another process.  An unprivileged event
> > > > > > > listener cannot request permission events, cannot set mount/filesystem
> > > > > > > marks and cannot request unlimited queue/marks.
> > > > > > >
> > > > > > > This enables the limited functionality similar to inotify when watching a
> > > > > > > set of files and directories for OPEN/ACCESS/MODIFY/CLOSE events, without
> > > > > > > requiring SYS_CAP_ADMIN privileges.
> > > > > > >
> > > > > > > The FAN_REPORT_DFID_NAME init flag, provide a method for an unprivileged
> > > > > > > event listener watching a set of directories (with FAN_EVENT_ON_CHILD)
> > > > > > > to monitor all changes inside those directories.
> > > > > > >
> > > > > > > This typically requires that the listener keeps a map of watched directory
> > > > > > > fid to dirfd (O_PATH), where fid is obtained with name_to_handle_at()
> > > > > > > before starting to watch for changes.
> > > > > > >
> > > > > > > When getting an event, the reported fid of the parent should be resolved
> > > > > > > to dirfd and fstatsat(2) with dirfd and name should be used to query the
> > > > > > > state of the filesystem entry.
> > > > > > >
> > > > > > > Note that even though events do not report the event creator pid,
> > > > > > > fanotify does not merge similar events on the same object that were
> > > > > > > generated by different processes. This is aligned with exiting behavior
> > > > > > > when generating processes are outside of the listener pidns (which
> > > > > > > results in reporting 0 pid to listener).
> > > > > > >
> > > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > >
> > > > > > The patch looks mostly good to me. Just two questions:
> > > > > >
> > > > > > a) Remind me please, why did we decide pid isn't safe to report to
> > > > > > unpriviledged listeners?
> > > > >
> > > > > Just because the information that process X modified file Y is not an
> > > > > information that user can generally obtain without extra capabilities(?)
> > > > > I can add a flag FAN_REPORT_OWN_PID to make that behavior
> > > > > explicit and then we can relax reporting pids later.
> > > > >
> > > >
> > > > FYI a patch for flag FAN_REPORT_SELF_PID is pushed to branch
> > > > fanotify_unpriv.
> > > >
> > > > The UAPI feels a bit awkward with this flag, but that is the easiest way
> > > > to start without worrying about disclosing pids.
> > > >
> > > > I guess we can require that unprivileged listener has pid 1 in its own
> > > > pid ns. The outcome is similar to FAN_REPORT_SELF_PID, except
> > > > it can also get pids of its children which is probably fine.
> > > >
> > >
> > > Jan,
> > >
> > > WRT your comment in github:
> > > "So maybe we can just require that this flag is already set by userspace
> > > instead of silently setting it? Like:
> > >
> > > if (!(flags & FAN_REPORT_SELF_PID)) return -EPERM;
> > >
> > > I'd say that variant is more futureproof and the difference for user
> > > is minimal."
> > >
> > > I started with this approach and then I wrote the tests and imagined
> > > the man page
> > > requiring this flag would be a bit awkward, so I changed it to auto-enable.
> > >
> > > I am not strongly against the more implicit flag requirement, but in
> > > favor of the
> > > auto-enable approach I would like to argue that with current fanotify you CAN
> > > get zero pid in event, so think about it this way:
> > > If a listener is started in (or moved into) its own pid ns, it will
> > > get zero pid in all
> > > events (other than those generated by itself and its own children).
> > >
> > > With the proposed change, the same applies also if the listener is started
> > > without CAP_SYS_ADMIN.
> > >
> > > As a matter of fact, we do not need the flag at all, we can determine whether
> > > or not to report pid according to capabilities of the event reader at
> > > event read time.
> > > And we can check for one of:
> > > - CAP_SYS_ADMIN
> > > - CAP_SYS_PACCT
> > > - CAP_SYS_PTRACE
> > >
> > > Do you prefer this flag-less approach?
> >
> > Well, I don't have strong opinion what we should do internally either. The
> > flag seems OK to me. The biggest question is whether we should expose the
> > FAN_REPORT_SELF_PID flag to userspace or not. If we would not require
> > explicit flag for unpriv users, I see little reason to expose that flag at
> > all.
> >
>
> IMO the only listeners that actually care about event->pid are permission
> event listeners. I think that FAN_CLASS_NOTIF listeners do not care
> about it. The only thing that *I* ever used event->pid for is to ignore events
> from self pid.
>
> My question is, do you mind if we start with this code:
>
> @@ -419,6 +419,14 @@ static ssize_t copy_event_to_user(struct
> fsnotify_group *group,
>         metadata.reserved = 0;
>         metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
>         metadata.pid = pid_vnr(event->pid);
> +
> +        /*
> +         * For an unprivileged listener, event->pid can be used to identify the
> +         * events generated by the listener process itself, without disclosing
> +         * the pids of other processes.
> +         */
> +        if (!capable(CAP_SYS_ADMIN) &&
> +            task_tgid(current) != event->pid)
> +                metadata.pid = 0;
>
> No need for any visible or invisible user flags.
> If users ask for event->pid of other processes later (I don't think they will)
> and we decide that it is safe to disclose them, we will require another flag
> and then the test will become:
>
> +        if (!capable(CAP_SYS_ADMIN) ||
> +            FAN_GROUP_FLAG(group, FAN_REPORT_PID))

This condition came out wrong...

>
> and *if* that ever happens, we will document the FAN_REPORT_PID
> flag and say that it is enabled by default for CAP_SYS_ADMIN instead of
> requiring and documenting FAN_REPORT_SELF_PID now.
>
> The way I see it, the only disadvantage with this negated approach is
> that CAP_SYS_ADMIN listeners cannot turn off event->pid reporting,
> but why would anybody need to do that?
>

Anyway, I pushed an example with FAN_REPORT_PID to branch
fanotify_unpriv. It just defines a flag that indicates the existing behavior,
auto enables for CAP_SYS_ADMIN and denied for !CAP_SYS_ADMIN.

Because it is a purely semantic flag at this point, the patch that defines
the flag can be dropped now and maybe added later.

Option for future use - the reaper process (pid 1) of pid ns will be
allowed to request FAN_REPORT_PID without any other capabilities.

Thanks,
Amir.

P.S. fixes to your review comments on fanotify_merge also pushed.
