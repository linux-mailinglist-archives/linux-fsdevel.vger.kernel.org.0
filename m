Return-Path: <linux-fsdevel+bounces-22810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9D091CD94
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 16:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4CA1F22957
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258DE81ABB;
	Sat, 29 Jun 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfITD69x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803AB2574F;
	Sat, 29 Jun 2024 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719671072; cv=none; b=m/30gA0xfx6eW73jHM1JK3qGfXgQyob3I0z4c9Pxq5Ar8+21npG6xo1sWmAiMtcVJ253/Zb10RaBposSLeUctD7ynQ3cnDtXPmcwufUKZ0nT+vN0+1g4/Kx4LZkCIp81ce6tO7kMQxyfCBjlyeZJNNqL4tOy62vRbguIPOSexso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719671072; c=relaxed/simple;
	bh=GKP181QfnLc37jOb5dVzgW6gsfixgVBOW1/c/ngQOPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UeMBm7snpLoOV54UBYsy/+1k7nXKo+1cmLIDNx2Q55pFE968Pgkwqm5Bu7vEwRyD1I0DfyX+0W67LviFR76+R/qgSvihvkILMeSoTCUAYwiekgJYn5GAqiINCcthRG1NEb3Ai3pjDKLqDN2QtJH6i7tqZvjamiYANZi0pH5ZlpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfITD69x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652C0C2BBFC;
	Sat, 29 Jun 2024 14:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719671072;
	bh=GKP181QfnLc37jOb5dVzgW6gsfixgVBOW1/c/ngQOPY=;
	h=From:To:Cc:Subject:Date:From;
	b=gfITD69xdkRVp8FwTEGph4JDR4neNMgKfYDDM+so+snZVhoHO4P9vvwERwWunO2Dw
	 iGE27PEvgYsvb2YYjnMe6wwKQqLg2o9CG+xs5yUp9QCG0zFYxzKGK3dhthI1p0szCR
	 bgHgeLKh3hGTZg540vDlQ31ZCh2iazXnCm+S/S9NsiLC45IHwhSaHe6EFBKPOyHgSZ
	 r0orBn3+IDiYIi6rZuqqMPpb1JQmC7yw3RKJfRClLRqH6EwtckdiQPJFWJUYss4QdS
	 1u2023Q6SQCE9VVwk+X6szDc2frJzZtpTN4yEw4+C8kBh0qUS/aoxvtp1Sie7bnxiW
	 SeAjCnq8r+WYA==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: chandanbabu@kernel.org,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: bug fixes for 6.10
Date: Sat, 29 Jun 2024 19:40:16 +0530
Message-ID: <8734ov3jz8.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch which contains XFS bug fixes for 6.10-rc6. A brief
description of the fixes is provided below.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.10-fixes-5

for you to fetch changes up to 673cd885bbbfd873aa6983ce2363a813b7826425:

  xfs: honor init_xattrs in xfs_init_new_inode for !ATTR fs (2024-06-26 14:29:25 +0530)

----------------------------------------------------------------
Bug fixes for 6.10-rc6:

  * Always free only post-EOF delayed allocations for files with the
    XFS_DIFLAG_PREALLOC or APPEND flags set.
  * Do not align cow fork delalloc to cowextsz hint when running low on space.
  * Allow zero-size symlinks and directories as long as the link count is
    zero.
  * Change XFS_IOC_EXCHANGE_RANGE to be a _IOW only ioctl. This was ioctl was
    introduced during v6.10 developement cycle.
  * xfs_init_new_inode() now creates an attribute fork on a newly created
    inode even if ATTR feature flag is not enabled.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Christoph Hellwig (1):
      xfs: fix freeing speculative preallocations for preallocated files

Darrick J. Wong (4):
      xfs: restrict when we try to align cow fork delalloc to cowextsz hints
      xfs: allow unlinked symlinks and dirs with zero size
      xfs: fix direction in XFS_IOC_EXCHANGE_RANGE
      xfs: honor init_xattrs in xfs_init_new_inode for !ATTR fs

 fs/xfs/libxfs/xfs_bmap.c      | 31 +++++++++++++++++++++++++++----
 fs/xfs/libxfs/xfs_fs.h        |  2 +-
 fs/xfs/libxfs/xfs_inode_buf.c | 23 ++++++++++++++++++-----
 fs/xfs/xfs_bmap_util.c        | 30 ++++++++++++++++++++++--------
 fs/xfs/xfs_bmap_util.h        |  2 +-
 fs/xfs/xfs_icache.c           |  2 +-
 fs/xfs/xfs_inode.c            | 24 +++++++++++++-----------
 fs/xfs/xfs_iomap.c            | 34 ++++++++++++----------------------
 8 files changed, 95 insertions(+), 53 deletions(-)

