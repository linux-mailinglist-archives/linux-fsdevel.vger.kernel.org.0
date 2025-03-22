Return-Path: <linux-fsdevel+bounces-44774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7877BA6C919
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433CE1B6288A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952511F541E;
	Sat, 22 Mar 2025 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBZlKxsS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7371F8690;
	Sat, 22 Mar 2025 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638563; cv=none; b=pNyzgKuezvspGblC+4I/I+72H+lk3I05UAm2qvwpmq8Fnwfo+xt48tja7EfCnRr3RGuWKGEEeOFjjLXEbpjUP2OrYUJWRePR9hQJx2LWOMFq+8OdBq5xSmqIHoFEBKfyxU1Y93zmtYQpGdbvm4lxIFtYVLG9xSS1RVBKL12qTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638563; c=relaxed/simple;
	bh=PF02WhT/PY5AMumrWCbFWM1+36mcUovgKSZXMdLVFgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uR0m2HcHA0RTk5kiVyn4jE8mja+IIEGoZYoNyQd7RkP/XekgRtyxlq4If9Oca8X6bdhmJLx3L+ulNKztwPU/Enjcz0Qgjnu16pKgMpqrCNYMLL6eKdUnpaqg2OGiTHNBLj86/+A3o1/fL4lHgoG1BWAUCrLy203red9BToFvfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBZlKxsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455F8C4CEE9;
	Sat, 22 Mar 2025 10:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638563;
	bh=PF02WhT/PY5AMumrWCbFWM1+36mcUovgKSZXMdLVFgU=;
	h=From:To:Cc:Subject:Date:From;
	b=CBZlKxsS5vhDOBcAcwPERgV4kqB5uhA7qXJ1SqvKuCcC8pWcVNn70VujIDSY04XM3
	 0uv4OiWF351itp3COuQktFKipvnHIvZTAlH0bbisd/aaOsOgRY/BlizLX1vrnotrrD
	 hvS1w3lvU+at6pm2L0S9wzM7fJb/SkmMfOYi4MQQGB7KR+B/O9z8iaxdYTNxgOE40z
	 ksvA2QtUM9PjPkymqCVIO0nd50rnGZxpmjs38RXcngh4bAAPcI5DZoJykDT4VYRB9C
	 r5/lrCmaC9LZHInwWPfJdP4YVyuwyicGN4j/jqAnYujIj9Ona1Xj3Tnf7OPVWpXRGv
	 U+lMczJMyqgBA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs sysv
Date: Sat, 22 Mar 2025 11:15:55 +0100
Message-ID: <20250322-vfs-sysv-abc5d9a610b9@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4805; i=brauner@kernel.org; h=from:subject:message-id; bh=PF02WhT/PY5AMumrWCbFWM1+36mcUovgKSZXMdLVFgU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf67179sJ168e9UZuY1n6Nl432aDuRHCGq9dD7UXjbs /OL7ile7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI5UWG/15RHnXux1mV53b8 na8Vz1ed7Xpm8bwK5yOXr/iUhxdu6GH4K1z7zjMvQclPL6Le3iikOq1HXeNw/auM8MIsx9VRD3e xAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This removes the sysv filesystem. We've discussed this various times.
It's time to try.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

This contains a merge conflict with the vfs-6.15.async.dir pull request
that can be resolved simply by:

git rm fs/sysv/namei.c

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.sysv

for you to fetch changes up to f988166291e035f315ee8a947587f7a3542f1189:

  Merge patch "sysv: Remove the filesystem" (2025-02-21 10:32:52 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.sysv tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.sysv

----------------------------------------------------------------
Christian Brauner (2):
      Merge patch series "fs: last of the pseudofs mount api conversions"
      Merge patch "sysv: Remove the filesystem"

David Howells (1):
      vfs: Convert devpts to use the new mount API

Eric Sandeen (4):
      pstore: convert to the new mount API
      devtmpfs: replace ->mount with ->get_tree in public instance
      vfs: remove some unused old mount api code
      sysv: convert sysv to use the new mount api

Jan Kara (1):
      sysv: Remove the filesystem

 Documentation/filesystems/index.rst         |   1 -
 Documentation/filesystems/sysv-fs.rst       | 264 ------------
 MAINTAINERS                                 |   6 -
 arch/loongarch/configs/loongson3_defconfig  |   1 -
 arch/m68k/configs/amiga_defconfig           |   1 -
 arch/m68k/configs/apollo_defconfig          |   1 -
 arch/m68k/configs/atari_defconfig           |   1 -
 arch/m68k/configs/bvme6000_defconfig        |   1 -
 arch/m68k/configs/hp300_defconfig           |   1 -
 arch/m68k/configs/mac_defconfig             |   1 -
 arch/m68k/configs/multi_defconfig           |   1 -
 arch/m68k/configs/mvme147_defconfig         |   1 -
 arch/m68k/configs/mvme16x_defconfig         |   1 -
 arch/m68k/configs/q40_defconfig             |   1 -
 arch/m68k/configs/sun3_defconfig            |   1 -
 arch/m68k/configs/sun3x_defconfig           |   1 -
 arch/mips/configs/malta_defconfig           |   1 -
 arch/mips/configs/malta_kvm_defconfig       |   1 -
 arch/mips/configs/maltaup_xpa_defconfig     |   1 -
 arch/mips/configs/rm200_defconfig           |   1 -
 arch/parisc/configs/generic-64bit_defconfig |   1 -
 arch/powerpc/configs/fsl-emb-nonhw.config   |   1 -
 arch/powerpc/configs/ppc6xx_defconfig       |   1 -
 drivers/base/devtmpfs.c                     |  81 +++-
 fs/Kconfig                                  |   1 -
 fs/Makefile                                 |   1 -
 fs/devpts/inode.c                           | 251 +++++-------
 fs/pstore/inode.c                           | 109 +++--
 fs/super.c                                  |  55 ---
 fs/sysv/Kconfig                             |  38 --
 fs/sysv/Makefile                            |   9 -
 fs/sysv/balloc.c                            | 240 -----------
 fs/sysv/dir.c                               | 378 ------------------
 fs/sysv/file.c                              |  59 ---
 fs/sysv/ialloc.c                            | 235 -----------
 fs/sysv/inode.c                             | 354 -----------------
 fs/sysv/itree.c                             | 511 ------------------------
 fs/sysv/namei.c                             | 280 -------------
 fs/sysv/super.c                             | 595 ----------------------------
 fs/sysv/sysv.h                              | 245 ------------
 include/linux/fs.h                          |   3 -
 include/linux/fs_context.h                  |   2 -
 include/linux/sysv_fs.h                     | 214 ----------
 43 files changed, 248 insertions(+), 3704 deletions(-)
 delete mode 100644 Documentation/filesystems/sysv-fs.rst
 delete mode 100644 fs/sysv/Kconfig
 delete mode 100644 fs/sysv/Makefile
 delete mode 100644 fs/sysv/balloc.c
 delete mode 100644 fs/sysv/dir.c
 delete mode 100644 fs/sysv/file.c
 delete mode 100644 fs/sysv/ialloc.c
 delete mode 100644 fs/sysv/inode.c
 delete mode 100644 fs/sysv/itree.c
 delete mode 100644 fs/sysv/namei.c
 delete mode 100644 fs/sysv/super.c
 delete mode 100644 fs/sysv/sysv.h
 delete mode 100644 include/linux/sysv_fs.h

