Return-Path: <linux-fsdevel+bounces-62882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C30BA418A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 16:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B27B3A6F4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1446187554;
	Fri, 26 Sep 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJjpqlPR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068711DF742;
	Fri, 26 Sep 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896349; cv=none; b=oVLe9U1MdL8IUq9blStLpqxEKrxgUpZ1/xy4Gexg9Dp73l3+Fof1fmb6/9PLpSrVDK6l8J3pPfHsrmhtSY/zaSaI8HMC33FPRt5V12kSNRKPNmMtL/gT0dfhAeOChZWD3OOvTMnZnD7+0JCUmvWakgWcu8cThg6Q2rgaNTKqUmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896349; c=relaxed/simple;
	bh=Bk+diC0wDa3varLA/2UWx46Ww2ckaeTRpzqi1Cl6zJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbRwGJNebpQTzz5Ryx5ozdCM+j4mdIGmY82DerjPER3ybveMc2B8QnAIkFQEHnAvXVyrSQgELn1u3voJvmGJ/9TLfSlWI0alimcxMo5exDDj4BAgyrq5z2qOmMUMcNYAZSzFy8qvwTBRzUuVBz9VGHAs77A+uU25zXoM5nEMwJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJjpqlPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5302C116B1;
	Fri, 26 Sep 2025 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896348;
	bh=Bk+diC0wDa3varLA/2UWx46Ww2ckaeTRpzqi1Cl6zJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJjpqlPROqGTG+wBlO7XYBJeF+pwOhVnlo5F5wLzVxQv8ImQM5DE9Xco0x9mFFRq3
	 DFLfDzpW+2MCe4KAWhqhuTYWdfd7VMyHLBjYZugZBk/Py9M9VJkVfZJnSEG21WXpMP
	 ZUzF21apwItK4pQ9smjrJXsa3mG7fkxITbsaj1O10Yew/GOU/le+cu/VqibP01+Eg4
	 p0lzj3GVivtDUc4d86pozmNkUE4e9s7yxSkWkUUxT/54DJeCHDNNhKIvxR1+LULS74
	 vBr/KtLOTHH0Z6tAXnoTh9+lKP1/dp8YKz0Tlq732X45kWtmAgIMpiFny2MYtydenX
	 pbYsLw0CFSQjw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 03/12 for v6.18] inode
Date: Fri, 26 Sep 2025 16:18:57 +0200
Message-ID: <20250926-vfs-inode-be4062725b4f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926-vfs-618-e880cf3b910f@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6963; i=brauner@kernel.org; h=from:subject:message-id; bh=Bk+diC0wDa3varLA/2UWx46Ww2ckaeTRpzqi1Cl6zJk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcW3De4NMd61qNg2uKjgn4Sr97J3eJj/H0mnXq7iKP9 zWGX2K72lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARLylGhif/c3ZNfbO+V+j1 k1Pdy/O89ogriOZpL3w292nto09s9wUYGVojrvquEPvFfmzt2Ulu8x8cTVWf++Dt6edvFzrrsPi rpfADAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains a series I originally wrote and that Eric brought over the
finish line. It moves out the i_crypt_info and i_verity_info pointers
out of 'struct inode' and into the fs-specific part of the inode.

So now the few filesytems that actually make use of this pay the price
in their own private inode storage instead of forcing it upon every user
of struct inode.

The pointer for the crypt and verity info is simply found by storing an
offset to its address in struct fsverity_operations and struct
fscrypt_operations. This shrinks struct inode by 16 bytes.

I hope to move a lot more out of it in the future so that struct inode
becomes really just about very core stuff that we need, much like struct
dentry and struct file, instead of the dumping ground it has become over
the years.

On top of this are a various changes associated with the ongoing inode
lifetime handling rework that multiple people are pushing forward:

* Stop accessing inode->i_count directly in f2fs and gfs2. They simply
  should use the __iget() and iput() helpers.

* Make the i_state flags an enum.

* Rework the iput() logic

  Currently, if we are the last iput, and we have the I_DIRTY_TIME bit
  set, we will grab a reference on the inode again and then mark it
  dirty and then redo the put.  This is to make sure we delay the time
  update for as long as possible.

  We can rework this logic to simply dec i_count if it is not 1, and if
  it is do the time update while still holding the i_count reference.

  Then we can replace the atomic_dec_and_lock with locking the ->i_lock
  and doing atomic_dec_and_test, since we did the atomic_add_unless
  above.

* Add an icount_read() helper and convert everyone that accesses
  inode->i_count directly for this purpose to use the helper.

