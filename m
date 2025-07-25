Return-Path: <linux-fsdevel+bounces-56029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACB6B11D93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B62AE2974
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C43A2ED87C;
	Fri, 25 Jul 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryEtOMB7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB172ED868;
	Fri, 25 Jul 2025 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442868; cv=none; b=kXrXVdXgxkKwm/H18rUJYzlGTHWeh9fTmQnJBZXEy35fwXnhMsxMze0B4zzaxr0wlTTVTSl0p17vdYq0UVaLjcpZu5cFb9JAanBMSveNsMBsyahl8kOROu09cHEqIGLk9sOZ3gyoowhnXlFqjpCLS12ja6GAJ3Z/jO7+NQJ8rLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442868; c=relaxed/simple;
	bh=0j+74Bn8jfWSWvfkOfLVUmexiocEUEZLh1EauPyOva8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4J0TZ0WoFPYeUIqcM7Sl7lLV2r7o7yByu4a+BOO8fugBRVIBK0zl6h8/4ThEninFsTmri9bfC/U12gXHbZt4EKIQyFTTfPEQBu07knT6bgtlQh09IEhATQ+rKUndy6mK4spW5eAUdaO6ay6ElmrsPEOQRIekpFz8gv0LbqRzC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryEtOMB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2B8C4CEEF;
	Fri, 25 Jul 2025 11:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753442866;
	bh=0j+74Bn8jfWSWvfkOfLVUmexiocEUEZLh1EauPyOva8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ryEtOMB7sRTmeL2BOTBagR6BBYYcaGMOp72lFAHD4vkYEd4zFktzlEv/FsS8w1N14
	 5tE7aQHYjiWcUMqy+Fwq1mXCxsEbQ/8GYEcPjJJpjzYkAV1CSIF1or6BlcUDVMPQcd
	 3UBHsH5EQyO8rcJe/bND4gv7xuCy3BWNBDT/7bRNKBPVRk6mHVwjwFzOCIJuadlRt9
	 /ar4WblmTQGIKSxss9zIjtts1AonRFy4wu9GJSG64J90ZGd1flNFkUSSjHCLZSfBRf
	 6/uipxZr8QSpHWkP8z/A8tFc4gCNqmbD0iY1NgBV+47PrhCXy5TaGGrVkL4UrYEnnP
	 3rLD5N73fp7QA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 03/14 for v6.17] overlayfs
Date: Fri, 25 Jul 2025 13:27:24 +0200
Message-ID: <20250725-vfs-overlayfs-45f27bf923ce@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5205; i=brauner@kernel.org; h=from:subject:message-id; bh=0j+74Bn8jfWSWvfkOfLVUmexiocEUEZLh1EauPyOva8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0Z4m9evOsfVKWw0+DQ7c+6J/xvG2etu/3DL37gswRA QoX2Vc5dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE6C/DH/5lbw4JupbWnvWR WdchYnZt7dlJoUsvFu84VZKsmOJkNImRYdKHf9+jD3FF9xmaaW8PmRJ1YHKSqu5txoRLT2O4jZu C2AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains overlayfs updates for this cycle. Note that some of the
changes depend on parts of the vfs misc pull request this cycle.

They're shown in the diffstat for clarity but will obviously be already
included in the vfs misc pull request that I'm pretty sure you're going
to merge before anyway.

The changes for overlayfs in here are primarily focussed on preparing
for some proposed changes to directory locking.

Overlayfs currently will sometimes lock a directory on the upper
filesystem and do a few different things while holding the lock. This is
incompatible with the new potential scheme.

This series narrows the region of code protected by the directory lock,
taking it multiple times when necessary. This theoretically opens up
the possibilty of other changes happening on the upper filesytem between
the unlock and the lock. To some extent the patches guard against that
by checking the dentries still have the expect parent after retaking the
lock. In general, concurrent changes to the upper and lower filesystems
aren't supported properly anyway.

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

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.ovl

