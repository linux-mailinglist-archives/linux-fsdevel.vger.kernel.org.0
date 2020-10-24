Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFEB297E07
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Oct 2020 20:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763960AbgJXSrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Oct 2020 14:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763956AbgJXSrB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Oct 2020 14:47:01 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59ECC0613CE;
        Sat, 24 Oct 2020 11:47:00 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWOZ6-007i1l-Um; Sat, 24 Oct 2020 18:46:57 +0000
Date:   Sat, 24 Oct 2020 19:46:56 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs misc pile
Message-ID: <20201024184656.GB3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Assorted stuff all over the place (the largest group here is
Christoph's stat cleanups).  This is probably the last pull request
for this window - there's also a group of sparc patches in -next,
and davem seemed to be OK with that at the time, but I'd rather have
it go through his tree when he's back - nothing urgent in that series.

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

for you to fetch changes up to f2d077ff1b5c17008cff5dc27e7356a694e55462:

  fs: remove KSTAT_QUERY_FLAGS (2020-09-26 22:55:05 -0400)

----------------------------------------------------------------
Al Viro (1):
      reduce boilerplate in fsid handling

Alex Dewar (1):
      fs: omfs: use kmemdup() rather than kmalloc+memcpy

Christoph Hellwig (5):
      fs: remove vfs_statx_fd
      fs: implement vfs_stat and vfs_lstat in terms of vfs_fstatat
      fs: move vfs_fstatat out of line
      fs: remove vfs_stat_set_lookup_flags
      fs: remove KSTAT_QUERY_FLAGS

Krzysztof Wilczyński (1):
      fs: Remove duplicated flag O_NDELAY occurring twice in VALID_OPEN_FLAGS

Mattias Nissler (1):
      Add a "nosymfollow" mount option.

Ross Zwisler (1):
      selftests: mount: add nosymfollow tests

 fs/9p/vfs_super.c                                  |   3 +-
 fs/adfs/super.c                                    |   3 +-
 fs/affs/super.c                                    |   3 +-
 fs/befs/linuxvfs.c                                 |   3 +-
 fs/bfs/inode.c                                     |   3 +-
 fs/ceph/super.c                                    |   3 +-
 fs/cramfs/inode.c                                  |   3 +-
 fs/efs/super.c                                     |   3 +-
 fs/erofs/super.c                                   |   3 +-
 fs/exfat/super.c                                   |   3 +-
 fs/ext2/super.c                                    |   3 +-
 fs/ext4/super.c                                    |   3 +-
 fs/f2fs/super.c                                    |   3 +-
 fs/fat/inode.c                                     |   3 +-
 fs/hfs/super.c                                     |   3 +-
 fs/hfsplus/super.c                                 |   3 +-
 fs/hpfs/super.c                                    |   3 +-
 fs/isofs/inode.c                                   |   3 +-
 fs/minix/inode.c                                   |   3 +-
 fs/namei.c                                         |   3 +-
 fs/namespace.c                                     |   2 +
 fs/nilfs2/super.c                                  |   3 +-
 fs/ntfs/super.c                                    |   3 +-
 fs/omfs/inode.c                                    |   6 +-
 fs/proc_namespace.c                                |   1 +
 fs/qnx4/inode.c                                    |   3 +-
 fs/qnx6/inode.c                                    |   3 +-
 fs/romfs/super.c                                   |   3 +-
 fs/squashfs/super.c                                |   3 +-
 fs/stat.c                                          |  70 +++----
 fs/statfs.c                                        |   2 +
 fs/sysv/inode.c                                    |   3 +-
 fs/udf/super.c                                     |   3 +-
 fs/ufs/super.c                                     |   3 +-
 fs/xfs/xfs_super.c                                 |   3 +-
 fs/zonefs/super.c                                  |   3 +-
 include/linux/fcntl.h                              |   2 +-
 include/linux/fs.h                                 |  22 +--
 include/linux/mount.h                              |   3 +-
 include/linux/stat.h                               |   2 -
 include/linux/statfs.h                             |   6 +
 include/uapi/linux/mount.h                         |   1 +
 tools/testing/selftests/mount/.gitignore           |   1 +
 tools/testing/selftests/mount/Makefile             |   4 +-
 tools/testing/selftests/mount/nosymfollow-test.c   | 218 +++++++++++++++++++++
 tools/testing/selftests/mount/run_nosymfollow.sh   |   4 +
 .../{run_tests.sh => run_unprivileged_remount.sh}  |   0
 47 files changed, 308 insertions(+), 129 deletions(-)
 create mode 100644 tools/testing/selftests/mount/nosymfollow-test.c
 create mode 100755 tools/testing/selftests/mount/run_nosymfollow.sh
 rename tools/testing/selftests/mount/{run_tests.sh => run_unprivileged_remount.sh} (100%)
