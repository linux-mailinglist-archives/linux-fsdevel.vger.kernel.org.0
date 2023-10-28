Return-Path: <linux-fsdevel+bounces-1474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAD67DA53C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 07:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8BB11C211D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 05:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9204A1843;
	Sat, 28 Oct 2023 05:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8WZsm0h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9C15AE
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 05:58:12 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D679F4;
	Fri, 27 Oct 2023 22:58:11 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66d17bdabe1so20098016d6.0;
        Fri, 27 Oct 2023 22:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698472690; x=1699077490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjTwrioir8WFW7COHyDA877fAwE7yENyR2g5CC/R29s=;
        b=c8WZsm0h7QqSp2V0XIN4e4j/vsqDYt5XVxwX8yFcDrR9s8sE8/ILbZCVfzUkEeBVXs
         iflL6LHOiy49tz/j0z+UMYqyScZ5jnpDncTpb1cOBWENCOXGh6gBwHcBz0lFTj2N5glX
         wkvLJFL2ny4OyfQ27VpU52YbMFlSaNsn2/RSuDL/I7E8xM1FnQRXrfnPrN9jNml1N/Gj
         1GUJIkRx7JEwh9UNkfpDlqU/cnX5UDCJpKDpW9HMbZsenwqFJqMLg5TtkKeEebIpD5JV
         zlP85KboyKgFdptYVIw/BE3YtOy1mYrWiCYzZ3ZuWSWo8Coxj/z+9zJnBK4SLSudoeVs
         FnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698472690; x=1699077490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjTwrioir8WFW7COHyDA877fAwE7yENyR2g5CC/R29s=;
        b=HU7Rs1Oairtsa2I1GKSIdQOk3bzLyRyg3oaoOnDhsOXZCnw90MmYnZQLU0L1cbJrDI
         8f4ZF+l4TzXNb1CNZfd5uDePRkQHnP3CMKS1DZsTHMX74MP+0ev5Uqu9cLaGpYh68fb6
         8fFF4XVhwbXJX5A9z+F/iDOMKGitw/qe9Ca6VJPaufsS2O0vxJ6T/PeFUsQbfD4wyyyR
         xnthiHeq95WCAfnyPThMxsHLzUXMEY721y/Ist0qL6n9O+fpDwakkS+lcuLv1hYsT/YD
         JrUaBLt355sDcNmA8WJ/M6ItjQICitbOrQRXoBrMJcok2D7Nj4rhytKezH4ys+s9YHGz
         ADuw==
X-Gm-Message-State: AOJu0YzLAdcTVOyBGVT/ymQddkhWsEOzRblQysJy9xHBOTbqYIUJyZp6
	/OHEYGtg7xPzcn2KI4GmESszXWDXamFeBQ9vQWI=
X-Google-Smtp-Source: AGHT+IEKDi+fY3mo4BvumxnYPFjzIbe2k3AlbtL/enjUTmmSdxatDVw5uFn6IU9hRacwnb6OBDjswNLiiqkMiDAEWEc=
X-Received: by 2002:ad4:5943:0:b0:65d:475a:a2f6 with SMTP id
 eo3-20020ad45943000000b0065d475aa2f6mr5404126qvb.40.1698472690552; Fri, 27
 Oct 2023 22:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025135048.36153-1-amir73il@gmail.com> <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting> <ZTtOmWEx5neNKkez@infradead.org> <20231027131726.GA2915471@perftesting>
In-Reply-To: <20231027131726.GA2915471@perftesting>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 28 Oct 2023 08:57:58 +0300
Message-ID: <CAOQ4uxjaA=pm_zoE1rG2zZRUeUnKw=rU5AQ2A7uSrRXWeDgVww@mail.gmail.com>
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 4:17=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Thu, Oct 26, 2023 at 10:46:01PM -0700, Christoph Hellwig wrote:
> > I think you're missing the point.  A bunch of statx fields might be
> > useful, but they are not solving the problem.  What you need is
> > a separate vfsmount per subvolume so that userspace sees when it
> > is crossing into it.  We probably can't force this onto existing
> > users, so it needs a mount, or even better on-disk option but without
> > that we're not getting anywhere.
> >
>
> We have this same discussion every time, and every time you stop respondi=
ng
> after I point out the problems with it.
>
> A per-subvolume vfsmount means that /proc/mounts /proc/$PID/mountinfo bec=
omes
> insanely dumb.  I've got millions of machines in this fleet with thousand=
s of
> subvolumes.  One of our workloads fires up several containers per task an=
d runs
> multiple tasks per machine, so on the order of 10-20k subvolumes.
>

I think it is probably just as common to see similar workloads using overla=
yfs
for containers, especially considering the fact that the more you
scale the number
of containers, the more you need the inode page cache sharing between them.

Overlayfs has sb/vfsmount per instance, so any users having problems with
huge number of mounts would have already complained about it and maybe
they have because...

> So now I've got thousands of entries in /proc/mounts, and literally every=
 system
> related tool parses /proc/mounts every 4 nanoseconds, now I'm significant=
ly
> contributing to global warming from the massive amount of CPU usage that =
is
> burned parsing this stupid file.
>

...after Miklos sorts out the new list/statmount() syscalls and mount
tree change
notifications, maybe vfsmount per btrfs subvol could be reconsidered? ;)

> Additionally, now you're ending up with potentially sensitive information=
 being
> leaked through /proc/mounts that you didn't expect to be leaked before.  =
I've
> got users complaining to be me because "/home/john/twilight_fanfic" showe=
d up in
> their /proc/mounts.
>

This makes me wonder.
I understand why using diverse st_dev is needed for btrfs snapshots
where the same st_ino can have different revisions.
I am not sure I understand why diverse st_dev is needed for subvols
that are created for containerisation reasons.
Don't files in sub-vols have unique st_ino anyway?
Is the st_dev mitigation for sub-vol a must or just an implementation
convenience?

> And then there's the expiry thing.  Now they're just directories, reclaim=
 works
> like it works for anything else.  With auto mounts they have to expire at=
 some
> point, which makes them so much more heavier weight than we want to sign =
up for.
> Who knows what sort of scalability issues we'll run into.
>

I agree that this aspect of auto mount is unfortunate, but I think it would
benefit other fs that support auto mount to improve reclaiming of auto moun=
ts.

In the end, I think that we all understand that the legacy btrfs behavior
is not going away without an opt-in, but I think it would be a good outcome
if users could choose the tradeoff between efficiency of single mount vs.
working well with features like nfs export and fanotify subvol watch.

Having an incentive to migrate to the "multi-sb" btrfs mode, would create
the pressure from end users on distros and from there to project leaders
to fix the issues that you mentioned related to huse number of mounts
and auto mount reclaim.

Thanks,
Amir.

