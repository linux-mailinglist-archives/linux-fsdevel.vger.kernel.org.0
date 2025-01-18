Return-Path: <linux-fsdevel+bounces-39586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA13DA15D20
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 14:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3878F188722D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 13:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4777B18C92F;
	Sat, 18 Jan 2025 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apbtAnoe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B7EA95C;
	Sat, 18 Jan 2025 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737205702; cv=none; b=XXmSLsbh4UMYNJeDLM21lQ/BR8tHXRcSGVAYw687pOjjQusn68SxUxleLfnMochSwrPHNdCHhrFc5zrimBKfBD1FILi0ue2Us+32+5HCUc0jXvCWnJs9SSjoas+sHfR+ulnXaEt5tBXw3aHUFRQLWGCzKWJMedP0aaLB7s37W3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737205702; c=relaxed/simple;
	bh=DecL60QrxRCbb94xW104uUHzC8TLd8HIprT3p6DeGTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NfIQzcc3TWzvJHfcPThzLHHntQrvaOQi6ABM9H+13nuSTWy828vOTRsCIplIyGIF54JOXvvZpw8Cr+IuHOpUivN99a2ReN6Xpblgw35rrzWP3fC78BnhuKYp3/ovsoiuM7mNWRcDbb5NNUcUAoyeGDICrPzbZp949vO/L0NAPMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apbtAnoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4526C4CED1;
	Sat, 18 Jan 2025 13:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737205702;
	bh=DecL60QrxRCbb94xW104uUHzC8TLd8HIprT3p6DeGTM=;
	h=From:To:Cc:Subject:Date:From;
	b=apbtAnoetEN485XlIGC0afgffI5jeZYTXrP1na3IcMxy902xhqDuisDohCSQD5A1C
	 k71W+dsF03ES1Jsh9+NicU3YEIhKtOTW3SVwDxr6LchtqCyvLg20BYKyR82Pm7Ff5h
	 lz9UcMSdCizmmk1dL7GiiEb9XTFC+IhMH08VUIL0YeHdD50Wf+J02Vv5M5cXJCrcKs
	 a8QB8j0E45ydxUCTgs6SkzgCEc0EE4p9kTPYP/ACjn/2mRnslC5LR6ePKEsvbHOr+v
	 n892KR86EKL1OGmqVJDGKLAeT6btCeNkMKTFqwsLWE6kok11WeADGj/AYNyRGYNiLd
	 Oro4Eu69ZzeZQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs libfs
Date: Sat, 18 Jan 2025 14:08:14 +0100
Message-ID: <20250118-vfs-libfs-675d6c542bcc@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3808; i=brauner@kernel.org; h=from:subject:message-id; bh=DecL60QrxRCbb94xW104uUHzC8TLd8HIprT3p6DeGTM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR3L98vfParVXPB3g0fXp14dHWVudWUxfoaq1K6n2ake Mhe/fHYtKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BeAiKxkZXs+e0qKRcfuy6fb3 a3suru9QFZObtGX7O0/fbalCxx/vq2T4X/RJbYZYvcXcn3pzX7sprz1huDhHU18xtKAv3O/Mtpn 6rAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This improves the stable directory offset behavior in various ways.
Stable offsets are needed so that NFS can reliably read directories on
filesystems such as tmpfs:

- Improve the end-of-directory detection

  According to getdents(3), the d_off field in each returned directory
  entry points to the next entry in the directory. The d_off field in
  the last returned entry in the readdir buffer must contain a valid
  offset value, but if it points to an actual directory entry, then
  readdir/getdents can loop.

  Introduce a specific fixed offset value that is placed in the d_off
  field of the last entry in a directory. Some user space applications
  assume that the EOD offset value is larger than the offsets of real
  directory entries, so the largest valid offset value is reserved for
  this purpose. This new value is never allocated by
  simple_offset_add().

  When ->iterate_dir() returns, getdents{64} inserts the ctx->pos value
  into the d_off field of the last valid entry in the readdir buffer.
  When it hits EOD, offset_readdir() sets ctx->pos to the EOD offset
  value so the last entry is updated to point to the EOD marker.

  When trying to read the entry at the EOD offset, offset_readdir()
  terminates immediately.

- Rely on d_children to iterate stable offset directories

  Instead of using the mtree to emit entries in the order of their
  offset values, use it only to map incoming ctx->pos to a starting
  entry. Then use the directory's d_children list, which is already
  maintained properly by the dcache, to find the next child to emit.

- Narrow the range of directory offset values returned by
  simple_offset_add() to 3 .. (S32_MAX - 1) on all platforms. This means
  the allocation behavior is identical on 32-bit systems, 64-bit
  systems, and 32-bit user space on 64-bit kernels. The new range still
  permits over 2 billion concurrent entries per directory.

- Return ENOSPC when the directory offset range is exhausted. Hitting
  this error is almost impossible though.

- Remove the simple_offset_empty() helper.

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

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.libfs

for you to fetch changes up to a0634b457eca16b21a4525bc40cd2db80f52dadc:

  Merge patch series "Improve simple directory offset wrap behavior" (2025-01-04 10:15:58 +0100)

Please consider pulling these changes from the signed vfs-6.14-rc1.libfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.14-rc1.libfs

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "Improve simple directory offset wrap behavior"

Chuck Lever (5):
      libfs: Return ENOSPC when the directory offset range is exhausted
      Revert "libfs: Add simple_offset_empty()"
      Revert "libfs: fix infinite directory reads for offset dir"
      libfs: Replace simple_offset end-of-directory detection
      libfs: Use d_children list to iterate simple_offset directories

 fs/libfs.c         | 162 +++++++++++++++++++++++++----------------------------
 include/linux/fs.h |   1 -
 mm/shmem.c         |   4 +-
 3 files changed, 79 insertions(+), 88 deletions(-)

