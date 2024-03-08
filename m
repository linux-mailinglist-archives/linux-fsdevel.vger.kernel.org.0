Return-Path: <linux-fsdevel+bounces-13993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C268761C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 11:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B651F212E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 10:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD7A53E1A;
	Fri,  8 Mar 2024 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAnOxogi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06AD5381D;
	Fri,  8 Mar 2024 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893073; cv=none; b=OLLA3KI64phlpJYcYgaMByKaRRoArnv0GSwI7NU8Ncpn1J/k0bIP5JDBvXbYb43dBzPdZUMwBcoSZm5OiNb405ezgfGYM+ltangYHQFx/QzX221wR8+lAB78cya9L652+3rswdgB6aO24rSPje7Zftb9Rr/FSzF25z8Nz7KjN2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893073; c=relaxed/simple;
	bh=/AiXCtOqePehZ6oQmK5vs3o854833GC/H+MSNrC8PN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJZ7/2gsgwnViT8AZK/y0vwNY3bOvtgPYQvaTScn+VrbhvmJCRKoLSp/7HaGzeI6xU6vc3NuOzEGSgUGdOiqe0PmNfAZYgq0VXRHDkREKkvVxWlLLnLKJR5z2lVK8B67hV2b40FiA8vBAErzG+brPna6CuEjY4AAqeTAkt+eLF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAnOxogi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B9CC43399;
	Fri,  8 Mar 2024 10:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709893073;
	bh=/AiXCtOqePehZ6oQmK5vs3o854833GC/H+MSNrC8PN8=;
	h=From:To:Cc:Subject:Date:From;
	b=tAnOxogi0gTRYofmzDxhXMcxT79AMk5aI2IlvaVoMaD+ZY5ez2TQbMWYZ0d0b39+X
	 Y7R0Z3Fs6YSsxlP7KE/yZBppTE2EzS52PVAR1bpLMK3pAtrXzi4yeRko1qkwGi5Vf7
	 ticyYYeZHuRhyYOb65wO8U7vhMvd5FhbuoGw5ZLRXlxCbVDVZigjX2MIwBuSFTIumu
	 qsEyMKi3ZrIiadJrowsqQYiSAALnZw+N9l4A+Odzn1EO9pd7yXgYQluwbFNfUwqI9J
	 UnwgNmZA/4BqpSE4t5SLz6zrLPLGJSEesZdKrMtIP3EDSGpdcOBSwF7f9wdkyoRzzo
	 eAoTKeHVRDIvQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs super
Date: Fri,  8 Mar 2024 11:17:38 +0100
Message-ID: <20240308-vfs-super-ebcd3585c240@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10795; i=brauner@kernel.org; h=from:subject:message-id; bh=/AiXCtOqePehZ6oQmK5vs3o854833GC/H+MSNrC8PN8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS+enrkWNmJRTxb6leqVslqxV9ln35IfuX87oret3LGi 1hvMu5g6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIo2aGv/IL47+lHQ+znVKh lnEoS0phdnFZ541pDssvBPsw3bubJc3wV2CLb+gM01rdDxcbVqpU6X44coV54kObb3U1lzVTOx5 LsQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
Last cycle we changed opening of block devices in [1]. Now opening a
block device would return a bdev_handle. This allowed us to implement
support for restricting and forbidding writes to mounted block devices.
It was accompanied by converting and adding helpers to operate on
bdev_handles instead of plain block devices.

That was already a good step forward but ultimately it isn't necessary
to have special purpose helpers for opening block devices internally
that return a bdev_handle.

Fundamentally, opening a block device internally should just be
equivalent to opening files. So with this pull request all internal
opens of block devices return files just as a userspace open would.
Instead of introducing a separate indirection into bdev_open_by_*() via
struct bdev_handle bdev_file_open_by_*() is made to just return
a struct file. Opening and closing a block device just becomes
equivalent to opening and closing a file.

This all works well because internally we already have a pseudo fs for
block devices and so opening block devices is simple. There's a few
places where we needed to be careful such as during boot when the kernel
is supposed to mount the rootfs directly without init doing it. Here we
need to take care to ensure that we flush out any asynchronous file
close. That's what we already do for opening, unpacking, and closing the
initramfs. So nothing new here.

The equivalence of opening and closing block devices to regular files is
a win in and of itself. But it also has various other advantages. We can
remove struct bdev_handle completely. Various low-level helpers are now
private to the block layer. Other helpers were simply removable
completely.

