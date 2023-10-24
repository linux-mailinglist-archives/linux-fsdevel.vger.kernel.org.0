Return-Path: <linux-fsdevel+bounces-1113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C30077D5984
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 19:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C612B21073
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 17:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842803A290;
	Tue, 24 Oct 2023 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUwq3TU0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF613588B
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 17:12:34 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE86129;
	Tue, 24 Oct 2023 10:12:32 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77784edc2edso292355285a.1;
        Tue, 24 Oct 2023 10:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698167552; x=1698772352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0APWsN9sAkS47gK58kM+OT6Zez1NqQFELwGD0pR6lhY=;
        b=bUwq3TU0SS3UnH/imwup379EfXrD+G67Y3/4sLZEJVBrA6NV5Ai/isGtBMc4GY667Y
         bTDJu9klfgF007MFRMm4RB6loNjz9UwXAC20QLQEsddP8hO/3V6oEympeHkcMFruV47r
         NATeydlvT93kBOTz5yM8GXh9H2dtwUzDvPhMwC7jsWIwbpizecaKJpKLqV6kaYOcjWzq
         eAxIJ+ddf+f0DXeun3IATj4VuBDRfki3Yp7hg5i2IUV7QFyyAWJpu0P9jK9j6+tBqcah
         u/znxa/Tj362RDyroywXNXjJNbLGWvek4btha0B3PsK/XO6kjzK8dWKrzyfz5A5Ne9GU
         aLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698167552; x=1698772352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0APWsN9sAkS47gK58kM+OT6Zez1NqQFELwGD0pR6lhY=;
        b=U6uYOaKxHPt1qVTsHl1tWDxZBEZf01YkkuD4y3JdRhHz4efsZbjsuwTSCqoKYUn29B
         dOtX1OuviIFRoTSlUIJmuJCD9I7DJa7GvzsqxawRZexRrWFx/HQMtgPOhg5UcFqq6DMj
         obtxI6zdtH0EAMtzQYkF4F3ScNrx/EGI/p9Yv5E/rVLBZg312h7mUxouxxRDSiHWZFmJ
         7KUiWF9N2AQLJv3A1WYMCz1g/YgcJQ8M+sYA0R+m8rtyFu0QsZ60M9Rrn0+8RKH5V4t+
         4pxVqXFt0Ww9uJW/Q3CSfupZ3MVI5VQ4LJ9ZVqVKBceuThQiJzYmVOpYzuDkQV2QCTjm
         phjQ==
X-Gm-Message-State: AOJu0YyL3lDhITs59UOKrH6+RBJEU742Ad5BVPOk9Bau0p4iGx4iFyr6
	5hbuBXNpn0+xXFHCQtefjpMM4Tn20bMTkGtULe0=
X-Google-Smtp-Source: AGHT+IHWpT0cXScMuorbJL6/7AyuCzj6Atd8wVIC/dTA/Wd8jG1ZNaY8YBuDB/lGDjNkA4d7X38K0XoiKWglBveRMCg=
X-Received: by 2002:a05:6214:ca6:b0:649:8f20:5528 with SMTP id
 s6-20020a0562140ca600b006498f205528mr17988802qvs.60.1698167551591; Tue, 24
 Oct 2023 10:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024110109.3007794-1-amir73il@gmail.com> <1CFE0178-CE91-4C99-B43E-33EF78D0BEBF@redhat.com>
 <CAOQ4uxhe5pH3yRxFS_8pvtCgbXspKB6r9aacRJ8FysGQE2Hu9g@mail.gmail.com> <2382DA9B-D66B-41D9-8413-1C5319C01165@redhat.com>
