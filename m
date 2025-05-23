Return-Path: <linux-fsdevel+bounces-49772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED5CAC22FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56DA1C006E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AAC56B81;
	Fri, 23 May 2025 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFmu4nSN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4EFE552;
	Fri, 23 May 2025 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004594; cv=none; b=akvTevUhY5OIMo1TgwWm8zq+tq9GpwFY+aq6ZMa7mUYBZmmCd0VtGgn0ilAW6gSnzaXYe7ciMkDIbUAWIjj7vbfE3hsfKPfGdc8OcZOR0trh7etrP+/X72MgwjBNdlPTRWgUWVCmuVoyIansMcwtU640S8hyA70ciLzfBglfUm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004594; c=relaxed/simple;
	bh=lTdsbseJ6wgeYEPSolOTU0dSxK7rrPUSyxs/Ke9nS0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TV+2PL0AY8QQqn8Qmu6V0OxqkKRZ7YY3h3DA6evQYfEgV2H7pomivxccqb9M01ueRyO7DCnDMeTYXJVZctIx07Dpo1YL8QXy1ypqnxfqRuyY0NhkC/f7Oy9RPqr6+F+cfRR6zpcS1e4gk9PgL1ovgi4wVa/YOBnJpVzN4tAHaus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFmu4nSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353EEC4CEE9;
	Fri, 23 May 2025 12:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748004594;
	bh=lTdsbseJ6wgeYEPSolOTU0dSxK7rrPUSyxs/Ke9nS0k=;
	h=From:To:Cc:Subject:Date:From;
	b=gFmu4nSNot0I4YTwHHaG3Zqiw8ShgLpMckMETZnybv7SQd03sYeYnytmF3Frkap55
	 2h8Evg6zzanwxR19yGAB+bfDCq8+3OFrxWpUvbNfLN6+L09RJtoUdtRIsbRUQuyG9P
	 optZ1TzvJkro1x6aqw/P0z6GoeCOccQ7wQ6ud6IyIVSsBE1U6o4BctQo57KvE1DiaG
	 NKNA4RXD9DRSkMNWnzEqEbYb7AaulX1bSP0joN69Wr6yeX3pOBfdO8aWqsxOn83tRA
	 7JPwZ8TIrwSZfrmlUW3BGbkyd2S33ILNIso7ob9HvHQnYvKNMS7PUzXyavHtE1uLQF
	 q91REFQqfjKjw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.16] vfs selftests
Date: Fri, 23 May 2025 14:49:41 +0200
Message-ID: <20250523-vfs-selftests-0c172b9ac74f@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3628; i=brauner@kernel.org; h=from:subject:message-id; bh=lTdsbseJ6wgeYEPSolOTU0dSxK7rrPUSyxs/Ke9nS0k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQY5L3iErWcb1krpPjzxqOibsEXB+Lv2p+N361y64Hmx pczNzQLd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykhIHhfykL87yy9Gc8RkJH n9oKq/O/f8SzNcQy054haY5p9NZJ0owMWyVTnApMvT/1NaT1RNzmdZ9+M+jN872vmDodFJgWZr3 lAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains various cleanups, fixes, and extensions for out filesystem
selftests.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 92a09c47464d040866cf2b4cd052bc60555185fb:

  Linux 6.15-rc5 (2025-05-04 13:55:04 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.selftests

for you to fetch changes up to 7ec091c55986423b6460604a6921e441e23d68c7:

  Merge patch series "filesystems selftests cleanups and fanotify test" (2025-05-12 11:40:18 +0200)

Please consider pulling these changes from the signed vfs-6.16-rc1.selftests tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.16-rc1.selftests

----------------------------------------------------------------
Amir Goldstein (8):
      selftests/filesystems: move wrapper.h out of overlayfs subdir
      selftests/fs/statmount: build with tools include dir
      selftests/pidfd: move syscall definitions into wrappers.h
      selftests/mount_settattr: remove duplicate syscall definitions
      selftests/fs/mount-notify: build with tools include dir
      selftests/filesystems: create get_unique_mnt_id() helper
      selftests/filesystems: create setup_userns() helper
      selftests/fs/mount-notify: add a test variant running inside userns

Christian Brauner (4):
      selftests/mount_settattr: don't define sys_open_tree() twice
      selftests/mount_settattr: add missing STATX_MNT_ID_UNIQUE define
      selftests/mount_settattr: ensure that ext4 filesystem can be created
      Merge patch series "filesystems selftests cleanups and fanotify test"

 tools/include/uapi/linux/fanotify.h                | 274 ++++++++++
 tools/include/uapi/linux/mount.h                   | 235 +++++++++
 tools/include/uapi/linux/nsfs.h                    |  45 ++
 .../selftests/filesystems/mount-notify/.gitignore  |   1 +
 .../selftests/filesystems/mount-notify/Makefile    |   9 +-
 .../filesystems/mount-notify/mount-notify_test.c   |  38 +-
 .../mount-notify/mount-notify_test_ns.c            | 557 +++++++++++++++++++++
 .../selftests/filesystems/overlayfs/Makefile       |   2 +-
 .../selftests/filesystems/overlayfs/dev_in_maps.c  |   2 +-
 .../filesystems/overlayfs/set_layers_via_fds.c     |   2 +-
 .../selftests/filesystems/statmount/Makefile       |   6 +-
 .../selftests/filesystems/statmount/statmount.h    |  36 ++
 .../filesystems/statmount/statmount_test_ns.c      |  86 +---
 tools/testing/selftests/filesystems/utils.c        |  88 ++++
 tools/testing/selftests/filesystems/utils.h        |   3 +
 .../filesystems/{overlayfs => }/wrappers.h         |  46 +-
 tools/testing/selftests/mount_setattr/Makefile     |   2 +
 .../selftests/mount_setattr/mount_setattr_test.c   |  61 +--
 tools/testing/selftests/pidfd/pidfd_bind_mount.c   |  74 +--
 19 files changed, 1317 insertions(+), 250 deletions(-)
 create mode 100644 tools/include/uapi/linux/fanotify.h
 create mode 100644 tools/include/uapi/linux/mount.h
 create mode 100644 tools/include/uapi/linux/nsfs.h
 create mode 100644 tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
 rename tools/testing/selftests/filesystems/{overlayfs => }/wrappers.h (57%)

