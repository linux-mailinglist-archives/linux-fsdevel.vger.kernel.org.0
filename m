Return-Path: <linux-fsdevel+bounces-1183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2DA7D6E7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 16:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80423281A22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 14:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A47728E29;
	Wed, 25 Oct 2023 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNS1eddq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2B627710
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 14:12:07 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A7619D;
	Wed, 25 Oct 2023 07:12:01 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d0ceba445so32116876d6.0;
        Wed, 25 Oct 2023 07:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698243121; x=1698847921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tKVdix5RJvAI2e7Uan+fxbsu4C97jUxO2pzvhonFzY0=;
        b=CNS1eddqb09hcy1uhUf2Ojts+RIgLDq6IcmgR6OAKxEsjVep2Qq7bWGc7UbkQ7zPj2
         f4c97FMU438jHeKGWLTKmOEzcmTVKaBJFKCV00Fobym3LMhK3uo1DFErKJ5kHtC+f8TK
         P37ZLnlCFIVRBXYxlv1jliKDQdAA7lAA3T3KDStUMpolo68kDhp/DEH5YsV6NI9LWCF5
         JRWEK91jyIjr57dDO5koa7K4xNniD4HTXB2FW/4fvJQL9RePGjdt7WFRqkGyzq6Dwbif
         FMzMQqb4cQ2TDHvNUWhCkHPvFv156PrQjfeQkFSrIqzERtYSAghYcUpHv3XKm8FPy2GK
         iBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698243121; x=1698847921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKVdix5RJvAI2e7Uan+fxbsu4C97jUxO2pzvhonFzY0=;
        b=V9nmMnS4LJPUrGV3CYECA9/Y+JxDkHQXf9MfXWyWW+vlYfuKlNg9VduF7SCLQHlaW4
         pJ2BgEXajIC3/RxsxcTGV2+oPN5A+Tc37j5CuDsm/p3zASrnI3daj2t7VW/l3yotOzBw
         XfnZtGShCWdpOylFhW1RWh3NgwdbMNGnZ3bgdFUf+Amz51u/TS77F1zXE1rS0XmpmIiP
         Vcc/7CeaaiuVnoB+87ZnjfXuJi74uDr2oz0MzGxsCaFunDHHrFHKL+rOpqdbijdBqORS
         8O4MlJemtPg8Z3CRIGHmexsYo1leI1jtHbPUtJSiMAxXInQgCgfmQTDHDm7xKgI1RS5F
         wskg==
X-Gm-Message-State: AOJu0Yzt6eRY4K5Ya/FM5RYrDbd9bvpEsnLfo/8wDS+rHWwMxfN0sSKx
	hgO0DL3JCEzS1yQJn3UZ88ATsJR+yjfP4+Xo6dE4DHbybxo=
X-Google-Smtp-Source: AGHT+IEYmiXrH9anAkYWc5nR1PVbmJGPx+I6s1L7XIvhFdEERBEuSUp/hRq1VdhSVnhFrfQhMOY3YEFbbstolz52YUE=
X-Received: by 2002:ad4:5beb:0:b0:65b:3133:cec with SMTP id
 k11-20020ad45beb000000b0065b31330cecmr17192353qvc.32.1698243120426; Wed, 25
 Oct 2023 07:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230411124037.1629654-1-amir73il@gmail.com> <20230412184359.grx7qyujnb63h4oy@quack3>
 <CAOQ4uxj_OQt+yLVnBH-Cg4mKe4_19L42bcsQx2BSOxR7E46SDQ@mail.gmail.com>
 <20230417162721.ouzs33oh6mb7vtft@quack3> <CAOQ4uxjfP+TrDded+Zps6k6GQM+UsEuW0R2PT_fMEH8ouY_aUg@mail.gmail.com>
 <20230920110429.f4wkfuls73pd55pv@quack3>
In-Reply-To: <20230920110429.f4wkfuls73pd55pv@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Oct 2023 17:11:48 +0300
Message-ID: <CAOQ4uxh_wNOoWjxw2qQPyxoqyvo-u8pFGHH9p92BzrqBACVJTA@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: Enable FAN_REPORT_FID on more filesystem types
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"

> > Hi Jan,
> >
> > I seem to have dropped the ball on this after implementing AT_HANDLE_FID.
> > It was step one in a larger plan.
>
> No problem, I forgot about this as well :)
>

Following up...

> > Christian, Jeff,
> >
> > Do you have an objection to this plan:
> > 1. Convert all "legacy" FILEID_INO32_GEN fs with non-empty
> >     s_export_op and no explicit ->encode_fh() to use an explicit
> >     generic_encode_ino32_gen_fh()
> > 2. Relax requirement of non-empty s_export_op for AT_HANDLE_FID
> >     to support encoding a (non-NFS) file id on all fs
> > 3. For fs with empty s_export_op, allow fallback of AT_HANDLE_FID
> >     in exportfs_encode_inode_fh() to encode FILEID_INO64_GEN
> >