* Expand dump_inode() to dump more information about an inode helping in
  debugging.

* Add some might_sleep() annotations to iput() and associated helpers.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

[1] This will have a merge conflict with the vfs-6.18-rc1.misc pull request.
    The conflict resolution is to simply use exactly what the tag here
    brings in.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.inode

for you to fetch changes up to c3c616c53dbabddf32a0485bd133d8d3b9f6656a:

  Merge branch 'vfs-6.18.inode.refcount.preliminaries' (2025-09-19 16:46:02 +0200)

Please consider pulling these changes from the signed vfs-6.18-rc1.inode tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.18-rc1.inode

----------------------------------------------------------------
Christian Brauner (3):
      Merge patch series "Move fscrypt and fsverity info out of struct inode"
      inode: fix whitespace issues
      Merge branch 'vfs-6.18.inode.refcount.preliminaries'

Eric Biggers (13):
      fscrypt: replace raw loads of info pointer with helper function
      fscrypt: add support for info in fs-specific part of inode
      ext4: move crypt info pointer to fs-specific part of inode
      f2fs: move crypt info pointer to fs-specific part of inode
      ubifs: move crypt info pointer to fs-specific part of inode
      ceph: move crypt info pointer to fs-specific part of inode
      fs: remove inode::i_crypt_info
      fsverity: add support for info in fs-specific part of inode
      ext4: move verity info pointer to fs-specific part of inode
      f2fs: move verity info pointer to fs-specific part of inode
      btrfs: move verity info pointer to fs-specific part of inode
      fs: remove inode::i_verity_info
      fsverity: check IS_VERITY() in fsverity_cleanup_inode()

Josef Bacik (4):
      fs: stop accessing ->i_count directly in f2fs and gfs2
      fs: make the i_state flags an enum
      fs: rework iput logic
      fs: add an icount_read helper

Mateusz Guzik (1):
      fs: expand dump_inode()

Max Kellermann (1):
      fs: add might_sleep() annotation to iput() and more

 arch/powerpc/platforms/cell/spufs/file.c |   2 +-
 fs/btrfs/btrfs_inode.h                   |   5 +
 fs/btrfs/inode.c                         |   5 +-
 fs/btrfs/verity.c                        |   2 +
 fs/ceph/crypto.c                         |   2 +
 fs/ceph/inode.c                          |   1 +
 fs/ceph/mds_client.c                     |   2 +-
 fs/ceph/super.h                          |   1 +
 fs/crypto/bio.c                          |   2 +-
 fs/crypto/crypto.c                       |  14 +-
 fs/crypto/fname.c                        |  11 +-
 fs/crypto/fscrypt_private.h              |   4 +-
 fs/crypto/hooks.c                        |   2 +-
 fs/crypto/inline_crypt.c                 |  12 +-
 fs/crypto/keysetup.c                     |  43 +++---
 fs/crypto/policy.c                       |   7 +-
 fs/ext4/crypto.c                         |   2 +
 fs/ext4/ext4.h                           |   8 +
 fs/ext4/ialloc.c                         |   4 +-
 fs/ext4/super.c                          |   6 +
 fs/ext4/verity.c                         |   2 +
 fs/f2fs/f2fs.h                           |   6 +
 fs/f2fs/super.c                          |  14 +-
 fs/f2fs/verity.c                         |   2 +
 fs/fs-writeback.c                        |   2 +-
 fs/gfs2/ops_fstype.c                     |   2 +-
 fs/hpfs/inode.c                          |   2 +-
 fs/inode.c                               |  90 ++++++++---
 fs/nfs/inode.c                           |   4 +-
 fs/notify/fsnotify.c                     |   2 +-
 fs/smb/client/inode.c                    |   2 +-
 fs/ubifs/crypto.c                        |   2 +
 fs/ubifs/super.c                         |   2 +-
 fs/ubifs/ubifs.h                         |   4 +
 fs/verity/enable.c                       |   6 +-
 fs/verity/fsverity_private.h             |   9 +-
 fs/verity/open.c                         |  23 +--
 fs/verity/verify.c                       |   2 +-
 fs/xfs/xfs_inode.c                       |   2 +-
 fs/xfs/xfs_trace.h                       |   2 +-
 include/linux/fs.h                       | 246 ++++++++++++++++---------------
 include/linux/fscrypt.h                  |  40 ++++-
 include/linux/fsverity.h                 |  57 +++++--
 include/trace/events/filelock.h          |   2 +-
 security/landlock/fs.c                   |   2 +-
 45 files changed, 428 insertions(+), 234 deletions(-)

