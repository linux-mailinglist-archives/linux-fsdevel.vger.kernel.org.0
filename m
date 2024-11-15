Return-Path: <linux-fsdevel+bounces-34910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC649CE0D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F092812F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDB11CF5C0;
	Fri, 15 Nov 2024 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6XjgT5u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259EE1CEE8D;
	Fri, 15 Nov 2024 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679241; cv=none; b=GmFUt5w8gbdckyu5tSI7sVhbeZFJWHzILra2TrpTc0CCZ+rxM0BSmHSeds2arH27Q6OyfDL605XOCV72KVoOnvbdiS+a+z+V9aJUYzF8jd0bdk1k/SI9GKSCB/+Xx5qwkE69iOF/LOUWUfVfC7TLschHMrH9DtMK6IopPdO+UTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679241; c=relaxed/simple;
	bh=q1Weqvk2CH1OE3fi6LRjGxhd+pQIrSmrsd1/bbY6Wqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H177iiKHs36QxgKfhkw9sqXcc2ud+sHnbXiBtFFGdHZSihPFxXgyEo+if1kFwDO0RLsuXegkXLRPxwnX9kiscft4fX///b/fdFhXlVtHEtIX1NPehqPv3E2cRfPs3GD/fC0dqRInLAUC5SFQWgClmD+AEq27fMjZAbE3rEQwJGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6XjgT5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C934EC4CECF;
	Fri, 15 Nov 2024 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731679241;
	bh=q1Weqvk2CH1OE3fi6LRjGxhd+pQIrSmrsd1/bbY6Wqk=;
	h=From:To:Cc:Subject:Date:From;
	b=h6XjgT5upnrrM+YLmFz9dhU6MfZswxdZKZaziF4HgoeufcQrz5iOhn6UfAJ/88JY3
	 Az16yeUCBrphrc91nIeceNrjTUsWmO6rMvR4VQXI1yzA/7oFZF6hoxq3BDGlCypEWw
	 0x/U9HqkxHZlrgObdqOTRGvaSWDunTD5STrYdltDcR1Jjr+SP1CLK9jnEQuwP6i+wl
	 PgaMQarJo+CabYsi0/BRVrSvHdaz8aNXmBWXOcbaaSWX8k0HnYlTW55H94ZtWYMktF
	 UIM7UU/+fSM9uo7fvxvuD51lBKGsEuv8qFArKcGbMH9dw7mrK8ght5MtOlg7C3NeWQ
	 nXYy2eLnqsiOQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs netfs
Date: Fri, 15 Nov 2024 15:00:21 +0100
Message-ID: <20241115-vfs-netfs-7df3b2479ea4@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4636; i=brauner@kernel.org; h=from:subject:message-id; bh=q1Weqvk2CH1OE3fi6LRjGxhd+pQIrSmrsd1/bbY6Wqk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSbB//6b1Ts0TSJT+3LrX05Bim+u0y3Mv20aHySsmjDn Q9LXlvkdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykyoqR4abk5221l4+pzt73 JTmkRZ2/r+RqyISl8kJtbys/nKhL02JkOCNYI1XL3jbnfkC3dXwqR7jZf1OrdbNefTgkKZwZGTq BBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

A pidfs patch ended up in the branch and I didn't notice it. I decided
to leave it in here instead of rebasing the whole branch.

/* Summary */

This contains various fixes for the netfs library and related
filesystems and infrastructure:

afs:

    - Fix missing wire-up of afs_retry_request().

    - Fix the setting of the server responding flag in afs.

    - Fix possible infinite loop with unresponsive servers.

    - Remove unused struct and function prototype.

cachefiles:

    - Fix a dentry leak in cachefiles_open_file().

    - Fix incorrect length return value in cachefiles_ondemand_fd_write_iter().

    - Fix missing pos updates in cachefiles_ondemand_fd_write_iter().

    - Clean up in cachefiles_commit_tmpfile().

    - Fix NULL pointer dereference in object->file.

    - Add a memory barrier for FSCACHE_VOLUME_CREATING.

netfs:

    - Advance iterator correctly rather than jumping it.

    - Add folio_queue API documentation.

    - Fix the netfs_folio tracepoint to handle NULL mapping.

    - Remove call to folio_index().

    - Fix a few minor bugs in netfs_page_mkwrite().

    - Remove unnecessary references to pages.

pidfs:

    - Check for valid pid namespace.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.12-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.netfs

for you to fetch changes up to a4b2923376be062a243ac38762212a38485cfab1:

  Merge patch series "fscache/cachefiles: Some bugfixes" (2024-11-11 14:39:39 +0100)

Please consider pulling these changes from the signed vfs-6.13.netfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.13.netfs

----------------------------------------------------------------
Baokun Li (1):
      cachefiles: fix dentry leak in cachefiles_open_file()

Christian Brauner (3):
      pidfs: check for valid pid namespace
      Merge patch series "Random netfs folio fixes"
      Merge patch series "fscache/cachefiles: Some bugfixes"

David Howells (5):
      afs: Fix missing wire-up of afs_retry_request()
      afs: Fix the setting of the server responding flag
      netfs: Advance iterator correctly rather than jumping it
      netfs: Add folio_queue API documentation
      netfs: Fix the netfs_folio tracepoint to handle NULL mapping

Marc Dionne (1):
      afs: Fix possible infinite loop with unresponsive servers

Matthew Wilcox (Oracle) (3):
      netfs: Remove call to folio_index()
      netfs: Fix a few minor bugs in netfs_page_mkwrite()
      netfs: Remove unnecessary references to pages

Thorsten Blum (1):
      afs: Remove unused struct and function prototype

Zizhi Wo (5):
      cachefiles: Fix incorrect length return value in cachefiles_ondemand_fd_write_iter()
      cachefiles: Fix missing pos updates in cachefiles_ondemand_fd_write_iter()
      cachefiles: Clean up in cachefiles_commit_tmpfile()
      cachefiles: Fix NULL pointer dereference in object->file
      netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING

 Documentation/core-api/folio_queue.rst | 212 +++++++++++++++++++++++++++++++++
 fs/afs/afs_vl.h                        |   9 --
 fs/afs/file.c                          |   1 +
 fs/afs/fs_operation.c                  |   2 +-
 fs/afs/fs_probe.c                      |   4 +-
 fs/afs/rotate.c                        |  11 +-
 fs/cachefiles/interface.c              |  14 ++-
 fs/cachefiles/namei.c                  |  12 +-
 fs/cachefiles/ondemand.c               |  38 ++++--
 fs/netfs/buffered_read.c               |   8 +-
 fs/netfs/buffered_write.c              |  41 ++++---
 fs/netfs/fscache_volume.c              |   3 +-
 fs/netfs/write_issue.c                 |  12 +-
 fs/pidfs.c                             |   5 +-
 include/linux/folio_queue.h            | 168 ++++++++++++++++++++++++++
 include/trace/events/netfs.h           |   5 +-
 16 files changed, 475 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/core-api/folio_queue.rst

