Return-Path: <linux-fsdevel+bounces-44779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C108A6C91D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100BB162F0C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD031FA16B;
	Sat, 22 Mar 2025 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIWNt8hA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E481F873F;
	Sat, 22 Mar 2025 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638628; cv=none; b=iR2r+bpjJG45vnYp6FlJkdzUQxQ0w4XHgBeUjwGlYzCS5RShEO3bctFatN/PluiC2AcbUJh+4o4qZjIuJl/DcBw+jweZVq7W306NEkNLlJlLg4LSEgje/tr39KVi6ddhLqHVmfTU24Vu+7O0gkA92TKYgvnKLdb3IR18E4k55lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638628; c=relaxed/simple;
	bh=3xuxwh+CueyFfPpQQs3pg7eumKBMyuCZZwPEXiRhvz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1S5dI0MVj/Y0Sx+BS588KLIGB0sEGrazELmresykvd211ISkOtSngjEMes7uqCzK8kvPFWYBMALvVERhYS+GCwEtuGZ2bNnHp30rmbgK8ovGT6ElUARkKXNl1LGv5CsX2lKqKK78f8p8/z/dJIMwu4aS0l+cIJeF6f/GKfIg3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIWNt8hA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232B0C4CEDD;
	Sat, 22 Mar 2025 10:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638628;
	bh=3xuxwh+CueyFfPpQQs3pg7eumKBMyuCZZwPEXiRhvz0=;
	h=From:To:Cc:Subject:Date:From;
	b=OIWNt8hAqfbec/073Tq8NzYLjO7XUCynkUTcfE65IjKo3I6ph4RjtaPGWrbruGJl4
	 VqJqCRyOjYrHoeLi7aGoI+431bS5RS7z/nJnlBcSEBgBF9tnd2OpESvrCzcK/veomn
	 PNCTrQcBgST4RDjA5iGuku9V7zY9RwfqSxxGqnUggJCqNqOQw0LfRtq90SzH/BFIR/
	 eeXDkpePJVPoz5EqCOqDS5g/XYMlZL/dpJBt8sfw7hJhXimq4vvmkDzcGvNXF6II3C
	 ZvkY5bGDlGOdNGCkd4ZMdat238AfqR6bNS2VN22HMODhYmPFSh38zKHRVNdVa+DqMJ
	 n1SvtJLluRP3g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs initramfs
Date: Sat, 22 Mar 2025 11:17:01 +0100
Message-ID: <20250322-vfs-initramfs-ebb99cbb53cd@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2329; i=brauner@kernel.org; h=from:subject:message-id; bh=3xuxwh+CueyFfPpQQs3pg7eumKBMyuCZZwPEXiRhvz0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf65N13czweaa3o9vTgJWtkpEGAqturdi3orhuzQp59 eJos2sdHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNxN2b478/ywrn9SPinp4lZ 7fsdWs697m7fuMXbpvi55fVzIXsyDzD8M5Psfj+jve2zvljEtTyrM6f+HZjeJ2G6iG+pb/cRzZM /mAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This adds basic kunit test coverage for initramfs unpacking and cleans
up some buffer handling issues and inefficiencies.

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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.initramfs

for you to fetch changes up to 0054b437c0ec5732851e37590c56d920319f58ad:

  MAINTAINERS: append initramfs files to the VFS section (2025-03-18 15:13:58 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.initramfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.initramfs

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "initramfs: kunit tests and cleanups"

David Disseldorp (9):
      init: add initramfs_internal.h
      initramfs_test: kunit tests for initramfs unpacking
      vsprintf: add simple_strntoul
      initramfs: avoid memcpy for hex header fields
      initramfs: allocate heap buffers together
      initramfs: reuse name_len for dir mtime tracking
      initramfs: fix hardlink hash leak without TRAILER
      initramfs: avoid static buffer for error message
      MAINTAINERS: append initramfs files to the VFS section

 MAINTAINERS               |   3 +
 include/linux/kstrtox.h   |   1 +
 init/.kunitconfig         |   3 +
 init/Kconfig              |   7 +
 init/Makefile             |   1 +
 init/initramfs.c          |  66 ++++----
 init/initramfs_internal.h |   8 +
 init/initramfs_test.c     | 407 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/vsprintf.c            |   7 +
 9 files changed, 475 insertions(+), 28 deletions(-)
 create mode 100644 init/.kunitconfig
 create mode 100644 init/initramfs_internal.h
 create mode 100644 init/initramfs_test.c