for you to fetch changes up to 672820a070ea5e6ae114f6109726a4e18313a527:

  ovl: properly print correct variable (2025-07-25 10:20:36 +0200)

Please consider pulling these changes from the signed vfs-6.17-rc1.ovl tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.17-rc1.ovl

----------------------------------------------------------------
Al Viro (2):
      don't duplicate vfs_open() in kernel_file_open()
      proc_fd_getattr(): don't bother with S_ISDIR() check

Amir Goldstein (3):
      fs: constify file ptr in backing_file accessor helpers
      ovl: remove unneeded non-const conversion
      ovl: support layers on case-folding capable filesystems

Andy Shevchenko (1):
      fs/read_write: Fix spelling typo

Antonio Quartulli (1):
      ovl: properly print correct variable

Christian Brauner (2):
      Merge patch series "backing_file accessors cleanup"
      Merge patch series "ovl: narrow regions protected by i_rw_sem"

Jeff Layton (1):
      filelock: add new locks_wake_up_waiter() helper

Jens Axboe (1):
      fs/pipe: set FMODE_NOWAIT in create_pipe_files()

NeilBrown (22):
      VFS: change old_dir and new_dir in struct renamedata to dentrys
      ovl: simplify an error path in ovl_copy_up_workdir()
      ovl: change ovl_create_index() to take dir locks
      ovl: Call ovl_create_temp() without lock held.
      ovl: narrow the locked region in ovl_copy_up_workdir()
      ovl: narrow locking in ovl_create_upper()
      ovl: narrow locking in ovl_clear_empty()
      ovl: narrow locking in ovl_create_over_whiteout()
      ovl: simplify gotos in ovl_rename()
      ovl: narrow locking in ovl_rename()
      ovl: narrow locking in ovl_cleanup_whiteouts()
      ovl: narrow locking in ovl_cleanup_index()
      ovl: narrow locking in ovl_workdir_create()
      ovl: narrow locking in ovl_indexdir_cleanup()
      ovl: narrow locking in ovl_workdir_cleanup_recurse()
      ovl: change ovl_workdir_cleanup() to take dir lock as needed.
      ovl: narrow locking on ovl_remove_and_whiteout()
      ovl: change ovl_cleanup_and_whiteout() to take rename lock as needed
      ovl: narrow locking in ovl_whiteout()
      ovl: narrow locking in ovl_check_rename_whiteout()
      ovl: change ovl_create_real() to receive dentry parent
      ovl: rename ovl_cleanup_unlocked() to ovl_cleanup()

 fs/backing-file.c        |   4 +-
 fs/cachefiles/namei.c    |   4 +-
 fs/ecryptfs/inode.c      |   4 +-
 fs/file_table.c          |  13 ++-
 fs/internal.h            |   1 +
 fs/locks.c               |   2 +-
 fs/namei.c               |   7 +-
 fs/nfsd/vfs.c            |   7 +-
 fs/open.c                |   5 +-
 fs/overlayfs/copy_up.c   |  52 +++++-----
 fs/overlayfs/dir.c       | 260 +++++++++++++++++++++++++----------------------
 fs/overlayfs/file.c      |   2 +-
 fs/overlayfs/namei.c     |  31 +++++-
 fs/overlayfs/overlayfs.h |  45 +++++---
 fs/overlayfs/ovl_entry.h |   1 +
 fs/overlayfs/params.c    |  12 +--
 fs/overlayfs/readdir.c   |  44 ++++----
 fs/overlayfs/super.c     |  50 ++++-----
 fs/overlayfs/util.c      |  46 ++++++---
 fs/pipe.c                |   8 +-
 fs/proc/fd.c             |  11 +-
 fs/read_write.c          |   2 +-
 fs/smb/server/vfs.c      |   4 +-
 include/linux/filelock.h |   7 +-
 include/linux/fs.h       |  14 +--
 io_uring/openclose.c     |   2 -
 26 files changed, 353 insertions(+), 285 deletions(-)

