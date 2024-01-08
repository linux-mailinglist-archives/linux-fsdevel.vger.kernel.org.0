Return-Path: <linux-fsdevel+bounces-7536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC9A826D70
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 13:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB6C1F22A2C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2233FE58;
	Mon,  8 Jan 2024 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QTEdAIQS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA59D3FE3B
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 19BE13F743
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704715786;
	bh=yjLTFK2sGtmurAPD8/W4cvxOFMossApesuVxAUEmm2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=QTEdAIQSL1mt2x0tN/Q0tdLz+Yn5qcesXPkBBLIc2jVw4a9Arse/gPzk++8+pdyrM
	 Z2gQj3RYAJW+XkTwRYhcdkNYk3X/Lu6AfBzYV8l4bvXpd3QZZHQSQciepR6J9q27XU
	 cRRVFsByk8nQKHMd94zpmiH805Bg3KUGG4HWhXQU0lJBrtka3rTPp7FyCm0SMmeL9F
	 agrhP00AdsQ4Fm7r7TMpYd4OJnHSaz5Q6rd/EJYPOnIVGLo6EOpW/SeXfEojhulaLs
	 HWIa8DlWQDf/Fqhlv3GJkfl4jPTMVT1nZPts4USHhBz5fPi1vhJOXRATlpnM4qOfQK
	 qLV8g+MUEz+vQ==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50e8b929997so868873e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jan 2024 04:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704715785; x=1705320585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjLTFK2sGtmurAPD8/W4cvxOFMossApesuVxAUEmm2k=;
        b=lYDt3IBB5bgSPZaSdzG34qqpiTByydJQpfRHXeomLyi/90MdG+rKIRwbGuv+quBT3N
         69AMJUrj2d6Gpvu6pOP54jnaKs/E5ya8FXs7tMOru/kctyIVBLjhl6B1YN0jH3AOcVMO
         BOIg0hkkyoYIesRFeS4SAzfL4qMwaB0wQOUOxmvz2lMpnM2msErlo0wfN0q3meNQh69F
         S+i2AExOairXA6+/W0+xvNDAbWswOAWBJPAYYjWkjXpkrfSliF5lwXGVhwhXCa0NEg9P
         DDCydVWcmvWYMx4bzuyLfkfy+ZvlOJPpceay3c5MJy7AsbVqCwUt5dJdrQhcf3uu3sRi
         K48A==
X-Gm-Message-State: AOJu0Yyn1EO6n+kbvPuTWMr4Oko4yQX7d4Iw0mP5HywJ9ydHRJKgo3O4
	SEObixC9bBz/HdXOOtnmiAwFofOmujEf5O5KS1lXee6NqIzTQc3JvmzntSUkOZoxTeSyX1weQvl
	g0ZDVJZoCgZgCHAI0nV6IVCthwxnvIXgMy4kvTxIc9vj1UMOvPIedc6oBtLMJ
X-Received: by 2002:a05:6512:3e06:b0:50e:3877:caba with SMTP id i6-20020a0565123e0600b0050e3877cabamr825000lfv.52.1704715784695;
        Mon, 08 Jan 2024 04:09:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzM/cYYItv0JtfgT1XOe4lNR1W31/3y8UdFYNPmH2Xh6DdxS5UGo9jy3nzvsAMsCjaNTeyYg==
X-Received: by 2002:a05:6512:3e06:b0:50e:3877:caba with SMTP id i6-20020a0565123e0600b0050e3877cabamr824991lfv.52.1704715784320;
        Mon, 08 Jan 2024 04:09:44 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id fi21-20020a056402551500b005578b816f20sm1767959edb.29.2024.01.08.04.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:09:43 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/9] fuse: basic support for idmapped mounts
Date: Mon,  8 Jan 2024 13:08:15 +0100
Message-Id: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear friends,

This patch series aimed to provide support for idmapped mounts
for fuse. We already have idmapped mounts support for almost all
widely-used filesystems:
* local (ext4, btrfs, xfs, fat, vfat, ntfs3, squashfs, f2fs, erofs, ZFS (out-of-tree))
* network (ceph)

Git tree (based on https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/log/?h=for-next):
v1: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v1
current: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts

Having fuse supported looks like a good next step. At the same time
fuse conceptually close to the network filesystems and supporting it is
a quite challenging task.

Let me briefly explain what was done in this series and which obstacles we have.

