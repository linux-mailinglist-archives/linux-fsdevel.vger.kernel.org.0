Return-Path: <linux-fsdevel+bounces-34915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 865519CE0EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC58286DF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33861CEAD3;
	Fri, 15 Nov 2024 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/FB86j2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE8C1B2EEB;
	Fri, 15 Nov 2024 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679628; cv=none; b=LEn1LOuq60MGuH42GwXXjeHqvI5KripOEl4SbeyWIM3GC7KdcKIJX0kwn+HyMoeHzCb/G/nU8Wt/oL5A/6e/LPK9w/LWbamSKdmtLMHIOIZR+hqM3tn84ilCfUJ/yEN9j/KVwxlkSQZNyG3Xf8kQf8ObVbbPA/69UN57nwzlFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679628; c=relaxed/simple;
	bh=RkTFKO6z/WdNArxgzUdqGkoMijACjNagUaJaGPZzzYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A5VjnYeiiKQaaM3Tb2AfVOMtoK90q99vc/BShdUQXU8bfT+l4hKzKRkzUYaJoAodliiTNkx3vnOJFk2crTfShqVsimFKkdHdgMaHqds/55oPVtGSMjGlC/S6AQkGRN0OthMwNIVn+luUMrd0znf949FMbGJKUfUiW3irvCGU91A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/FB86j2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CCEC4CECF;
	Fri, 15 Nov 2024 14:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731679626;
	bh=RkTFKO6z/WdNArxgzUdqGkoMijACjNagUaJaGPZzzYA=;
	h=From:To:Cc:Subject:Date:From;
	b=i/FB86j2Zw/cXtXYi5hKp8tf5TARedXUBNU9Jxq85Rj4uyEb5L+rki+z0d9p1qs7Y
	 0Z2bniNF4b8lQgHJtDk8smgLm7pB1ktxKnzx3Relhhqe15A8h1auAud0qEqikWam+6
	 tNFaTmBE982PCbciFjlxI2s25jeijp6HD93KWU2Qsu8ZkaxWculk02jrHb64opOfEw
	 COLlrmmv2Sc0LsNUUXyte3t5KMYBMDKqmy3UVTJbhDUwXiwIN0pPcgSTKywycHf5X2
	 daaspjXPxgee/+/n6BGBHPQVWbnZF4vMeCbxs8WP4FI8NygAtlBydx/LztjHoE/Da/
	 lmRUPY5K4MmRw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs tmpfs
Date: Fri, 15 Nov 2024 15:06:58 +0100
Message-ID: <20241115-vfs-tmpfs-d443d413eb26@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4454; i=brauner@kernel.org; h=from:subject:message-id; bh=RkTFKO6z/WdNArxgzUdqGkoMijACjNagUaJaGPZzzYA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSbh7a6dzXIfe6c93BB6KwPggYBMdvyvoXXJ223v1ljv nln4NOajlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl802FkOH9x0yyhwON1z2xW nBKbdvDZtFMiq98X7N70+KrzFN6vTFMY/md0LDwsOuNAs2rA7RdFGx5u0shiqtzjb/w8ZPNNxmi pbXwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This adds case-insensitive support for tmpfs.

The work contained in here adds support for case-insensitive file names
lookups in tmpfs. The main difference from other casefold filesystems is
that tmpfs has no information on disk, just on RAM, so we can't use mkfs
to create a case-insensitive tmpfs. For this implementation, there's a
mount option for casefolding. The rest of the patchset follows a similar
approach as ext4 and f2fs.

The use case for this feature is similar to the use case for ext4, to
better support compatibility layers (like Wine), particularly in
combination with sandboxing/container tools (like Flatpak).

Those containerization tools can share a subset of the host filesystem
with an application. In the container, the root directory and any parent
directories required for a shared directory are on tmpfs, with the
shared directories bind-mounted into the container's view of the
filesystem.

If the host filesystem is using case-insensitive directories, then the
application can do lookups inside those directories in a
case-insensitive way, without this needing to be implemented in
user-space. However, if the host is only sharing a subset of a
case-insensitive directory with the application, then the parent
directories of the mount point will be part of the container's root
tmpfs. When the application tries to do case-insensitive lookups of
those parent directories on a case-sensitive tmpfs, the lookup will
fail.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.12-rc4 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

This will have a minor merge conflict with the vfs-6.13.file pull request I
sent as:

https://lore.kernel.org/r/20241115-vfs-file-f2297d7c58ee@brauner

The resolution for the conflict should look like this:

diff --cc include/linux/fs.h
index 3e53ba079f17,001d580af862..eae7ce884030
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@@ -45,7 -45,7 +45,8 @@@
  #include <linux/slab.h>
  #include <linux/maple_tree.h>
  #include <linux/rw_hint.h>
 +#include <linux/file_ref.h>
+ #include <linux/unicode.h>

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.tmpfs

for you to fetch changes up to 552b15103db404c7971d4958e6e28d4e7123a325:

  Merge patch series "tmpfs: Casefold fixes" (2024-11-06 11:22:30 +0100)

Please consider pulling these changes from the signed vfs-6.13.tmpfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.13.tmpfs

----------------------------------------------------------------
André Almeida (12):
      libfs: Create the helper function generic_ci_validate_strict_name()
      ext4: Use generic_ci_validate_strict_name helper
      unicode: Export latest available UTF-8 version number
      unicode: Recreate utf8_parse_version()
      libfs: Export generic_ci_ dentry functions
      tmpfs: Add casefold lookup support
      tmpfs: Add flag FS_CASEFOLD_FL support for tmpfs dirs
      tmpfs: Expose filesystem features via sysfs
      docs: tmpfs: Add casefold options
      libfs: Fix kernel-doc warning in generic_ci_validate_strict_name
      tmpfs: Fix type for sysfs' casefold attribute
      tmpfs: Initialize sysfs during tmpfs init

Christian Brauner (2):
      Merge patch series "tmpfs: Add case-insensitive support for tmpfs"
      Merge patch series "tmpfs: Casefold fixes"

 Documentation/filesystems/tmpfs.rst |  24 ++++
 fs/ext4/namei.c                     |   5 +-
 fs/libfs.c                          |  12 +-
 fs/unicode/utf8-core.c              |  26 ++++
 fs/unicode/utf8-selftest.c          |   3 -
 include/linux/fs.h                  |  49 +++++++
 include/linux/shmem_fs.h            |   6 +-
 include/linux/unicode.h             |   4 +
 mm/shmem.c                          | 265 ++++++++++++++++++++++++++++++++++--
 9 files changed, 371 insertions(+), 23 deletions(-)