In-Reply-To: <2382DA9B-D66B-41D9-8413-1C5319C01165@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Oct 2023 20:12:19 +0300
Message-ID: <CAOQ4uxho0ryGuq7G+LaoTvqHRR_kg2fCNL2sGMLvNujODA8YPQ@mail.gmail.com>
Subject: Re: [PATCH] nfs: derive f_fsid from server's fsid
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 6:32=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 24 Oct 2023, at 10:58, Amir Goldstein wrote:
>
> > On Tue, Oct 24, 2023 at 5:01=E2=80=AFPM Benjamin Coddington <bcodding@r=
edhat.com> wrote:
> >>
> >> On 24 Oct 2023, at 7:01, Amir Goldstein wrote:
> >>
> >>> Fold the server's 128bit fsid to report f_fsid in statfs(2).
> >>> This is similar to how uuid is folded for f_fsid of ext2/ext4/zonefs.
> >>>
> >>> This allows nfs client to be monitored by fanotify filesystem watch
> >>> for local client access if nfs supports re-export.
> >>>
> >>> For example, with inotify-tools 4.23.8.0, the following command can b=
e
> >>> used to watch local client access over entire nfs filesystem:
> >>>
> >>>   fsnotifywatch --filesystem /mnt/nfs
> >>>
> >>> Note that fanotify filesystem watch does not report remote changes on
> >>> server.  It provides the same notifications as inotify, but it watche=
s
> >>> over the entire filesystem and reports file handle of objects and fsi=
d
> >>> with events.
> >>
> >> I think this will run into trouble where an NFSv4 will report both
> >> fsid.major and fsid.minor as zero for the special root filesystem.   W=
e can
> >> expect an NFSv4 client to have one of these per server.
> >>
> >> Could use s_dev from nfs_server for a unique major/minor for each moun=
t on
> >> the client, but these values won't be stable against a particular serv=
er
> >> export.
> >>
> >
> > That's a good point.
> > Not sure I understand the relation between mount/server/export.
> >
> > If the client mounts the special NFSv4 root filesystem at /mnt/nfs,
> > are the rest of the server exports going to be accessible via the same
> > mount/sb or via new auto mounts of different nfs sb?
>
> If we cross into a new filesystem on the server, then the client will als=
o
> cross and leave the "root" and have a new sb with non-zero fsid.
>
> > In any case, f_fsid does not have to be uniform across all inodes
> > of the same sb. This is the case with btrfs, where the the btrfs sb
> > has inodes from the root volume and from sub-volumes.
> > inodes from btrfs sub-volumes have a different f_fsid than inodes
> > in the root btrfs volume.
>
> This isn't what I'm worried about.  I'm worried about the case where an n=
fs
> client will have multiple mounts with fsid's of 0:0, and those are
> distinctly different mounts of the "root" of NFSv4 on different servers.
>

fanotify_mark() fails with -ENODEV when trying to watch an sb with
zero f_fsid. This is the current state with nfs, so there is no concern
for a problem - it just means that fanotify will not be able to watch
those mounts. It's not great.

> > We try to detect this case in fanotify, which currently does not
> > support watching btrfs sub-volume for that reason.
> > I have a WIP branch [1] for handling non-uniform f_fsid in
> > fanotify by introducing the s_op->get_fsid(inode) method.
> >
> > Anyway, IIUC, my proposed f_fsid change is going to be fine for
> > NFSv2/3 and best effort for NFSv4:
> > - For NFSv2/3 mount, f_fsid is a good identifier?
>
> Yes, it should represent the same filesystem on the server.  You could st=
ill
> get duplicates between servers. What's returned in the protocol's u64 fsi=
d
> goes into major with minor always zero.
>
> I'm sure there was discussion about what implementations should use long
> ago, but that predates me.
>

Yeh, duplicates aren't great when watching two different sb with same
f_fsid, it is not possible to know which sb the events came from.
However, the process setting the sb watches can know that in advance.

> > - For NFSv4 mount of a specific export, f_fsid is a good identifier?
>
> Yes, but if the specific export is on the same server's filesystem as the
> "root", you'll still get zero.  There are various ways to set fsid on
> exports for linux servers, but the fsid will be the same for all exports =
of
> the same filesystem on the server.
>

OK. good to know. I thought zero fsid was only for the root itself.

> > - For the NFSv4 root export mount, f_fsid remains zero as it is now
>
> Yes.
>
> > Am I understanding this correctly?
>
> I think so.
>
> > Do you see a reason not to make this change?
> > Do you see a reason to limit this change for NFSv2/3?
>
> I'm not familiar with fanotify enough to know if having multiple fsid 0
> mounts of different filesystems on different servers will do the right
> thing.  I wanted to point out that very real possibility for v4.
>

The fact that fsid 0 would be very common for many nfs mounts
makes this patch much less attractive.

Because we only get events for local client changes, we do not
have to tie the fsid with the server's fsid, we could just use a local
volatile fsid, as we do in other non-blockdev fs (tmpfs, kernfs).

I am not decisive about the best way to tackle this and since
Jan was not sure about the value of local-only notifications
for network filesystems, I am going to put this one on hold.

Thanks for the useful feedback!
Amir.

