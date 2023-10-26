Return-Path: <linux-fsdevel+bounces-1224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CBC7D7C7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 07:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA33281E4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 05:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F70F9FB;
	Thu, 26 Oct 2023 05:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdwvD1Ik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AE5C134
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 05:50:09 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56B2187;
	Wed, 25 Oct 2023 22:50:06 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66cfd3a0e61so3815156d6.1;
        Wed, 25 Oct 2023 22:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698299406; x=1698904206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeRsssLX7dJfUBNeIdDgiKFBegD9PBcBDM3KZdGAZHs=;
        b=OdwvD1IkPzRsRe+G9dtWg0up68eJUi1QTrvJ1ngC9uKTkwfX1ZYhb4be0Qe19ljsSe
         YtuSZ/pCgOBDLktV+WElFW6Kaehbb7KM6ckhT7CGiqpED9gFHZOfETCpAD7s2Tf5eT1N
         EOr+bON/zp2nnwrjlvPxdZ1aZydnIVY5HYN3GxTbUgmp0fGwJM4oho6LnvZ6sRu5dz0x
         wL7IlRtBkgUCbE/uXRa6JBO9StL/s0IoeWYyhea+IjIisb1gbkGIe0o7Q2/xS0admS3b
         6KFDxwnXhIRuf/yzPriiDT76WsyqS6e5Tk6fyx4o+wuqdx5JEVG2Rna9GkBYHquiapgp
         3Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698299406; x=1698904206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeRsssLX7dJfUBNeIdDgiKFBegD9PBcBDM3KZdGAZHs=;
        b=JhN+DWboF6g4KhoeRJjndsAiU3OdG4s0jEoc7A9qtVcmiIK41zuiVpBc3vFm6qlj/P
         //Y063l93GDiWsb2Y/MrIEaquRDzRx+i2tVGk1KRE9mXm7LOSG0qUMEi+YXEsnm1o5X6
         u0ptwhguNUSVVXS8Zi9erj9M3lbFYqTw6lsTGCKZ4nOXdh9QT9TFom7BygJoG7P1VmDJ
         mMI8UsYmMEqgzn5IOnVk9qDQGF3Yr09cWgLE0RlSXPn8eJ1IkVTL0x9KckNkqr4mYDZm
         URabknYesHrEOGRVRAayvfLxs53Uy6q2Deqvq77qhrvuVRjSUquabRmmFJ/lS2Vrpn4o
         g/TQ==
X-Gm-Message-State: AOJu0Yx1vKWGIZb104V7/y4ISHgKclHrJfI8oopm4NYytMMqcDUjgdvB
	yxnGDaZAzZ4rfzSEjOwEGZ56okfo01pXLAtKBjk=
X-Google-Smtp-Source: AGHT+IHHe80VCq7LPJqKZi989+2AwaWMuHLvdMzgUfWkrI/9aLUGbr0FD7Zxinv9IDha+XSDw3NCjy1US9CBynaAqxI=
X-Received: by 2002:ad4:5c4a:0:b0:66d:627e:24c0 with SMTP id
 a10-20020ad45c4a000000b0066d627e24c0mr23492679qva.38.1698299405872; Wed, 25
 Oct 2023 22:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025135048.36153-1-amir73il@gmail.com> <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting> <628a975f-11a1-47f9-b2f8-8cbcfa812ef6@gmx.com>
In-Reply-To: <628a975f-11a1-47f9-b2f8-8cbcfa812ef6@gmx.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Oct 2023 08:49:54 +0300
Message-ID: <CAOQ4uxjbXg5hqk8r1Lp24rdkeimXS2_tZppreAeabzO0k8G8yg@mail.gmail.com>
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 2:02=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> On 2023/10/26 07:36, Josef Bacik wrote:
> > On Wed, Oct 25, 2023 at 08:34:21AM -0700, Christoph Hellwig wrote:
> >> On Wed, Oct 25, 2023 at 04:50:45PM +0300, Amir Goldstein wrote:
> >>> Jan,
> >>>
> >>> This patch set implements your suggestion [1] for handling fanotify
> >>> events for filesystems with non-uniform f_fsid.
> >>
> >> File systems nust never report non-uniform fsids (or st_dev) for that
> >> matter.  btrfs is simply broken here and needs to be fixed.
> >
> > We keep going around and around on this so I'd like to get a set of ste=
ps laid
> > out for us to work towards to resolve this once and for all.
> >
> > HYSTERICAL RAISINS (why we do st_dev)
> > -------------------------------------
> >
> > Chris made this decision forever ago because things like rsync would sc=
rew up
> > with snapshots and end up backing up the same thing over and over again=
.  We saw
> > it was using st_dev (as were a few other standard tools) to distinguish=
 between
> > file systems, so we abused this to make userspace happy.
> >
> > The other nice thing this provided was a solution for the fact that we =
re-use
> > inode numbers in the file system, as they're unique for the subvolume o=
nly.
> >
> > PROBLEMS WE WANT TO SOLVE
> > -------------------------
> >
> > 1) Stop abusing st_dev.  We actually want this as btrfs developers beca=
use it's
> >     kind of annoying to figure out which device is mounted when st_dev =
doesn't
> >     map to any of the devices in /proc/mounts.
> >
> > 2) Give user space a way to tell it's on a subvolume, so it can not be =
confused
> >     by the repeating inode numbers.
> >
> > POSSIBLE SOLUTIONS
> > ------------------
> >
> > 1) A statx field for subvolume id.  The subvolume id's are unique to th=
e file
> >     system, so subvolume id + inode number is unique to the file system=
.  This is
> >     a u64, so is nice and easy to export through statx.
> > 2) A statx field for the uuid/fsid of the file system.  I'd like this b=
ecause
> >     again, being able to easily stat a couple of files and tell they're=
 on the
> >     same file system is a valuable thing.  We have a per-fs uuid that w=
e can
> >     export here.
> > 3) A statx field for the uuid of the subvolume.  Our subvolumes have th=
eir own
> >     unique uuid.  This could be an alternative for the subvolume id opt=
ion, or an
> >     addition.
>
> No need for a full UUID, just a u64 is good enough.
>
> Although a full UUID for the subvolumes won't hurt and can reduce the
> need to call the btrfs specific ioctl just to receive the UUID.
>
>
> My concern is, such new members would not be utilized by any other fs,
> would it cause some compatibility problem?
>
> >
> > Either 1 or 3 are necessary to give userspace a way to tell they've wan=
dered
> > into a different subvolume.  I'd like to have all 3, but I recognize th=
at may be
> > wishful thinking.  2 isn't necessary, but if we're going to go about me=
ssing
> > with statx then I'd like to do it all at once, and I want this for the =
reasons
> > stated above.
> >
> > SEQUENCE OF EVENTS
> > ------------------
> >
> > We do one of the statx changes, that rolls into a real kernel.  We run =
around
> > and submit patches for rsync and anything else we can think of to take =
advantage
> > of the statx feature.
>
> My main concern is, how older programs could handle this? Like programs
> utilizing stat() only, and for whatever reasons they don't bother to add
> statx() support.
> (Can vary from lack of maintenance to weird compatibility reasons)
>
> Thus we still need such st_dev hack, until there is no real world
> programs utilizing vanilla stat() only.
> (Which everyone knows it's impossible)
>

I agree it does not sound possible to change the world to know
that the same st_dev,st_ino pair could belong to different objects.

One such program btw is diff - it will skip the comparison if both
objects have the same st_dev,st_ino even if they are actually
different objects with different data (i.e. a file and its old snapshot).

Thanks,
Amir.

