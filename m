Return-Path: <linux-fsdevel+bounces-34912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEB79CE454
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F304B33430
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AD01CEAD6;
	Fri, 15 Nov 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XntV6thZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5731CCB4A;
	Fri, 15 Nov 2024 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679408; cv=none; b=uP8QNQenFFzBzCRJOhNoErLsHv5o5Qb0eSVQCKugOOdzKvgJ7iwpfATJ9l4E8b2bFg3OqQzfFSyzVIxpxlv7XQiUW13Pr/zOaMma6IDKUXFfo/9Ip44+CoVN4oynKwK8WfevxPpWA0bhTOd9L6i5KWQFvIwDGYlZdpnF5WH63d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679408; c=relaxed/simple;
	bh=XeDs5QA2sg9YG75VYRMH1X9FGpbkIoqjZOHEw3AoYgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L0OOiW+FSQbLhZyXL5eu3mYcanV6DxbbWvs27tTfdzzLICgUWR0d5Tma23+PSbC6edCHLDpUAUYndQPkXdzZDQPVsnGXDPpz9SeKyCrLSZWn3DbKAhJY3Irsmc6fOMdTx3SzHw16pRGU20c7L2/Rz/L/sy4rYtUijJP79yQ3tXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XntV6thZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD89C4CECF;
	Fri, 15 Nov 2024 14:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731679407;
	bh=XeDs5QA2sg9YG75VYRMH1X9FGpbkIoqjZOHEw3AoYgY=;
	h=From:To:Cc:Subject:Date:From;
	b=XntV6thZ596RfUXH51w4Vk5ySs94DgCYr2NahZnAgEzQoxx5Bx5RSU+9lCOabnTbL
	 DpSbMpqWNqBfaQl9lzl8U9kA3Wv6zZs7Jt3SCDbWC/ebh1vg+ipOfRBk7iMiK6j11Q
	 nlOO0sGdYxVJbUag02BqF6+4GQK61TCcGUYc4w+MajCoyawMqOqrJE62o4t/+zc1u/
	 cQtSf4MisVUTWJOEArf9i3Ha5NzT4MutW84ttELR10fwUjAztncslR714H9S3zzMGC
	 E7OOy4pQud2JD3/3yRsCZ4zFZI2NQkuCxFwcsagpLUdQr/wQ+/IhI6K4CVPKDPgvw/
	 whc6fVdwgp/Qg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs overlayfs
Date: Fri, 15 Nov 2024 15:03:18 +0100
Message-ID: <20241115-vfs-ovl-7166080bd558@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3335; i=brauner@kernel.org; h=from:subject:message-id; bh=XeDs5QA2sg9YG75VYRMH1X9FGpbkIoqjZOHEw3AoYgY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSbh6xYnnaA+2W50P996o821c/y/C/Y8H9RVs8TxZdbD pXqfF3/paOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiW9oZGfa7abD7JR/d7M9j EvLVvHzD7Z25p4/G7JR+q/toTs+z4pMM//MOcx7krfDtfifznjsq/Nr0wpuvo/dMX7DueMehUqt j9/kA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

Make overlayfs support specifying layers through file descriptors.

Currently overlayfs only allows specifying layers through path names.
This is inconvenient for users that want to assemble an overlayfs mount
purely based on file descriptors:

This enables user to specify both:

    fsconfig(fd_overlay, FSCONFIG_SET_FD, "upperdir+", NULL, fd_upper);
    fsconfig(fd_overlay, FSCONFIG_SET_FD, "workdir+",  NULL, fd_work);
    fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower1);
    fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower2);

in addition to:

    fsconfig(fd_overlay, FSCONFIG_SET_STRING, "upperdir+", "/upper",  0);
    fsconfig(fd_overlay, FSCONFIG_SET_STRING, "workdir+",  "/work",   0);
    fsconfig(fd_overlay, FSCONFIG_SET_STRING, "lowerdir+", "/lower1", 0);
    fsconfig(fd_overlay, FSCONFIG_SET_STRING, "lowerdir+", "/lower2", 0);

There's also a large set of new overlayfs selftests to test new features
and some older properties.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.12-rc3 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.ovl

for you to fetch changes up to d59dfd625a8bae3bfc527dd61f24750c4f87266c:

  selftests: add test for specifying 500 lower layers (2024-10-15 14:39:35 +0200)

Please consider pulling these changes from the signed vfs-6.13.ovl tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.13.ovl

----------------------------------------------------------------
Christian Brauner (7):
      fs: add helper to use mount option as path or fd
      ovl: specify layers via file descriptors
      Documentation,ovl: document new file descriptor based layers
      selftests: use shared header
      selftests: add overlayfs fd mounting selftests
      Merge patch series "ovl: file descriptors based layer setup"
      selftests: add test for specifying 500 lower layers

 Documentation/filesystems/overlayfs.rst            |  17 ++
 fs/fs_parser.c                                     |  20 ++
 fs/overlayfs/params.c                              | 116 ++++++++---
 include/linux/fs_parser.h                          |   5 +-
 .../selftests/filesystems/overlayfs/.gitignore     |   1 +
 .../selftests/filesystems/overlayfs/Makefile       |   2 +-
 .../selftests/filesystems/overlayfs/dev_in_maps.c  |  27 +--
 .../filesystems/overlayfs/set_layers_via_fds.c     | 217 +++++++++++++++++++++
 .../selftests/filesystems/overlayfs/wrappers.h     |  47 +++++
 9 files changed, 399 insertions(+), 53 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
 create mode 100644 tools/testing/selftests/filesystems/overlayfs/wrappers.h

