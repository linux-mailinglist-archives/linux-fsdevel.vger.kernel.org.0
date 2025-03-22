Return-Path: <linux-fsdevel+bounces-44777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C035EA6C923
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0B83B7472
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFAF1FBCB5;
	Sat, 22 Mar 2025 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBVpG5Fo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA36B1FBC9A;
	Sat, 22 Mar 2025 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638603; cv=none; b=n6e7EsRFe29VrzzLIQg1qsStF4G8CB0vpKmXaK+9y8ua1enew3lm/e8uF4msUQ3QAbCqsDLTtvFrqmAwX9rH8uvKBmY9OIzDSEasxJ1EQ8MKuu8bk1bUEGY9hcqKdNkIXhLVhL255PZk3pTrXCT0hNZKFSn4uHizIyfmu4iCzhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638603; c=relaxed/simple;
	bh=SUwetKnFYoNm4W/eeAEMhM7E1SxTEpv7z6T87FfQbCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yoq3vF0Kd19ywf116xyZJMQwA2vOSyukyoSF/QCBzwVssppu+cF33BcLMvLSNEG32PSSUTgdI2OhoqHn9sE8LJuM55lh1T5MP1k+P1t+G4t6naWUFJYuff+a0o5o2B8Dk9Ln48aO0UsoFZVTqlNqP8Adkj3HaKoP4sbXk9ys2pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBVpG5Fo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62441C4CEDD;
	Sat, 22 Mar 2025 10:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638601;
	bh=SUwetKnFYoNm4W/eeAEMhM7E1SxTEpv7z6T87FfQbCI=;
	h=From:To:Cc:Subject:Date:From;
	b=BBVpG5FoPuHn1n1FcH4lkyXZYi/dQIcAqPx0rIk5NNvDnFmSIp2w1ILtIJAb/m4sc
	 yfgdDBkdb6GRVQZEvKgt68g0AnH1wdj6TPO/D0Z1k8LDYlAan6zFRolZFDtCpndJ8B
	 3D7CPNjuOimFNS6FwhsZSAolsizXsdYHgkEBnm4j/J50KIad0k8R0TGMHUa0I/lr4R
	 tCxVg1TQvOPbNtlxgLsBm/dgH1jq4SClysksRUYZr/dWt7p6xUOaRwjW6ubrhuI6+C
	 fB2dKyEh1VqEFayxTYabscLHdhfSiQNH28Y+j+35vlaykcUyIxWc8S1mSuwn581aU7
	 qGYM9ZNstmPlA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs ceph
Date: Sat, 22 Mar 2025 11:16:33 +0100
Message-ID: <20250322-vfs-ceph-81a373556110@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2947; i=brauner@kernel.org; h=from:subject:message-id; bh=SUwetKnFYoNm4W/eeAEMhM7E1SxTEpv7z6T87FfQbCI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf62OWUPCPjhS6emTZ1RSf1H3P7y4wuXiix1xb6qvxU cbDTxdEdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkVArDf7c5Xp9035guS/Pa Ms3lgKHywmiuwxaXfjPHNZeI/zitcpeRofXpGsbF3W7BzHXy83beeRojtKSQ6cfUDV7Hao783PH UlhkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains the work to remove access to page->index from ceph and
fixes the test failure observed for ceph with generic/421 by refactoring
ceph_writepages_start().

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

No known conflicts.

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.ceph

for you to fetch changes up to 59b59a943177e1a96d645a63d1ad824644fa848a:

  fscrypt: Change fscrypt_encrypt_pagecache_blocks() to take a folio (2025-03-05 12:57:15 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.ceph tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.ceph

----------------------------------------------------------------
Christian Brauner (2):
      Merge patch series "ceph: fix generic/421 test failure"
      Merge patch series "Remove accesses to page->index from ceph"

Matthew Wilcox (Oracle) (12):
      ceph: Remove ceph_writepage()
      ceph: Use a folio in ceph_page_mkwrite()
      ceph: Convert ceph_find_incompatible() to take a folio
      ceph: Convert ceph_readdir_cache_control to store a folio
      ceph: Convert writepage_nounlock() to write_folio_nounlock()
      ceph: Convert ceph_check_page_before_write() to use a folio
      ceph: Remove uses of page from ceph_process_folio_batch()
      ceph: Convert ceph_move_dirty_page_in_page_array() to move_dirty_folio_in_page_array()
      ceph: Pass a folio to ceph_allocate_page_array()
      fs: Remove page_mkwrite_check_truncate()
      ceph: Fix error handling in fill_readdir_cache()
      fscrypt: Change fscrypt_encrypt_pagecache_blocks() to take a folio

Viacheslav Dubeyko (4):
      ceph: extend ceph_writeback_ctl for ceph_writepages_start() refactoring
      ceph: introduce ceph_process_folio_batch() method
      ceph: introduce ceph_submit_write() method
      ceph: fix generic/421 test failure

 fs/ceph/addr.c          | 1259 +++++++++++++++++++++++++++++------------------
 fs/ceph/dir.c           |   15 +-
 fs/ceph/inode.c         |   31 +-
 fs/ceph/mds_client.c    |    2 +
 fs/ceph/mds_client.h    |    3 +
 fs/ceph/super.c         |   11 +
 fs/ceph/super.h         |    2 +-
 fs/crypto/crypto.c      |   22 +-
 fs/ext4/page-io.c       |    2 +-
 fs/f2fs/data.c          |    2 +-
 include/linux/fscrypt.h |   12 +-
 include/linux/pagemap.h |   28 --
 12 files changed, 848 insertions(+), 541 deletions(-)

