Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A94634A164
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 07:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhCZGEg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 02:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhCZGES (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:04:18 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B069EC0613AA;
        Thu, 25 Mar 2021 23:04:17 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z136so4279331iof.10;
        Thu, 25 Mar 2021 23:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mqj1pZGdQGCb79YTlJ4rUJ4Qk8Pv92ztE/LqTAF5fZg=;
        b=ZAktI1CiEuZK+fylIwxZkZSGkp7P2An7HuKcU+Q1ehRceZCrpOYi9uK/PKQQpi4gsU
         /tCzFrD1WzhM63s9CbiDJP7k8xJ+cnh77QEfSKa5noRnPYBHciKxX2pcudXKMYWiqXvn
         bCJCQDWnyREMzBwfuO3+3vDeRm+TVmHAkSIeQlffESF1VfVo+BpaZkWg10H7A2Ry9WRH
         m/hgejq+V9rPLyANGqoJ1Qd6ls1yCDMJhmISFDGyvj5JsDfRkDze6dQxkKnhW1NkRIcA
         hO07uQ0fmHbJcJZpO5CDiIrstGy/YwNmXC1vQ7ZHOQSr9essdd4X3yNEasbIP2QO1VSX
         ChZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mqj1pZGdQGCb79YTlJ4rUJ4Qk8Pv92ztE/LqTAF5fZg=;
        b=l3GdSgI6EZpi21r9773i2WTDIrJYf8fKfAsyCC30ZOebIkWbXWMIYnr4hzj9LuRksO
         SfqbY7HeU6seIYzKyudhpubbiIZvkukwtQlyI2DDlVAx/jhSKCWCsTfcUdsYf7yoGL7J
         PSBy0f6aIxuS/Nd6UHiqsWTKIiSeDeM1DaE9ywcBPIC9EezECa+RtRnwACGnVwz4Kmmn
         rBGIFy+4MNggZyphhZ46NiEu+ikjza4baAVtrvbtCxR8SAzSKohWgffmqa+QUkZQ+LxA
         KD5tU2K0TgOGtFdpa5QimuaF+ZuzqgYvHcbXAyx6e0FrUsAMKrDWrmdX2k9PACxs7u8H
         ypVQ==
X-Gm-Message-State: AOAM5334ECQSmp5mkukQ2Rj6ifm7j8dGqoU5UMOqMakTI8gbLunPfuGO
        gD5jtuEdeWUvVskS1O3Syp0LmtBJPWfdxOt1HKE=
X-Google-Smtp-Source: ABdhPJwLqJje2qI1WKIvRg/wkacBGI583wQXbaTsdXSrq8OUfZmZHJ+UUmdjn/rr7LvGwtz45u//tEErPzjNtkTzqOk=
X-Received: by 2002:a05:6638:1388:: with SMTP id w8mr4712850jad.30.1616738657030;
 Thu, 25 Mar 2021 23:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210322171118.446536-1-amir73il@gmail.com> <20210322230352.GW63242@dread.disaster.area>
 <CAOQ4uxjFMPNgR-aCqZt3FD90XtBVFZncdgNc4RdOCbsxukkyYQ@mail.gmail.com>
 <20210323072607.GF63242@dread.disaster.area> <CAOQ4uxgAddAfGkA7LMTPoBmrwVXbvHfnN8SWsW_WXm=LPVmc7Q@mail.gmail.com>
 <20210324005421.GK63242@dread.disaster.area> <CAOQ4uxhhMVQ4XE8DMU1EjaXBo-go3_pFX3CCWn=7GuUXcMW=PA@mail.gmail.com>
 <20210325225305.GM63242@dread.disaster.area>
In-Reply-To: <20210325225305.GM63242@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 26 Mar 2021 09:04:05 +0300
Message-ID: <CAOQ4uxgAxUORpUJezg+oWKXEafn0o33+bP5EN+VKnoQA_KurOg@mail.gmail.com>
Subject: Re: [PATCH] xfs: use a unique and persistent value for f_fsid
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> How do you check the identity of a file handle without a filesystem
> identifier in it? having an external f_fsid isn't really sufficient
> - you need to query the filesytem for it's identifier and determine
> if the file handle contains that same identifier...
>
> > Furthermore, with name_to_handle_at(fd, ..., AT_EMPTY_PATH)
> > and fstatfs() there are none of the races you mention below and
> > fanotify obviously captures a valid {fsid,fhandle} tuple.
>
> Except that fsid is not guaranteed to be the same across mounts, let
> alone reboots. There is no guarantee of uniqueness, either. IOWs, in
> the bigger picture, f_fsid isn't something that can provide a
> guaranteed answer to your "is $obj the same as it was at $TIME"...
>
> You can't even infer a path from the fsid, even if it is unique, The
> fsid doesn't tell you what *mount point* it refers to. i.e in
> the present of bind mounts, there can be multiple disjoint directory
> heirachies that correspond to the same fsid...
>

This conversation is not converging.
Partly because I may have failed to explain the requirements.

I am telling you that I need to do X and you are telling me that I cannot
do Y. I did not say that I needed to infer that path of an object nor that
I cared which mount point the object was observed from.

The application is able to cope with not being able to correctly resolve
fid to path, but it is "incoventiet". The technical term to translate
"inconvenient" is the "cost" of IO and time to recrawl the filesystem.

I hear your main arguments against re-purposing f_fsid and potential
breakage of applications loud and clear.

On their own, they are perfectly valid and acceptable reasons to NACK
my patch, so I am not going to pursue it.

OTOH, I find your argument to leave f_fsid "less useful than it can be"
because "it is not perfect", far less convincing, but it doesn't look like
I am going to change your mind, so no point in arguing about that.

[...]
> > If the listener has several objects open (e.g. tail -f A B C) then when getting
> > an event, the identifier can be used to match the open file with certainty
> > (having verified no collisions of identifiers after opening the files).
>
> Sorry, you've lost me. How on do you reliably match a {fsid, fhandle}
> to an open file descriptor? You've got to have more information
> available than just a fd, fsid and a fhandle...
>

This was just an example of the simple case where the listener is started
after opening the files and capturing the {fsid, fhandle} tuple from fd.
The events received by the listener contain {fsid, fhandle} tuples that
should match one of the captures fids.
For this example, the stable fsid is irrelevant.

> > If the listener is watching multiple directories (e.g. inotifywatch --recursive)
> > then the listener has two options:
> > 1. Keep open fds for all watches dirs - this is what inotify_add_watch()
> >     does internally (not fds per-se but keeping an elevated i_count)
> > 2. Keep fid->path map for all watches dirs and accept the fact that the
> >     cached path information may be stale
> >
> > The 2nd option is valid for applications that use the events as hints
> > to take action. An indexer application, for example, doesn't care if
> > it will scan a directory where there were no changes as long as it will
> > get the correct hint eventually.
> >
> > So if an indexer application were to act on FAN_MOVE events by
> > scanning the entire subtree under the parent dir where an entry was
> > renamed, the index will be eventually consistent, regardless of all
> > the events on objects with stale path cache that may have been
> > received after the rename.
>
> Sure, but you don't need a file handle for this. you can just scan
> the directory heirachy any time you get a notification for that
> fsid. Even if you have multiple directory heirarchies that you
> are watching on a given mount.
>
> I'm -guessing- that you are using the filehandle to differentiate
> between different watched heirarchies, and you do that by taking a
> name_to_handle_at() snapshot of the path when the watch is set, yes?
>

More or less, yes.

> AFAICT, the application cannot  care about whether it loses
> events across reboot because the indexer already needs to scan after
> boot to so that it is coherent with whatever state the filesystem is
> in after recovery.
>

That is absolutely right.

But a listener can watch several mounted filesystems on a live system
and mounts can come and go (this is standard for e.g. an AV scanner).
When a filesystem is mounted, the application cannot KNOW that
filesystem was not mounted somewhere else and modified without
supervision, so the safest thing would be a full crawl.

But users should be able to configure that they trust that the filesystem
was not mounted elsewhere and that they trust that the listener has
subscribed to watch for changes, before untrusted users got access
to make modifications in the watches filesystem.

Under those specific circumstances, it is "inconvenient" and potentially
very expensive for the identity of the filesystem to change across
mount cycle (e.g. when using loop mount). That said, a good application
can use libblkid to overcome the "inconvenience" and detect fsid changes.

The argument of "many other filesystem have unstable fsid" is not
relevant. The users making all the assumptions above would know
what filesystem is used and if they know that filesystem's fsid can be
trusted to be stable, because they read the code and/or documentation
they can use that knowledge to improve their system.

[...]

> > That is one option. Let's call it the "bullet proof" option.
>
> "Reliable". "Provides well defined behaviour". "Guarantees".
>

Yes, and also "Application is able to do the right thing without
admin configuration".

> > Another option, let's call it the "pragmatic" options, is that you accept
> > that my patch shouldn't break anything and agree to apply it.
>
> "shouldn't break anything" is the problem. You can assert all you
> want that nothing will break, but history tells us that even the
> most benign UAPI changes can break unexpected stuff in unexpected
> ways.
>

No arguments here. My only claim was that risk is not high.

> That's the fundamental problem. We *know* that what you are trying
> to do with filehandles and fsid has -explicit, well known- issues.
> What we have here is a new interface that
> is .... problematic, and now it needs to redefine other parts
> of the UAPI to make "problems" with the new interface go away.
>
> Yes, we really suck at APIs, but that doesn't mean hacking a UAPI
> around to work around problems in another UAPI is the right answer.
>

All very very true.

And yet, those very true words masquerade the fact that the change
that I proposed, IMO, slightly improves an existing UAPI and aligns
xfs behavior with the behavior of other "prominent" Linux local filesytems.

It's really a matter of perspective how we choose to present it.

> > In that case, a future indexer (or whatever) application author can use
> > fanotify, name_to_handle_at() and fstats() as is and document that after
> > mount cycle, the indexer may get confused and miss changes in obscure
> > filesystems that nobody uses on desktops and servers.
>
> But anyone wanting to use this for a HSM style application that
> needs a guarantee that the filehandle can be resolved to the correct
> filesystem for open_by_handle_at() is SOL?
>
> IOWs, this proposal is not really fixing the underlying problem,
> it's just kicking the can down the road.
>

It's not a kick, it's just a nudge ;-)

