Return-Path: <linux-fsdevel+bounces-32332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA459A3AB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 12:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92BD1F26A66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 10:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0C4200CAB;
	Fri, 18 Oct 2024 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqZWv2vx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0017D1D2709;
	Fri, 18 Oct 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245667; cv=none; b=lScLQJi6IEXYLMPtV8hkJzhQrkPD2JfJD+xbU5LQ3iZKAE7Rpl3CXx9yCEGRbfGcH816cn30khE0w/w9sz0OFwFcZIiaLlzMygJlscmK0fgiL+poEiygjq7zOssKO1HQXlm4suvHQ950lsJ8udXXRNhb8harKp8jdhmqqtMQpHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245667; c=relaxed/simple;
	bh=SSeToUfErQQKVaQ3BjaW/03Edt/711PxLyix0KeNqYY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VXTQg9nzD2itBPvU00iOJgSSD/Tx++Zchpm+kPFilV0nE/1so0bU1fqTu/MVNmc3tpOULI0svYW0lOk91FIF2b878DvZwOnM+fcOdWgOvYSQ+LooVXTm4JDYUCfMW9WrT+qHxmmVGmgswyROTbspY9CFXRvMc5NIhqk5dqq6Ois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqZWv2vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06EEC4CEC3;
	Fri, 18 Oct 2024 10:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729245666;
	bh=SSeToUfErQQKVaQ3BjaW/03Edt/711PxLyix0KeNqYY=;
	h=Date:From:To:Cc:Subject:From;
	b=ZqZWv2vxsu9kM3xVpvZ2wnTu3mg//vDjlt363DRiJwXygPgxoUu43LdcZN+w+tFef
	 GSuideuihJW6MGY69dtR96yCG1v690w+JxxwqxOn/D5v8hZzqLVcTPFvFTr7oz8p2I
	 Gpa0cKLwS9+RCF/LjxULqxTAbI2OjQGMHnchkBIYOI/HK4jBHQ3J0xp3Jkma8Pfg0/
	 gFLK8MBtSw79RRm+fBEJCHluieokBEbbgEMQ9ujrId2R0hpp3vu+DhXc3+h3gpRS2d
	 GnKQcOa+pABdv1OBrIya00FhFi1smbOaJnp0XD5mpqMr+M3z+xcI8FuP0/kxCKuAN5
	 F0q2ckg+GNDww==
Date: Fri, 18 Oct 2024 12:01:02 +0200
From: Carlos Maiolino <cem@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	brauner@kernel.org, hch@lst.de, djwong@kernel.org
Subject: [GIT PULL] xfs: bug fixes for 6.12-rc4
Message-ID: <olhbmfxlvn7kdlc4vpxaa3phy3vq7nqgczudqjj2fr444h7cfp@xvy3zxck33v4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus, could you please pull the patches below for 6.12-rc4?

I sent the patches to for-next earlier this week, and I haven't done any rebase
on these patches (in contrast with my previous PR).

I just did a test merge against your TOT and I didn't see any conflicts.
Hopefully I got everything correct this time.

Thanks!
Carlos

The following changes since commit 77bfe1b11ea0c0c4b0ce19b742cd1aa82f60e45d:

  xfs: fix a typo (2024-10-09 10:05:26 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.12-fixes-4

for you to fetch changes up to f6f91d290c8b9da6e671bd15f306ad2d0e635a04:

  xfs: punch delalloc extents from the COW fork for COW writes (2024-10-15 11:37:42 +0200)

----------------------------------------------------------------
XFS Bug fixes for 6.12-rc4

* Fix integer overflow in xrep_bmap
* Fix stale dealloc punching for COW IO

Signed-off-by: Carlos Maiolino <cem@kernel.org>

----------------------------------------------------------------
Christoph Hellwig (10):
      iomap: factor out a iomap_last_written_block helper
      iomap: remove iomap_file_buffered_write_punch_delalloc
      iomap: move locking out of iomap_write_delalloc_release
      xfs: factor out a xfs_file_write_zero_eof helper
      xfs: take XFS_MMAPLOCK_EXCL xfs_file_write_zero_eof
      xfs: IOMAP_ZERO and IOMAP_UNSHARE already hold invalidate_lock
      xfs: support the COW fork in xfs_bmap_punch_delalloc_range
      xfs: share more code in xfs_buffered_write_iomap_begin
      xfs: set IOMAP_F_SHARED for all COW fork allocations
      xfs: punch delalloc extents from the COW fork for COW writes

Darrick J. Wong (1):
      xfs: fix integer overflow in xrep_bmap

 Documentation/filesystems/iomap/operations.rst |   2 +-
 fs/iomap/buffered-io.c                         | 111 ++++++-------------
 fs/xfs/scrub/bmap_repair.c                     |   2 +-
 fs/xfs/xfs_aops.c                              |   4 +-
 fs/xfs/xfs_bmap_util.c                         |  10 +-
 fs/xfs/xfs_bmap_util.h                         |   2 +-
 fs/xfs/xfs_file.c                              | 146 +++++++++++++++----------
 fs/xfs/xfs_iomap.c                             |  67 ++++++++----
 include/linux/iomap.h                          |  20 +++-
 9 files changed, 199 insertions(+), 165 deletions(-)