With this series, you can use idmapped mounts with fuse if the following
conditions are met:
1. The filesystem daemon declares idmap support (new FUSE_INIT response feature
flags FUSE_OWNER_UID_GID_EXT and FUSE_ALLOW_IDMAP)
2. The filesystem superblock was mounted with the "default_permissions" parameter
3. The filesystem fuse daemon does not perform any UID/GID-based checks internally
and fully trusts the kernel to do that (yes, it's almost the same as 2.)

I have prepared a bunch of real-world examples of the user space modifications
that can be done to use this extension:
- libfuse support
https://github.com/mihalicyn/libfuse/commits/idmap_support
- fuse-overlayfs support:
https://github.com/mihalicyn/fuse-overlayfs/commits/idmap_support
- cephfs-fuse conversion example
https://github.com/mihalicyn/ceph/commits/fuse_idmap
- glusterfs conversion example (there is a conceptual issue)
https://github.com/mihalicyn/glusterfs/commits/fuse_idmap

The glusterfs is a bit problematic, unfortunately, because even if the glusterfs
superblock was mounted with the "default_permissions" parameter (1 and 2 conditions
are satisfied), it fails to satisfy the 3rd condition. The glusterfs fuse daemon sends
caller UIDs/GIDs over the wire and all the permission checks are done twice (first
on the client side (in the fuse kernel module) and second on the glusterfs server side).
Just for demonstration's sake, I found a hacky (but working) solution for glusterfs
that disables these server-side permission checks (see [1]). This allows you to play
with the filesystem and idmapped mounts and it works just fine.

The problem described above is the main problem that we can meet when
working on idmapped mounts support for network-based filesystems (or network-like filesystems
like fuse). When people look at the idmapped mounts feature at first they tend to think
that idmaps are for faking caller UIDs/GIDs, but that's not the case. There was a big
discussion about this in the "ceph: support idmapped mounts" patch series [2], [3].
The brief outcome from this discussion is that we don't want and don't have to fool
filesystem code and map a caller's UID/GID everywhere, but only in VFS i_op's
which are provided with a "struct mnt_idmap *idmap"). For example ->lookup()
callback is not provided with it and that's on purpose! We don't expect the low-level
filesystem code to do any permissions checks inside this callback because everything
was already checked on the higher level (see may_lookup() helper). For local filesystems
this assumption works like a charm, but for network-based, unfortunately, not.
For example, the cephfs kernel client *always* send called UID/GID with *any* request
(->lookup included!) and then *may* (depending on the MDS configuration) perform any
permissions checks on the server side based on these values, which obviously leads
to issues/inconsistencies if VFS idmaps are involved.

Fuse filesystem very-very close to cephfs example, because we have req->in.h.uid/req->in.h.gid
and these values are present in all fuse requests and userspace may use them as it wants.

All of the above explains why we have a "default_permissions" requirement. If filesystem
does not use it, then permission checks will be widespread across all the i_op's like
->lookup, ->unlink, ->readlink instead of being consolidated in the one place (->permission callback).

In this series, my approach is the same as in cephfs [4], [5]. Don't touch req->in.h.uid/req->in.h.gid values
at all (because we can't properly idmap them as we don't have "struct mnt_idmap *idmap" everywhere),
instead, provide the userspace with a new optional (FUSE_OWNER_UID_GID_EXT) UID/GID suitable
only for ->mknod, ->mkdir, ->symlink, ->atomic_open and these values have to be used as the
owner UID and GID for newly created inodes.

Things to discuss:
- we enable idmapped mounts support only if "default_permissions" mode is enabled,
because otherwise, we would need to deal with UID/GID mappings on the userspace side OR
provide the userspace with idmapped req->in.h.uid/req->in.h.gid values which is not
something that we probably want to do. Idmapped mounts philosophy is not about faking
caller uid/gid.

- We have a small offlist discussion with Christian about adding fs_type->allow_idmap
hook. Christian pointed out that it would be nice to have a superblock flag instead like
SB_I_NOIDMAP and we can set this flag during mount time if we see that the filesystem does not
support idmappings. But, unfortunately, I didn't succeed here because the kernel will
know if the filesystem supports idmapping or not after FUSE_INIT request, but FUSE_INIT request
is being sent at the end of the mounting process, so the mount and superblock will exist and
visible by the userspace in that time. It seems like setting SB_I_NOIDMAP flag, in this
case, is too late as a user may do the trick by creating an idmapped mount while it wasn't
restricted by SB_I_NOIDMAP. Alternatively, we can introduce a "positive" version SB_I_ALLOWIDMAP
and a "weak" version of FS_ALLOW_IDMAP like FS_MAY_ALLOW_IDMAP. So if FS_MAY_ALLOW_IDMAP is set,
then SB_I_ALLOWIDMAP has to be set on the superblock to allow the creation of an idmapped mount.
But that's a matter of our discussion.

How to play with it:
1. take any patched filesystem from the list (fuse-overlayfs, cephfs-fuse, glusterfs) and mount it
2. ./mount-idmapped --map-mount b:1000:0:2 /mnt/my_fuse_mount /mnt/my_fuse_mount_idmapped
(maps UID/GIDs as 1000 -> 0, 1001 -> 1)
[ taken from https://raw.githubusercontent.com/brauner/mount-idmapped/master/mount-idmapped.c ]

[1] https://github.com/mihalicyn/glusterfs/commit/ab3ec2c7cbe22618cba9cc94a52a492b1904d0b2
[2] https://lore.kernel.org/lkml/20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com/
[3] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrhA3RKM=ZOYLg@mail.gmail.com/
[4] https://github.com/ceph/ceph/pull/52575
[5] https://lore.kernel.org/all/20230807132626.182101-4-aleksandr.mikhalitsyn@canonical.com/

Thanks!
Alex

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Alexander Mikhalitsyn (9):
  fs/namespace: introduce fs_type->allow_idmap hook
  fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
  fs/fuse: support idmap for mkdir/mknod/symlink/create
  fs/fuse: support idmapped getattr inode op
  fs/fuse: support idmapped ->permission inode op
  fs/fuse: support idmapped ->setattr op
  fs/fuse: drop idmap argument from __fuse_get_acl
  fs/fuse: support idmapped ->set_acl
  fs/fuse: allow idmapped mounts

 fs/fuse/acl.c             |  10 ++-
 fs/fuse/dir.c             | 143 +++++++++++++++++++++++++-------------
 fs/fuse/file.c            |   2 +-
 fs/fuse/fuse_i.h          |  10 ++-
 fs/fuse/inode.c           |  24 ++++++-
 fs/namespace.c            |   3 +-
 include/linux/fs.h        |   1 +
 include/uapi/linux/fuse.h |  24 ++++++-
 8 files changed, 153 insertions(+), 64 deletions(-)

-- 
2.34.1


