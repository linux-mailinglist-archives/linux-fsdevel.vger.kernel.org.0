Return-Path: <linux-fsdevel+bounces-50313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3504AACAC50
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 12:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5129F3AF024
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 10:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BC11FDA8B;
	Mon,  2 Jun 2025 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mo3+58x5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED1E2D7BF;
	Mon,  2 Jun 2025 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748859102; cv=none; b=HnULxRakYaDItaLAf6/nCDmWqXwfR2s5T11mhLlrcvcdOqnYMYl+GRqnZqdOfweRrNNVx8se47lKmTZkFNF7rY5/WQH3IekQ+76QIAzydYxZYGBZHSGTJex6HW0ydnQfrIDYaNIR296loKDOuPN3DE/dbokX1EW7jdh66ATrTK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748859102; c=relaxed/simple;
	bh=vr2Iavl3s/JtJluwNUIZpU0je/LfAgUbPmUBZ0xpPXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7IGbaqd51l3NdKpp47UGDlvdNgQE6iJTXElBEw3Dy6SbiqJLE+Y8zhB2sBDLYOJX7nssxDxUOVxz+VdWKPHQImYCaxahddRLPJFRH1aEahKOWvZYk+VgERsCaJR3bfuhMdUefn68VOH0tR9ESPQN7wsd3kPvNvS6G5zdV8vWZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mo3+58x5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A3AC4CEF1;
	Mon,  2 Jun 2025 10:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748859101;
	bh=vr2Iavl3s/JtJluwNUIZpU0je/LfAgUbPmUBZ0xpPXw=;
	h=From:To:Cc:Subject:Date:From;
	b=Mo3+58x5xrjoMldRqAduaSKIx+bV7lQte0B0DfKZpt9lXVpvpXgu7eQJoWe2nVXOQ
	 a7CsbwVHJ4apwrxeXXrFGXOYDxS926WJ3X5Jx+rOu95UJbcNrIUnGqD2NCsZ3R0P4q
	 iC/pyT0L/Hqu2GeFjWBwpo4tDuuygV8SvQ0rdPqywq3YjwmYA2sM3qg0iNEroGJCFp
	 mBlRR4HJTcrfJnpGLKq+vt3234Glho0tYxmktvsiRr2SWqWv/jyyyBX1RNcCkGA5hp
	 rOQII+tj4HM2pLWVQtiCboatltZqcLcKOxYYZL5ijnUb69VF52qS4UepvmSZ76hIUx
	 NWmyJvtxJJcCg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs netfs
Date: Mon,  2 Jun 2025 12:11:31 +0200
Message-ID: <20250602-vfs-netfs-bf063d178ff0@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5673; i=brauner@kernel.org; h=from:subject:message-id; bh=vr2Iavl3s/JtJluwNUIZpU0je/LfAgUbPmUBZ0xpPXw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTYVtxIPr7dle/K5BsqInPSVd5/C0jNEEk8sfHesgPxH 9YzfMox7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIuUkM/yt2x2+ZMWFX3JuV lx/oBli0Z3Lyn0nnm3x+oc33HSlFH00Z/ikIbXGq7tokfOe1wCrPPu2pLp8W/k9btMg1Wzr3mi9 jKgsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

A quick word on the general timing for netfs pull requests going
forward. In contrast to most of the other work I tend to send the netfs
updates a little later and will probably continue to do so in the
future. In the past we had some issues with late-stage fixes or there
were complicated merge conflicts with other trees or mainline that were
a little unusal. So since there's more jitter in how consistently this
tree can be carried through a cycle I'm letting this reflect in the pull
request timing as well.

/* Summary */

This contains the netfs updates for this cycle:

- The main API document has been extensively updated/rewritten.

- Fix an oops in write-retry due to mis-resetting the I/O iterator.

- Fix the recording of transferred bytes for short DIO reads.

- Fix a request's work item to not require a reference, thereby avoiding
  the need to get rid of it in BH/IRQ context.

- Fix waiting and waking to be consistent about the waitqueue used.

- Remove NETFS_SREQ_SEEK_DATA_READ.

- Remove NETFS_INVALID_WRITE.

- Remove NETFS_ICTX_WRITETHROUGH.

- Remove NETFS_READ_HOLE_CLEAR.

- Reorder structs to eliminate holes.