A follow-up series that is already reviewed build on this and makes it
possible to remove bdev->bd_inode and allows various clean ups of the
buffer head code as well. All places where we stashed a bdev_handle now
just stash a file and use simple accessors to get to the actual block
device which was already the case for bdev_handle.

Link: 3f6984e7301f ("Merge tag 'vfs-6.8.super' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs") [1]

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.8-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

This series has been in -next for a very long time and it held up in
xfstests and in blktests so far.

/* Conflicts */

Merge conflicts with other trees
================================

[1] linux-next: manual merge of the block tree with the vfs-brauner tree
    https://lore.kernel.org/linux-next/20240206124852.6183d0f7@canb.auug.org.au

    Full transparency: I had intended to coordinate this merge with Jens
    to minimize the conflict but I just remembered the merge conflict
    right now as I went through all the conflicts I had written down.

[2] linux-next: manual merge of the vfs-brauner tree with the bcachefs tree
    https://lore.kernel.org/linux-next/20240213100455.07e181c8@canb.auug.org.au

[3] linux-next: manual merge of the vfs-brauner tree with the bcachefs tree
    https://lore.kernel.org/linux-next/20240215100517.027fd255@canb.auug.org.au

[4] linux-next: manual merge of the vfs-brauner tree with the bcachefs tree
    https://lore.kernel.org/linux-next/20240226111257.2784c310@canb.auug.org.au

[5] linux-next: manual merge of the vfs-brauner tree with the xfs tree
    https://lore.kernel.org/linux-next/20240227102827.313113cd@canb.auug.org.au

[6] linux-next: manual merge of the vfs-brauner tree with the f2fs tree
    https://lore.kernel.org/linux-next/20240229104140.2927da29@canb.auug.org.au

Merge conflicts with mainline
=============================