And I am not abandoning the HSM users. It's just a much bigger project
that also involves persistent change intent journal.

> > The third option, let's call it the "sad" option, is that we do nothing
> > and said future indexer application author will need to find ways to
> > work around this deficiency or document that after mount cycle, the
> > indexer may get confused and miss changes in commonly used
> > desktop and server filesystems (i.e. XFS).
>
> Which it already needs to do, because there are many, many
> filesysetms out there that have f_fsid that change on every mount.
>

Not any of the filesystems that matter to desktop/server users.
IOW, no other filesystem that comes as the default fs of any
major distro.

> > <side bar>
> > I think that what indexer author would really want is not "persistent fsid"
> > but rather a "persistent change journal" [1].
> > I have not abandoned this effort and I have a POC [2] for a new fsnotify
> > backend (not fanotify) based on inputs that also you provided in LSFMM.
> > In this POC, which is temporarily reusing the code of overlayfs index,
> > the persistent identifier of an object is {s_uuid,fhandle}.
> > </side bar>
>
> Yup, that's pretty much what HSMs on top of DMAPI did. But then the
> app developers realised that they can still miss events, especially
> when the system crashes. Not to mention that the filesystem may not
> actually replay all the changes it reports to userspace during
> journal recovery because it is using asynchronous journalling and so
> much of the pending in memory change was lost, even though change
> events were reported to userspace....
>

