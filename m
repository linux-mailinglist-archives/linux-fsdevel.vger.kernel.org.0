Return-Path: <linux-fsdevel+bounces-70161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B59C92A52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28E1134641A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17352EF652;
	Fri, 28 Nov 2025 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNliKIwa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456C12EC55C;
	Fri, 28 Nov 2025 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348688; cv=none; b=PA6bAQcsYS7+6dNaeA73UcEw/YZJx2SnQGmz1qtY00Zmc9TDi2C6gUjVX9hlGk0i6nsXIEHVk9Ck1pirZhmrTVK28ZzxLFkxezt8PYME0jYMhqJbhBGhqs0u56yWHpvbXtcZbQU328m1e7IMh0vzRQMQsDlzjFW/YVn22EXtGUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348688; c=relaxed/simple;
	bh=SWVvEzngi+rqHJUrahhDQk0H9f2ewg68J0eKkS5Qtfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rz5ZDUOCmaN4ojd0gsQd6qDXCA2/8hQl6TW16P2/bLl1T/sp8yo0fRwDJBeuhXYUDbDm7Rb9JiiBN27HM+VOSC0qUGomMBsi53q9U8c9qLo72JQJQ4SsA2ocD8Pee+5Fy3Q6OsImwamNrz6BwQyMLl/Db3rx8PShigjMmeKurz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNliKIwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13BFC4CEFB;
	Fri, 28 Nov 2025 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348687;
	bh=SWVvEzngi+rqHJUrahhDQk0H9f2ewg68J0eKkS5Qtfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNliKIwawW1kOujpUKLYsvsJmgWkSvLCPzGn5YIjM/lr2BGrTuHATEE9q3QXeEgyR
	 uEVMpHWUbNlO4s1WzN5tW2ZU6PBTWbjG+YUqBAGQ3M3JPfCZ3TIY2EULytsytqnr71
	 UTt3s6T+2sYl0fmlnHn8ExstXGAKhpGgyLY8rBAbPBdYMBxcrJCSykT8gL/eUh22qO
	 PkNbeabSfB28n5PVNKyoys1D8UV/Otjw/ctZczwbKIAnmZ97ke+uGh6d9ZWOJVxrSY
	 k0WHZTl3RZ1cE3UhBFv8S6UO9Yd9ZkJgmkgLGCrJkacIUFi4kesjdep9NHX45/lumg
	 cSxdtN0WiQW8w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 11/17 for v6.19] minix
Date: Fri, 28 Nov 2025 17:48:22 +0100
Message-ID: <20251128-kernel-minix-v619-c288851ff1cb@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128-vfs-v619-77cd88166806@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2082; i=brauner@kernel.org; h=from:subject:message-id; bh=SWVvEzngi+rqHJUrahhDQk0H9f2ewg68J0eKkS5Qtfw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXnqc/6PjyYNcSZPKtF9/KoXTl23vzeDI1Ux6vGhfa mnNXpm8jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlMyWBk2G06+cTepz8KTzLZ vWU7ZFPU8KEqxTT8c3uitb5b8sTbuYwMr/fu+ajpn3r350G+uG9P75Ts8Nn17K2e5gKta7H7DUN vsgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
Fix two syzbot corruption bugs in the minix filesystem. Syzbot fuzzes
filesystems by trying to mount and manipulate deliberately corrupted
images. This should not lead to BUG_ONs and WARN_ONs for easy to detect
corruptions.

- Add error handling to minix filesystem for inode corruption detection,
  enabling the filesystem to report such corruptions cleanly.

- Fix a drop_nlink warning in minix_rmdir() triggered by corrupted
  directory link counts.

- Fix a drop_nlink warning in minix_rename() triggered by corrupted
  inode link counts.

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

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.minix

for you to fetch changes up to 0d534518ce87317e884dbd1485111b0f1606a194:

  Merge patch series "Fix two syzbot corruption bugs in minix filesystem" (2025-11-05 13:45:26 +0100)

Please consider pulling these changes from the signed vfs-6.19-rc1.minix tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.19-rc1.minix

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "Fix two syzbot corruption bugs in minix filesystem"

Jori Koolstra (3):
      Add error handling to minix filesystem for inode corruption detection
      Fix a drop_nlink warning in minix_rmdir
      Fix a drop_nlink warning in minix_rename

 fs/minix/inode.c | 16 ++++++++++++++++
 fs/minix/minix.h |  9 +++++++++
 fs/minix/namei.c | 39 ++++++++++++++++++++++++++++++++-------
 3 files changed, 57 insertions(+), 7 deletions(-)

