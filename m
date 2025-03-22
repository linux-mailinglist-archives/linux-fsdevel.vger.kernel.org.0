Return-Path: <linux-fsdevel+bounces-44778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97538A6C921
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 303AE7AA088
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923A21FBC9A;
	Sat, 22 Mar 2025 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUvTTItZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42311F91C8;
	Sat, 22 Mar 2025 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638617; cv=none; b=o3BJKyVP6wU6PdMI6KSDgWCWlktoSML3fX1wZeDYuu456rK/dRY6tP119+pFEbTnNfSgX/Us0AhbVfhX8e2dLIlWK9yb4yvQ2BuV0ei/2mYwxdRBD9Q5dWfP2D78JkgrWdzyyPMS9elEoDONYglLSJGKRY/ClpK6rjglH9XfTQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638617; c=relaxed/simple;
	bh=Sz6AtnvxKhAT4RT/4KhJ6oj3ACyDWos/OlRX3KL8/Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GK3E1pA7S7OQhaTUCwgYPwxTMgbFNkcLX0P9JXh9IyBGQu9L6jsK828R/lsHswLhidObSXJzSF+GWymgZZnsLveixuEnN2yzoAB11/Gb9u9c0glxDebyBcDsYj0NqGooTbtr3C98CjKCAbL05YNCSnC6vgxYkZiB1yHNi3b+Wmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUvTTItZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C656C4CEDD;
	Sat, 22 Mar 2025 10:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638617;
	bh=Sz6AtnvxKhAT4RT/4KhJ6oj3ACyDWos/OlRX3KL8/Uk=;
	h=From:To:Cc:Subject:Date:From;
	b=qUvTTItZE6TFtOke9lljnPRnqx2Vl5H157+R/AEJ1NZinJSYxjBoG/nTQshTquP3C
	 ojdRgQhfaf6kDCd5QqCjYQmHGfkDXW+69fEofBWfW+yG7LSLmPJnpobUh9DHzA/XMb
	 nKJXeYuYmdaH2FN/qKF+RLT0Mjj72Hd8C9u7FjUEL5T6JovJWJUCUoeFh7p2yAHCgt
	 jHe+oTeoMt6kfPtkYJa+gEMalyQ/H5Iean0OQETz4pFlcVkokMfV7Hlrm5PBWF/swv
	 tQKPKthB+O4X0RYcLsl+0vi2KPnau+EBDCYdo15cPcDoX4RJcx6JjbWD+5758WyNa2
	 qcK7CzDKJLfhw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs afs
Date: Sat, 22 Mar 2025 11:16:49 +0100
Message-ID: <20250322-vfs-afs-1df149397a4e@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4980; i=brauner@kernel.org; h=from:subject:message-id; bh=Sz6AtnvxKhAT4RT/4KhJ6oj3ACyDWos/OlRX3KL8/Uk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf6xP5OUfWc3J9/ox9DRNu1/UlnxBn6C3ctMjg3keb8 63nPz2r7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIrKsM/30Wnp+/+o3di+P2 kbkrDlffn3re9utHz2ezX55LeHb1/tRWRoalWxtbWvUqNnmen+P7w6fmi8XKb7OKbY0mqW5+u8s v+Rw/AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains the work for afs for this cycle.

- Fix an occasional hang that's only really encountered when rmmod'ing
  the kafs module

- Remove the "-o autocell" mount option. This is obsolete with the dynamic
  root and removing it makes the next patch slightly easier.

- Change how the dynamic root mount is constructed. Currently, the root
  directory is (de)populated when it is (un)mounted if there are cells
  already configured and, further, pairs of automount points have to be
  created/removed each time a cell is added/deleted.

  This is changed so that readdir on the root dir lists all the known
  cell automount pairs plus the @cell symlinks and the inodes and
  dentries are constructed by lookup on demand.  This simplifies the
  cell management code.

- A few improvements to the afs_volume tracepoint.

- A few improvements to the afs_server tracepoint.

- Pass trace info into the afs_lookup_cell() function to allow the trace
  log to indicate the purpose of the lookup.

- Remove the 'net' parameter from afs_unuse_cell() as it's superfluous.

- In rxrpc, allow a kernel app (such as kafs) to store a word of
  information on rxrpc_peer records.

- Use the information stored on the rxrpc_peer record to point to the
  afs_server record.  This allows the server address lookup to be done
  away with.

- Simplify the afs_server ref/activity accounting to make each one
  self-contained and not garbage collected from the cell management work
  item.

- Simplify the afs_cell ref/activity accounting to make each one of
  these also self-contained and not driven by a central management work
  item.

  The current code was intended to make it such that a single timer for
  the namespace and one work item per cell could do all the work
  required to maintain these records.  This, however, made for some
  sequencing problems when cleaning up these records.  Further, the
  attempt to pass refs along with timers and work items made getting it
  right rather tricky when the timer or work item already had a ref
  attached and now a ref had to be got rid of.

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

The following changes since commit 823869e1e61607ab0d433de3c8abed221dc80a5e:

  afs: Fix afs_atcell_get_link() to handle RCU pathwalk (2025-03-10 09:46:53 +0000)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.afs

for you to fetch changes up to 58a5937d50d800e15a8fc3ab9103583fc7b49ebf:

  Merge tag 'afs-next-20250310' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs (2025-03-10 11:07:15 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.afs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.afs

----------------------------------------------------------------
Christian Brauner (1):
      Merge tag 'afs-next-20250310' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs

David Howells (10):
      afs: Remove the "autocell" mount option
      afs: Change dynroot to create contents on demand
      afs: Improve afs_volume tracing to display a debug ID
      afs: Improve server refcount/active count tracing
      afs: Make afs_lookup_cell() take a trace note
      afs: Drop the net parameter from afs_unuse_cell()
      rxrpc: Allow the app to store private data on peer structs
      afs: Use the per-peer app data provided by rxrpc
      afs: Fix afs_server ref accounting
      afs: Simplify cell record handling

 fs/afs/addr_list.c         |  50 ++++
 fs/afs/cell.c              | 437 ++++++++++++++------------------
 fs/afs/cmservice.c         |  82 +------
 fs/afs/dir.c               |   5 +-
 fs/afs/dynroot.c           | 486 +++++++++++++++---------------------
 fs/afs/fs_probe.c          |  32 ++-
 fs/afs/fsclient.c          |   4 +-
 fs/afs/internal.h          |  98 ++++----
 fs/afs/main.c              |  16 +-
 fs/afs/mntpt.c             |   5 +-
 fs/afs/proc.c              |  15 +-
 fs/afs/rxrpc.c             |   8 +-
 fs/afs/server.c            | 601 +++++++++++++++++++--------------------------
 fs/afs/server_list.c       |   6 +-
 fs/afs/super.c             |  25 +-
 fs/afs/vl_alias.c          |   7 +-
 fs/afs/vl_rotate.c         |   2 +-
 fs/afs/volume.c            |  15 +-
 include/net/af_rxrpc.h     |   2 +
 include/trace/events/afs.h |  83 ++++---
 net/rxrpc/ar-internal.h    |   1 +
 net/rxrpc/peer_object.c    |  30 ++-
 22 files changed, 906 insertions(+), 1104 deletions(-)