These are now queued on Christian's vfs.f_fsid branch.

> >
> > > > > Also I have noticed your workaround with using st_dev for fsid. As I've
> > > > > checked, there are actually very few filesystems that don't set fsid these
> > > > > days. So maybe we could just get away with still refusing to report on
> > > > > filesystems without fsid and possibly fixup filesystems which don't set
> > > > > fsid yet and are used enough so that users complain?
> > > >
> > > > I started going down this path to close the gap with inotify.
> > > > inotify is capable of watching all fs including pseudo fs, so I would
> > > > like to have this feature parity.
> > >
> > > Well, but with pseudo filesystems (similarly as with FUSE) the notification
> > > was always unreliable. As in: some cases worked but others did not. I'm not
> > > sure that is something we should try to replicate :)
> > >
> > > So still I'd be interested to know which filesystems we are exactly
> > > interested to support and whether we are not better off to explicitly add
> > > fsid support to them like we did for tmpfs.
> > >
> >
> > Since this email, kernfs derivative fs gained fsid as well.
> > Quoting your audit of remaining fs from another thread:
> >
> > > ...As far as I remember
> > > fanotify should be now able to handle anything that provides f_fsid in its
> > > statfs(2) call. And as I'm checking filesystems not setting fsid currently are:
> > >
> > > afs, coda, nfs - networking filesystems where inotify and fanotify have
> > >   dubious value anyway
> >
> > Be that as it may, there may be users that use inotify on network fs
> > and it even makes a lot of sense in controlled environments with
> > single NFS client per NFS export (e.g. home dirs), so I think we will
> > need to support those fs as well.
>
> Fair enough.

I have sent an fsid patch for NFS and for FUSE.
I am not going to deal with afs and coda unless there is explicit demand.

>
> > Maybe the wise thing to do is to opt-in to monitor those fs after all?
> > Maybe with explicit opt-in to watch a single fs, fanotify group will
> > limit itself to marks on a specific sb and then a null fsid won't matter?
>
> We have virtual filesystems with all sorts of missing or weird notification
> functionality and we don't flag that in any way. So making a special flag
> for network filesystems seems a bit arbitrary. I'd just make them provide
> fsid and be done with it.
>
> > > configfs, debugfs, devpts, efivarfs, hugetlbfs, openpromfs, proc, pstore,
> > > ramfs, sysfs, tracefs - virtual filesystems where fsnotify functionality is
> > >   quite limited. But some special cases could be useful. Adding fsid support
> > >   is the same amount of trouble as for kernfs - a few LOC. In fact, we
> > >   could perhaps add a fstype flag to indicate that this is a filesystem
> > >   without persistent identification and so uuid should be autogenerated on
> > >   mount (likely in alloc_super()) and f_fsid generated from sb->s_uuid.
> > >   This way we could handle all these filesystems with trivial amount of
> > >   effort.
> > >

Patch for simple fs fsid also queued on Christian's vfs.f_fsid branch.

> >
> > Christian,
> >
> > I recall that you may have had reservations on initializing s_uuid
> > and f_fsid in vfs code?
> > Does an opt-in fstype flag address your concerns?
> > Will you be ok with doing the tmpfs/kernfs trick for every fs
> > that opted-in with fstype flag in generic vfs code?
> >
> > > freevxfs - the only real filesystem without f_fsid. Trivial to handle one
> > >   way or the other.
> > >

fsid patch was posted for freevxfs.
fsid patch for gfs2 was posted and applied by the maintainer.

> >
> > Last but not least, btrfs subvolumes.
> > They do have an fsid, but it is different from the sb fsid,
> > so we disallow (even inode) fanotify marks.
> >
> > I am not sure how to solve this one,
> > but if we choose to implement the opt-in fanotify flag for
> > "watch single fs", we can make this problem go away, along
> > with the problem of network fs fsid and other odd fs that we
> > do not want to have to deal with.
> >
> > On top of everything, it is a fast solution and it doesn't
> > involve vfs and changing any fs at all.
>
> Yeah, right, forgot about this one. Thanks for reminding me. But this is
> mostly a kernel internal implementation issue and doesn't seem to be a
> principial problem so I'd prefer not to complicate the uAPI for this. We
> could for example mandate a special super_operation for fetching fsid for a
> dentry for filesystems which don't have uniform fsids over the whole
> filesystem (i.e., btrfs) and call this when generating event for such
> filesystems. Or am I missing some other complication?
>

No complication AFAICS.
btrfs fsid patches posted for review.

Thanks,
Amir.