Right...

> Hence doing stuff like "fanotify intents" doesn't actually solve any
> "missing event" problems - it just creates more complex coherency
> problems because you cannot co-ordinate "intent done" events with
> filesystem journal completion points sanely. The fanotify journal
> needs to change state atomically with the filesystem journal state,
> and that's not really something that can be done by a layer above
> the filesystem....
>

Surely, a filesystem can do it more efficiently internally, but perhaps
the generic intent journal subsystem can be done...?

My POC is a kernel subsystem (not fanotify)
Intents are created in {mnt_want,{sb,file}_start}_write() call sites
*before* fs freeze lock.

When configured correctly, the backend store of the "modify intent"
map is on the same filesystems that is being watched for changes
and the ONLY information contained in the "modify intents" is the
{uuid,fhandle} tuple of directories wherein modifications may have
occurred.

The "modify intent" records themselves are also metadata (directory
entries), so after a crash, if there is no "modify intent" record for any
given directory, it should be safe to assume that there were no
modifications made under that directory.

This assertion should hold also with crashes that "rollback" changes.

My POC application uses that "map"/"index" of modified directories
to perform a "pruned tree scan" after reboot.

Do you see any flaws in this design?

> Hence the introduction of the bulkstat interface in XFS for fast,
> efficient scanning of all the inodes in the filesystem for changes.
> The HSMs -always- scanned the filesystems after an unclean mount
> (i.e. not having a registered unmount event recorded in the
> userspace application event database) because the filesystem and the
> userspace database state are never in sync after a crash event.
>
> And, well, because userspace applications can crash and/or have bugs
> that lose events, these HSMs would also do periodic scans to
> determine if it had missed anything. When you are indexing hundreds
> of millions of files and many petabytes of storage across disk and
> tape (this was the typical scale of DMAPI installations in the mid
> 2000s), you care about proactively catching that one event that was
> missed because of a transient memory allocation event under heavy
> production load....
>

Yes, I know all about that.
The game is trying to reduce the number of cases when fs scan is
needed and reduce the cost of the scan to minimum.

I'll be happy to share more information about my POC if anyone
asks and/or in LSFMM when/if that eventually happens.

w.r.t $SUBJECT, if nobody else shares my POV that this MAY be
a beneficial and bening change that is worth doing regardless of
fanotify, I am not going to argue for it more.

Thanks,
Amir.
