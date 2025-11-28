Return-Path: <linux-fsdevel+bounces-70159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A760C92A49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D613AE40C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726D42E540B;
	Fri, 28 Nov 2025 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOwjFdpR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F102E091C;
	Fri, 28 Nov 2025 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348684; cv=none; b=kXDqMlnv89lJR2IaFBNQU561NaMP2zcSfb0s6+OFOlLF/dp8TPutzTvTHgUoKyUsPNnO1rCdE0LtFq3k9n7XKeJxeeuyX5HP38XhIeOmBgYzepQYGhlTrjHCg2yGfKVE9u7X2kZvrkcPEOleVKT/OX1U1cVorr7vK3sO2ZkZRjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348684; c=relaxed/simple;
	bh=1z+NJZSJgEYZiHMMZwwpPDAevUoIqrehRvYv8uYRK9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkQkyhJjxBbmpfa8PDYql7ZoThh7D6jSL/P1chcSsO3nLROU54JcOUUhIV4BwvzKwvqkc98TFZsFlzaOfmXm30ySfHK+yTu9ZuQ5dQIVNECdBB0E2oQ0bZbSK1nVudezh7MVKMNSDnrBMikFwObvQvbNrB+g0MFZF0fJjkxH11w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOwjFdpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE27C116B1;
	Fri, 28 Nov 2025 16:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348684;
	bh=1z+NJZSJgEYZiHMMZwwpPDAevUoIqrehRvYv8uYRK9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOwjFdpRGrpSU/Q02LmkO7ofcw9TGEpM/oZriHKr4tgi/Pz5xaXgNFb30TKlKs5ER
	 12FT76JYmq4rUmStGGnxmLwqlC29+ffB91OCb9v292+0MLatFmGUFMPzvs2m2Dcs+x
	 oisU2XQ7j80SyFe8bLe4zGn0wEIIP1/aVFwEYMe6pxqAFLe/YhGoBok5us7XCacYt8
	 BHlN3pWxYRLPcCQ4oogW+mdfbA/ydZS0/XcERBetiAFTVvwph/eaP5zKufwKSf8rnQ
	 Zzqn7iUBKm/KvPkWxeikeIuPn5OllF2+z38yvgzDcwpdE0Qydt08OkfmKiR7yq1ADs
	 g1vt8yiC68XUg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 09/17 for v6.19] vfs headers
Date: Fri, 28 Nov 2025 17:48:20 +0100
Message-ID: <20251128-vfs-headers-v619-d2ce5e771a9d@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128-vfs-v619-77cd88166806@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6165; i=brauner@kernel.org; h=from:subject:message-id; bh=1z+NJZSJgEYZiHMMZwwpPDAevUoIqrehRvYv8uYRK9k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXnqk/uXRBMMAr3X+N+TrF+04GLP4jFBZ0+wv1tUPM mMmTI162FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRDxKMDGuflOdMdfE8Livt n+XxqSJ24uZGM7VJUvxZC/72H5iUvp/hf/qtvUdiZok4+Cp5ieuaZixdwNFU+oxn3c9uv06Jm3b XuQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains initial work to start splitting up fs.h.

Begin the long-overdue work of splitting up the monolithic fs.h header.
The header has grown to over 3000 lines and includes types and functions
for many different subsystems, making it difficult to navigate and
causing excessive compilation dependencies.

This series introduces new focused headers for superblock-related code:

- Rename fs_types.h to fs_dirent.h to better reflect its actual content
  (directory entry types)

- Add fs/super_types.h containing superblock type definitions

- Add fs/super.h containing superblock function declarations

This is the first step in a longer effort to modularize the VFS headers.

Cleanups

- Inode Field Layout Optimization (Mateusz Guzik)

- Move inode fields used during fast path lookup closer together to improve
  cache locality during path resolution.

- current_umask() Optimization (Mateusz Guzik)

- Inline current_umask() and move it to fs_struct.h. This improves
  performance by avoiding function call overhead for this frequently-used
  function, and places it in a more appropriate header since it operates
  on fs_struct.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

diff --cc include/linux/fs.h
index 1011b82977fc,64dc2e2c281f..000000000000
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@@ -2880,11 -2335,8 +2395,9 @@@ static inline void super_set_sysfs_name
        va_end(args);
  }