[1] There's a merge conflict with bcachefs that can be resolved as follows:

    diff --cc fs/bcachefs/super-io.c
    index 36988add581f,ce8cf2d91f84..000000000000
    --- a/fs/bcachefs/super-io.c
    +++ b/fs/bcachefs/super-io.c
    @@@ -715,11 -715,11 +715,11 @@@ retry
                            opt_set(*opts, nochanges, true);
            }
    
    -       if (IS_ERR(sb->bdev_handle)) {
    -               ret = PTR_ERR(sb->bdev_handle);
    +       if (IS_ERR(sb->s_bdev_file)) {
    +               ret = PTR_ERR(sb->s_bdev_file);
     -              goto out;
     +              goto err;
            }
    -       sb->bdev = sb->bdev_handle->bdev;
    +       sb->bdev = file_bdev(sb->s_bdev_file);
    
            ret = bch2_sb_realloc(sb, 0);
            if (ret) {

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.super

for you to fetch changes up to 40ebc18b991bdb867bc693a4ac1b5d7db44838f3:

  Merge series 'Open block devices as files' of https://lore.kernel.org/r/20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org (2024-02-25 12:05:28 +0100)

Please consider pulling these changes from the signed vfs-6.9.super tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.9.super

----------------------------------------------------------------
Christian Brauner (36):
      init: flush async file closing
      file: prepare for new helper
      file: add alloc_file_pseudo_noaccount()
      bdev: open block device as files
      block/ioctl: port blkdev_bszset() to file
      block/genhd: port disk_scan_partitions() to file
      md: port block device access to file
      swap: port block device usage to file
      power: port block device access to file
      xfs: port block device access to files
      drbd: port block device access to file
      pktcdvd: port block device access to file
      rnbd: port block device access to file
      xen: port block device access to file
      zram: port block device access to file
      bcache: port block device access to files
      block2mtd: port device access to files
      nvme: port block device access to file
      s390: port block device access to file
      target: port block device access to file
      bcachefs: port block device access to file
      btrfs: port device access to file
      erofs: port device access to file
      ext4: port block device access to file
      f2fs: port block device access to files
      jfs: port block device access to file
      nfs: port block device access to files
      ocfs2: port block device access to file
      reiserfs: port block device access to file
      bdev: remove bdev_open_by_path()
      bdev: make bdev_{release, open_by_dev}() private to block layer
      bdev: make struct bdev_handle private to the block layer
      bdev: remove bdev pointer from struct bdev_handle
      block: don't rely on BLK_OPEN_RESTRICT_WRITES when yielding write access
      block: remove bdev_handle completely
      Merge series 'Open block devices as files' of https://lore.kernel.org/r/20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org

 block/bdev.c                        | 252 ++++++++++++++++++++++--------------
 block/blk.h                         |   4 +
 block/fops.c                        |  46 +++----
 block/genhd.c                       |  12 +-
 block/ioctl.c                       |   9 +-
 drivers/block/drbd/drbd_int.h       |   4 +-
 drivers/block/drbd/drbd_nl.c        |  58 ++++-----
 drivers/block/pktcdvd.c             |  68 +++++-----
 drivers/block/rnbd/rnbd-srv.c       |  28 ++--
 drivers/block/rnbd/rnbd-srv.h       |   2 +-
 drivers/block/xen-blkback/blkback.c |   4 +-
 drivers/block/xen-blkback/common.h  |   4 +-
 drivers/block/xen-blkback/xenbus.c  |  37 +++---
 drivers/block/zram/zram_drv.c       |  26 ++--
 drivers/block/zram/zram_drv.h       |   2 +-
 drivers/md/bcache/bcache.h          |   4 +-
 drivers/md/bcache/super.c           |  74 +++++------
 drivers/md/dm.c                     |  23 ++--
 drivers/md/md.c                     |  12 +-
 drivers/md/md.h                     |   2 +-
 drivers/mtd/devices/block2mtd.c     |  46 +++----
 drivers/nvme/target/io-cmd-bdev.c   |  16 +--
 drivers/nvme/target/nvmet.h         |   2 +-
 drivers/s390/block/dasd.c           |  10 +-
 drivers/s390/block/dasd_genhd.c     |  36 +++---
 drivers/s390/block/dasd_int.h       |   2 +-
 drivers/s390/block/dasd_ioctl.c     |   2 +-
 drivers/target/target_core_iblock.c |  18 +--
 drivers/target/target_core_iblock.h |   2 +-
 drivers/target/target_core_pscsi.c  |  22 ++--
 drivers/target/target_core_pscsi.h  |   2 +-
 fs/bcachefs/super-io.c              |  20 +--
 fs/bcachefs/super_types.h           |   2 +-
 fs/btrfs/dev-replace.c              |  14 +-
 fs/btrfs/ioctl.c                    |  16 +--
 fs/btrfs/volumes.c                  |  92 ++++++-------
 fs/btrfs/volumes.h                  |   4 +-
 fs/cramfs/inode.c                   |   2 +-
 fs/erofs/data.c                     |   6 +-
 fs/erofs/internal.h                 |   2 +-
 fs/erofs/super.c                    |  16 +--
 fs/ext4/ext4.h                      |   2 +-
 fs/ext4/fsmap.c                     |   8 +-
 fs/ext4/super.c                     |  52 ++++----
 fs/f2fs/f2fs.h                      |   2 +-
 fs/f2fs/super.c                     |  12 +-
 fs/file_table.c                     |  83 +++++++++---
 fs/jfs/jfs_logmgr.c                 |  26 ++--
 fs/jfs/jfs_logmgr.h                 |   2 +-
 fs/jfs/jfs_mount.c                  |   2 +-
 fs/nfs/blocklayout/blocklayout.h    |   2 +-
 fs/nfs/blocklayout/dev.c            |  68 +++++-----
 fs/ocfs2/cluster/heartbeat.c        |  32 ++---
 fs/reiserfs/journal.c               |  38 +++---
 fs/reiserfs/procfs.c                |   2 +-
 fs/reiserfs/reiserfs.h              |   8 +-
 fs/romfs/super.c                    |   2 +-
 fs/super.c                          |  18 +--
 fs/xfs/xfs_buf.c                    |  10 +-
 fs/xfs/xfs_buf.h                    |   4 +-
 fs/xfs/xfs_super.c                  |  44 +++----
 include/linux/blkdev.h              |  13 +-
 include/linux/device-mapper.h       |   2 +-
 include/linux/file.h                |   2 +
 include/linux/fs.h                  |   4 +-
 include/linux/pktcdvd.h             |   4 +-
 include/linux/swap.h                |   2 +-
 init/do_mounts.c                    |   3 +
 init/do_mounts.h                    |   9 ++
 init/initramfs.c                    |   6 +-
 kernel/power/swap.c                 |  28 ++--
 mm/swapfile.c                       |  22 ++--
 72 files changed, 812 insertions(+), 703 deletions(-)

