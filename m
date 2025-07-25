Return-Path: <linux-fsdevel+bounces-56025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CB1B11D8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80AF6AE2271
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9FA2EB5D4;
	Fri, 25 Jul 2025 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SC1qdh7Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C02EAD1B;
	Fri, 25 Jul 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442860; cv=none; b=DcwghrM/xq6stP5dbECJj4HWqMct1B2QBpkmznrwWsneGS00ZA6unHliVbSqPrGc/vXA7gPQmtdwL8oUaXywF/vehbXxXoZNJCoxpF/YW0rMt8TpvzfdvMu7iF3TawH3EFChq00wlZB+DDq0VpArfnNLzd+JFvLwTZAxeyYBf80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442860; c=relaxed/simple;
	bh=x9mRsG9GcPSU4MPUpLW6idnqdCmA3n9rIq/ddirfr9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwfDK3Db8v/M1az8mbCgExtzX+sY/A7bsvedmPVm0tiqgJIk5s3RrYbaSuQaFczKI8meAE8cWwzIgnIaAE5cK4oY5ZDBmmt9TZXmB1wIt+GxCSPcWzOGSONtOLM/Od1XWYIrwSjIhHXcBSaMspjj9G5qESESQ/kjZm+rci6Y8Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SC1qdh7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F59EC4CEF5;
	Fri, 25 Jul 2025 11:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753442859;
	bh=x9mRsG9GcPSU4MPUpLW6idnqdCmA3n9rIq/ddirfr9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SC1qdh7Z0GuA3JKQVLGo16uPcdrortss49t2V2r77T53OaY2F4Am8iig+rd0R8Oag
	 UEXAh9q2zoFf42lj6H0kobbdUtzsco3LH7a1kMtwCqAnA8zBTnIZgYsF1nOiMTxrfC
	 zK2YM3BFQkn1/kCSbf1QpPoZUMGBxsbzMmaTgsZJDQyC9SkC3tylqQYZt9of0S+ICg
	 Zm7cCHqKRPi/MYk7jCD0zFfrHuVWYbiSJnMRU0lQhHsUCjZ+uxPJqr4s1lKWf4f/UJ
	 MdH77v+ZPRe7CBMh/NXG4hzV8yauAe3fE3HuV+MUrjElxApk6uKqzxFvgpTLKSFF3g
	 FPk/0t3Swl0Tw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 14/14 for v6.17] vfs iomap
Date: Fri, 25 Jul 2025 13:27:20 +0200
Message-ID: <20250725-vfs-iomap-e5f67758f577@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4983; i=brauner@kernel.org; h=from:subject:message-id; bh=x9mRsG9GcPSU4MPUpLW6idnqdCmA3n9rIq/ddirfr9o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0Z4mZC+X9nbwxXP9xyOnfaus+Su9WmlM1w+D+ZF+3Y 3J77jMZd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkq53hf4A983/mRQxxy4Ln WO4Vt7qlsST82Y2JnXxHpxeZr9z2Sp3hn32cR7K28oPQfRwsVs/PVk4NNhXZ93Xhyasx0vfuSn8 6yQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains the iomap updates for this cycle:

- Refactor the iomap writeback code and split the generic and ioend/bio
  based writeback code. There are two methods that define the split
  between the generic writeback code, and the implemementation of it,
  and all knowledge of ioends and bios now sits below that layer.

- This series adds fuse iomap support for buffered writes and dirty
  folio writeback. This is needed so that granular uptodate and dirty
  tracking can be used in fuse when large folios are enabled. This has
  two big advantages. For writes, instead of the entire folio needing to
  be read into the page cache, only the relevant portions need to be.
  For writeback, only the dirty portions need to be written back instead
  of the entire folio.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

This contains a merge conflict with mainline that can be resolved as follows:

diff --cc fs/fuse/file.c
index 2ddfb3bb6483,f16426fd2bf5..000000000000
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.iomap

for you to fetch changes up to d5212d819e02313f27c867e6d365e71f1fdaaca4:

  Merge patch series "fuse: use iomap for buffered writes + writeback" (2025-07-17 09:55:23 +0200)

Please consider pulling these changes from the signed vfs-6.17-rc1.iomap tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.17-rc1.iomap

----------------------------------------------------------------
Christian Brauner (2):
      Merge patch series "refactor the iomap writeback code v5"
      Merge patch series "fuse: use iomap for buffered writes + writeback"

Christoph Hellwig (11):
      iomap: header diet
      iomap: pass more arguments using the iomap writeback context
      iomap: refactor the writeback interface
      iomap: hide ioends from the generic writeback code
      iomap: move all ioend handling to ioend.c
      iomap: rename iomap_writepage_map to iomap_writeback_folio
      iomap: export iomap_writeback_folio
      iomap: replace iomap_folio_ops with iomap_write_ops
      iomap: improve argument passing to iomap_read_folio_sync
      iomap: add read_folio_range() handler for buffered writes
      iomap: build the writeback code without CONFIG_BLOCK

Joanne Koong (8):
      iomap: cleanup the pending writeback tracking in iomap_writepage_map_blocks
      iomap: add public helpers for uptodate state manipulation
      iomap: move folio_unlock out of iomap_writeback_folio
      fuse: use iomap for buffered writes
      fuse: use iomap for writeback
      fuse: use iomap for folio laundering
      fuse: hook into iomap for invalidating and checking partial uptodateness
      fuse: refactor writeback to use iomap_writepage_ctx inode

 Documentation/filesystems/iomap/design.rst     |   3 -
 Documentation/filesystems/iomap/operations.rst |  57 ++-
 block/fops.c                                   |  37 +-
 fs/fuse/Kconfig                                |   1 +
 fs/fuse/file.c                                 | 345 +++++++--------
 fs/gfs2/aops.c                                 |   8 +-
 fs/gfs2/bmap.c                                 |  48 ++-
 fs/gfs2/bmap.h                                 |   1 +
 fs/gfs2/file.c                                 |   3 +-
 fs/iomap/Makefile                              |   6 +-
 fs/iomap/buffered-io.c                         | 553 ++++++++-----------------
 fs/iomap/direct-io.c                           |   5 -
 fs/iomap/fiemap.c                              |   3 -
 fs/iomap/internal.h                            |   1 -
 fs/iomap/ioend.c                               | 220 +++++++++-
 fs/iomap/iter.c                                |   1 -
 fs/iomap/seek.c                                |   4 -
 fs/iomap/swapfile.c                            |   3 -
 fs/iomap/trace.c                               |   1 -
 fs/iomap/trace.h                               |   4 +-
 fs/xfs/xfs_aops.c                              | 212 ++++++----
 fs/xfs/xfs_file.c                              |   6 +-
 fs/xfs/xfs_iomap.c                             |  12 +-
 fs/xfs/xfs_iomap.h                             |   1 +
 fs/xfs/xfs_reflink.c                           |   3 +-
 fs/zonefs/file.c                               |  40 +-
 include/linux/iomap.h                          |  82 ++--
 27 files changed, 859 insertions(+), 801 deletions(-)