- extern int current_umask(void);
-
  extern void ihold(struct inode * inode);
  extern void iput(struct inode *);
 +void iput_not_last(struct inode *);
  int inode_update_timestamps(struct inode *inode, int flags);
  int generic_update_time(struct inode *, int);

@@@ -3481,11 -2929,8 +2988,8 @@@ static inline void remove_inode_hash(st
  }

  extern void inode_sb_list_add(struct inode *inode);
 -extern void inode_add_lru(struct inode *inode);
 +extern void inode_lru_list_add(struct inode *inode);

- int sb_set_blocksize(struct super_block *sb, int size);
- int __must_check sb_min_blocksize(struct super_block *sb, int size);
-
  int generic_file_mmap(struct file *, struct vm_area_struct *);
  int generic_file_mmap_prepare(struct vm_area_desc *desc);
  int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
diff --git a/include/linux/fs/super.h b/include/linux/fs/super.h
index c0d22b12c1c9..69c11b28ed65 100644
--- a/include/linux/fs/super.h
+++ b/include/linux/fs/super.h
@@ -223,7 +223,7 @@ static inline bool sb_has_encoding(const struct super_block *sb)
 }

 int sb_set_blocksize(struct super_block *sb, int size);
-int sb_min_blocksize(struct super_block *sb, int size);
+int __must_check sb_min_blocksize(struct super_block *sb, int size);

 int freeze_super(struct super_block *super, enum freeze_holder who,
                 const void *freeze_owner);
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index 45cfd45b9fe0..6bd3009e09b3 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -267,6 +267,7 @@ struct super_block {

        spinlock_t                              s_inode_wblist_lock;
        struct list_head                        s_inodes_wb;    /* writeback inodes */
+       long                                    s_min_writeback_pages;
 } __randomize_layout;

 /*

Merge conflicts with other trees
================================

The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.fs_header

for you to fetch changes up to dca3aa666fbd71118905d88bb1c353881002b647:

  fs: move inode fields used during fast path lookup closer together (2025-11-11 10:49:54 +0100)

Please consider pulling these changes from the signed vfs-6.19-rc1.fs_header tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.19-rc1.fs_header

----------------------------------------------------------------
Christian Brauner (4):
      fs: rename fs_types.h to fs_dirent.h
      fs: add fs/super_types.h header
      fs: add fs/super.h header
      Merge patch series "fs: start to split up fs.h"

Mateusz Guzik (2):
      fs: inline current_umask() and move it to fs_struct.h
      fs: move inode fields used during fast path lookup closer together

 fs/9p/acl.c                               |   1 +
 fs/Makefile                               |   2 +-
 fs/btrfs/inode.c                          |   1 +
 fs/f2fs/acl.c                             |   1 +
 fs/fat/inode.c                            |   1 +
 fs/{fs_types.c => fs_dirent.c}            |   2 +-
 fs/fs_struct.c                            |   6 -
 fs/hfsplus/options.c                      |   1 +
 fs/hpfs/super.c                           |   1 +
 fs/nilfs2/nilfs.h                         |   1 +
 fs/ntfs3/super.c                          |   1 +
 fs/ocfs2/acl.c                            |   1 +
 fs/omfs/inode.c                           |   1 +
 fs/smb/client/file.c                      |   1 +
 fs/smb/client/inode.c                     |   1 +
 fs/smb/client/smb1ops.c                   |   1 +
 include/linux/fs.h                        | 533 +-----------------------------
 include/linux/fs/super.h                  | 233 +++++++++++++
 include/linux/fs/super_types.h            | 335 +++++++++++++++++++
 include/linux/{fs_types.h => fs_dirent.h} |  11 +-
 include/linux/fs_struct.h                 |   6 +
 include/linux/namei.h                     |   1 +
 22 files changed, 600 insertions(+), 542 deletions(-)
 rename fs/{fs_types.c => fs_dirent.c} (98%)
 create mode 100644 include/linux/fs/super.h
 create mode 100644 include/linux/fs/super_types.h
 rename include/linux/{fs_types.h => fs_dirent.h} (92%)

