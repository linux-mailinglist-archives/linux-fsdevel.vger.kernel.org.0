Return-Path: <linux-fsdevel+bounces-13994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF7C8761CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 11:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4D81C2154E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 10:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C4854BFE;
	Fri,  8 Mar 2024 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8bySy8z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84AC54BC9;
	Fri,  8 Mar 2024 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893158; cv=none; b=IfWYPrt+HqkC+Gq21bhMzgYcyShWXggeXR+lb9Uv3cDV1bmGUxAVBCRuEkDvxEVUX2VFR4c5PEoQ4dg1BH6M1Y7CdVAPsSzt3ng7i7tFY7qYZPOVNVnRtleeOCL4+Ga34iTWpsifsckH8jsXiPq3DLQa+ZqtKRpN5wecupXcxVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893158; c=relaxed/simple;
	bh=E/Q+GHdbHP3Gvf5ExMiosmeZbCccda9G4PEoZsYPqh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DiQoCCZQ7yxF4zqJgXi4t5mLEeCbO/LX+YWD0EqxHdk8QojhbYsr4Z/IzVAlLqWRHDbC/OIYpRIqnPKOjcT2k4qZsuNjBYKRj59b7vVDkmt0U9XOkJxvAo2GihatIZUZkDFmSbCEcWsOHkOr5Q7bINt8RD6C1o23xRA7pPH8ZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8bySy8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCE5C43394;
	Fri,  8 Mar 2024 10:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709893157;
	bh=E/Q+GHdbHP3Gvf5ExMiosmeZbCccda9G4PEoZsYPqh8=;
	h=From:To:Cc:Subject:Date:From;
	b=q8bySy8zYBiGxzpPlzYyiyuIAl8sVR6k2uiDHCVmDcVxU7p+mF9C7u3gOqPAsfM+C
	 l73E58AO3rLtOmjEGbker3jxpIyGiMl0TWr6S4qrY4ePXCsF3YfzLHK/3xwbBys4lO
	 0xulfy+9wn+SbiuIAxbrFATtCt9++1bagtZmzuHBt3ietOujJ/+dMhKZPoKcuVSTYC
	 HSLfjc4zm0JjxJUr5AsSYTAGxf10qhIkIpczP+l7dib2fL09yztaIisr3QenUNbMSt
	 7kzwsGBcBuTNTsI4K5rPewp69udL8PJaCSetqeaKELObvNCYPF1LtQQP8mw8yu09c0
	 W3XkL4X21mtSQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs uuid
Date: Fri,  8 Mar 2024 11:19:05 +0100
Message-ID: <20240308-vfs-uuid-f917b2acae70@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2860; i=brauner@kernel.org; h=from:subject:message-id; bh=E/Q+GHdbHP3Gvf5ExMiosmeZbCccda9G4PEoZsYPqh8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS+eib3319G5MeaisSE5eXzq+2WLd+zctqnIpPjzLuOb /t6ymCxYUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE2Ocz/GafWLmJ7dr1Dd8m f1jKv/nhtlDpuVH7ylXEz12WPvBYLPwEI8MJ3as936eUsvsGmgTrfX5UyPLylajL72s7HC59PrH +5DRGAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This adds two new ioctl()s for getting the filesystem uuid and
retrieving the sysfs path based on the path of a mounted filesystem. The
bcachefs pull request should include a merge of this as well as it
depends on the two new ioctls. Getting the filesystem uuid has been
implemented in filesystem specific code for a while it's now lifted as a
generic ioctl.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.8-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.uuid

for you to fetch changes up to 01edea1bbd1768be41729fd018a82556fa1810ec:

  Merge series "filesystem visibility ioctls" of https://lore.kernel.org/r/20240207025624.1019754-1-kent.overstreet@linux.dev (2024-02-12 13:14:21 +0100)

Please consider pulling these changes from the signed vfs-6.9.uuid tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.9.uuid

----------------------------------------------------------------
Christian Brauner (1):
      Merge series "filesystem visibility ioctls" of https://lore.kernel.org/r/20240207025624.1019754-1-kent.overstreet@linux.dev

Kent Overstreet (6):
      fs: super_set_uuid()
      ovl: convert to super_set_uuid()
      fs: FS_IOC_GETUUID
      fat: Hook up sb->s_uuid
      fs: add FS_IOC_GETFSSYSFSPATH
      xfs: add support for FS_IOC_GETFSSYSFSPATH

 Documentation/userspace-api/ioctl/ioctl-number.rst |  3 +-
 fs/ext4/super.c                                    |  2 +-
 fs/f2fs/super.c                                    |  2 +-
 fs/fat/inode.c                                     |  3 ++
 fs/gfs2/ops_fstype.c                               |  2 +-
 fs/ioctl.c                                         | 33 ++++++++++++++
 fs/kernfs/mount.c                                  |  4 +-
 fs/ocfs2/super.c                                   |  4 +-
 fs/overlayfs/util.c                                | 18 +++++---
 fs/ubifs/super.c                                   |  2 +-
 fs/xfs/xfs_mount.c                                 |  4 +-
 include/linux/fs.h                                 | 52 ++++++++++++++++++++++
 include/uapi/linux/fs.h                            | 25 +++++++++++
 mm/shmem.c                                         |  4 +-
 14 files changed, 141 insertions(+), 17 deletions(-)

