Return-Path: <linux-fsdevel+bounces-28106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9060C967267
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 17:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E06C28353E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 15:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1149328389;
	Sat, 31 Aug 2024 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Esm0CaJn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724EA14F6C;
	Sat, 31 Aug 2024 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725118349; cv=none; b=dBsOuGF1NAwVqtb8DmWuOTZw4tA2kxUekfnPwXwhnQWkPYqsq5xWgGoF4urN1bNUrtwyUT/yTVEJ+5MgSHpG2fuEymjdeNO3/6SaDZF7nEeCSmVv9kdIr9bvSOxbPOxcVtA/BqL8kwtpTgiblvnNNlrTmIWRwIqxgQpN7nf3D5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725118349; c=relaxed/simple;
	bh=us0ZFcwRjwDGxeJgFEpVoCAGiForOHqx1JKOLsYbIcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UnYu4QaJA3Y1czkl7h+5XdQ0ToVVW9082Juka+nu1aGGhtHalLqY8hDFjy3jjVhKKk3lnoFcsAGKzEoFej2aNpCaGvY2IbzLGBCGyN12tkS5jGrG2/sn6k/BMaWNW6WQGekIMnCQilL++FHvnPgT9dG2MhUodp4Dhmesd2XNyiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Esm0CaJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C101C4CEC0;
	Sat, 31 Aug 2024 15:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725118349;
	bh=us0ZFcwRjwDGxeJgFEpVoCAGiForOHqx1JKOLsYbIcw=;
	h=From:To:Cc:Subject:Date:From;
	b=Esm0CaJnU1mwoby3N9rCxImvHdxAH7agiz11eq5zFWZoFaVa/TEG0q2Q820HRJr1/
	 NKl25rvHdvaDPtxbNFdltMw+SnUZAJTDCNjOpdlGSuhtyv4M5I9Q+SEutM5K8omHfZ
	 n/7tJPril4z3ctv1NjI1ZL1+3iQIyxxA878PoN/ylMJBXbEoRLxod+rQwflsXIM6Wv
	 S58e3gDJkgs/Nq/MxFuyiA9s3++APeYv3FFjGGfjPXGmuaiRzHir8quR7fb9Tia4oZ
	 VIQJu1yliFiPwLPSc2zcejK3uHJFew/a+R/5E2K5SZzxsymFGlExjXMdQKFzebb5Sm
	 qDpVjNVv/pMcA==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: chandanbabu@kernel.org,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: bug fixes for 6.11
Date: Sat, 31 Aug 2024 20:59:46 +0530
Message-ID: <87o758so6y.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch which contains XFS bug fixes for 6.11-rc6. A brief
description of the fixes is provided below.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit 5be63fc19fcaa4c236b307420483578a56986a37:

  Linux 6.11-rc5 (2024-08-25 19:07:11 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.11-fixes-4

for you to fetch changes up to a24cae8fc1f13f6f6929351309f248fd2e9351ce:

  xfs: reset rootdir extent size hint after growfsrt (2024-08-27 18:32:14 +0530)

----------------------------------------------------------------
Bug fixes for 6.11-rc6:

  * Do not call out v1 inodes with non-zero di_nlink field as being corrupt.
  * Change xfs_finobt_count_blocks() to count "free inode btree" blocks rather
    than "inode btree" blocks.
  * Don't report the number of trimmed bytes via FITRIM because the underlying
    storage isn't required to do anything and failed discard IOs aren't
    reported to the caller anyway.
  * Fix incorrect setting of rm_owner field in an rmap query.
  * Report missing disk offset range in an fsmap query.
  * Obtain m_growlock when extending realtime section of the filesystem.
  * Reset rootdir extent size hint after extending realtime section of the
    filesystem.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (6):
      xfs: fix di_onlink checking for V1/V2 inodes
      xfs: fix folio dirtying for XFILE_ALLOC callers
      xfs: don't bother reporting blocks trimmed via FITRIM
      xfs: use XFS_BUF_DADDR_NULL for daddrs in getfsmap code
      xfs: take m_growlock when running growfsrt
      xfs: reset rootdir extent size hint after growfsrt

Dave Chinner (1):
      xfs: xfs_finobt_count_blocks() walks the wrong btree

Zizhi Wo (2):
      xfs: Fix the owner setting issue for rmap query in xfs fsmap
      xfs: Fix missing interval for missing_owner in xfs fsmap

 fs/xfs/libxfs/xfs_ialloc_btree.c |  2 +-
 fs/xfs/libxfs/xfs_inode_buf.c    | 14 +++++---
 fs/xfs/scrub/xfile.c             |  2 +-
 fs/xfs/xfs_discard.c             | 36 ++++++-------------
 fs/xfs/xfs_fsmap.c               | 30 +++++++++++++---
 fs/xfs/xfs_rtalloc.c             | 78 +++++++++++++++++++++++++++++++++-------
 6 files changed, 114 insertions(+), 48 deletions(-)

