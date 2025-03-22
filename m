Return-Path: <linux-fsdevel+bounces-44781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB57A6C927
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC001890146
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7DC1FDE20;
	Sat, 22 Mar 2025 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3CSl9ev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E4B1FCCFB;
	Sat, 22 Mar 2025 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638650; cv=none; b=YF9w2X2vGzqbvlODR+BOM5gJ3RtuzWDN7mzWplPD+z78facAj6oePsG+xQoNwxfc5bYewrmb23qbfnX7CS6MlzDb8DKWM9wOzsk6DNoSWFZRmjOC42TzZeWWadc1FJgKCp4TwJoXN/+V6qp+EowXra6xSRZgCYYUp+AWrCUZwlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638650; c=relaxed/simple;
	bh=nyFzoVPFSb4tX5YtEg6piSwuFDhzGyMxC2OfzGSUCEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQyWf7mwLbXa1HazObV2WlNxmkm/l4wyM6xUECmxmBeqM6O15w/JJbY2kuEME6vmrzQ1d8JTaf9gd8W12JymF5BoDlXP0XgvhVtPU/j4wbeX0MMWBlZKXl27kNOg/tZaPPKV1rSD6LFLJgcJWa54Yeqr9po59z/9P+4su4/OOpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3CSl9ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E492EC4CEEC;
	Sat, 22 Mar 2025 10:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638650;
	bh=nyFzoVPFSb4tX5YtEg6piSwuFDhzGyMxC2OfzGSUCEE=;
	h=From:To:Cc:Subject:Date:From;
	b=a3CSl9evmO1mtGRA3KEl1Vl6SOaYjtBOgmKY3KP1lUGRo+XI3lE5rgeSoam0hZUc7
	 ms3p1KUZT1jLEjBNNqxGsZgQBkY9pPBwfaD+nOogMXTu77zPqZp21cHqC5WSoEkUk8
	 SiauoRGUkSS/boUdhsGcWN5uTmIUrEiLg/m+DtGr+oD0h75jEwQETjStlTO7yqk7YN
	 R2urfsrM5z3CL4w/M6vRfyzK8QK+Qn7PRc30nc9IjBVoJXzuhXgF3fVHOW8vO31Gqg
	 sI7Rg+WQsHbI+KzLI/F7caQ3TW0FDYNWozIQiSpOCFbbEee0DynXnyZe1JdTdUzWdB
	 ZSZN/jEMtJzRA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs orangefs
Date: Sat, 22 Mar 2025 11:17:23 +0100
Message-ID: <20250322-vfs-orangefs-b012666207bd@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2145; i=brauner@kernel.org; h=from:subject:message-id; bh=nyFzoVPFSb4tX5YtEg6piSwuFDhzGyMxC2OfzGSUCEE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf6zMxmln52LHwiETAmgc3I51+VG3emFqbrt/bY/C7r P16feLVjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImUnWdkuH/GVi1jbsraNQ/r PjM8vLRzD8fvv1zNM8SP7W1k+zD9WhTDbzbTw6m7WrexF6/wK8iRXaB476vv7bVsU+5L/8xdeOj DX2YA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains the work to remove orangefs_writepage() and partially
convert it to folios. A few regular bugfixes are included as well.

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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.orangefs

for you to fetch changes up to 215434739c3b719882f0912a58d8d7294fd7ff71:

  Merge patch series "Orangefs fixes for 6.15" (2025-03-06 09:26:13 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.orangefs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.orangefs

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "Orangefs fixes for 6.15"

Matthew Wilcox (Oracle) (9):
      orangefs: Do not truncate file size
      orangefs: Move s_kmod_keyword_mask_map to orangefs-debugfs.c
      orangefs: make open_for_read and open_for_write boolean
      orangefs: Remove orangefs_writepage()
      orangefs: Convert orangefs_writepage_locked() to take a folio
      orangefs: Pass mapping to orangefs_writepages_work()
      orangefs: Unify error & success paths in orangefs_writepages_work()
      orangefs: Simplify bvec setup in orangefs_writepages_work()
      orangefs: Convert orangefs_writepages to contain an array of folios

 fs/orangefs/file.c             |   4 +-
 fs/orangefs/inode.c            | 149 ++++++++++++++++++-----------------------
 fs/orangefs/orangefs-debug.h   |  43 ------------
 fs/orangefs/orangefs-debugfs.c |  43 ++++++++++++
 4 files changed, 109 insertions(+), 130 deletions(-)