- Remove netfs_io_request::ractl.

- Only provide proc_link field if CONFIG_PROC_FS=y.

- Remove folio_queue::marks3.

- Remove NETFS_RREQ_DONT_UNLOCK_FOLIOS.

- Remove NETFS_RREQ_BLOCKED.

- Fix undifferentiation of DIO reads from unbuffered reads.

generally sent
after vfs-6.16-rc1.misc

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

The following changes since commit f1745496d3fba34a2e16ef47d78903d7208c1214:

  netfs: Update main API document (2025-04-11 15:23:50 +0200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.netfs

for you to fetch changes up to db26d62d79e4068934ad0dccdb92715df36352b9:

  netfs: Fix undifferentiation of DIO reads from unbuffered reads (2025-05-23 10:35:03 +0200)

Please consider pulling these changes from the signed vfs-6.16-rc1.netfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.16-rc1.netfs

----------------------------------------------------------------
Christian Brauner (3):
      Merge netfs API documentation updates
      Merge patch series "netfs: Miscellaneous cleanups"
      Merge patch series "netfs: Miscellaneous fixes"

David Howells (4):
      netfs: Fix oops in write-retry from mis-resetting the subreq iterator
      netfs: Fix the request's work item to not require a ref
      netfs: Fix wait/wake to be consistent about the waitqueue used
      netfs: Fix undifferentiation of DIO reads from unbuffered reads

Max Kellermann (10):
      fs/netfs: remove unused flag NETFS_SREQ_SEEK_DATA_READ
      fs/netfs: remove unused source NETFS_INVALID_WRITE
      fs/netfs: remove unused flag NETFS_ICTX_WRITETHROUGH
      fs/netfs: remove unused enum choice NETFS_READ_HOLE_CLEAR
      fs/netfs: reorder struct fields to eliminate holes
      fs/netfs: remove `netfs_io_request.ractl`
      fs/netfs: declare field `proc_link` only if CONFIG_PROC_FS=y
      folio_queue: remove unused field `marks3`
      fs/netfs: remove unused flag NETFS_RREQ_DONT_UNLOCK_FOLIOS
      fs/netfs: remove unused flag NETFS_RREQ_BLOCKED

Paulo Alcantara (1):
      netfs: Fix setting of transferred bytes with short DIO reads

 Documentation/core-api/folio_queue.rst      |   3 -
 Documentation/filesystems/netfs_library.rst |   5 -
 fs/9p/vfs_addr.c                            |   5 +-
 fs/afs/write.c                              |   9 +-
 fs/cachefiles/io.c                          |  16 +-
 fs/ceph/addr.c                              |   6 +-
 fs/erofs/fscache.c                          |   6 +-
 fs/netfs/buffered_read.c                    |  56 ++++---
 fs/netfs/buffered_write.c                   |   5 +-
 fs/netfs/direct_read.c                      |  16 +-
 fs/netfs/direct_write.c                     |  12 +-
 fs/netfs/fscache_io.c                       |  10 +-
 fs/netfs/internal.h                         |  42 ++++--
 fs/netfs/main.c                             |   1 +
 fs/netfs/misc.c                             | 219 ++++++++++++++++++++++++++++
 fs/netfs/objects.c                          |  48 +++---
 fs/netfs/read_collect.c                     | 199 +++++--------------------
 fs/netfs/read_pgpriv2.c                     |   4 +-
 fs/netfs/read_retry.c                       |  26 +---
 fs/netfs/read_single.c                      |   6 +-
 fs/netfs/write_collect.c                    |  83 ++++-------
 fs/netfs/write_issue.c                      |  38 ++---
 fs/netfs/write_retry.c                      |  19 +--
 fs/nfs/fscache.c                            |   1 +
 fs/smb/client/cifsproto.h                   |   3 +-
 fs/smb/client/cifssmb.c                     |   4 +-
 fs/smb/client/file.c                        |  10 +-
 fs/smb/client/smb2pdu.c                     |   4 +-
 include/linux/folio_queue.h                 |  42 ------
 include/linux/fscache.h                     |   5 +-
 include/linux/netfs.h                       |  45 +++---
 include/trace/events/netfs.h                |  11 +-
 net/9p/client.c                             |   6 +-
 33 files changed, 478 insertions(+), 487 deletions(-)

