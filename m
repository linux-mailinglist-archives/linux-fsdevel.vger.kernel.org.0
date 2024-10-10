Return-Path: <linux-fsdevel+bounces-31547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BABDC998526
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2DC1C23694
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DC11C3F04;
	Thu, 10 Oct 2024 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWYFEtV+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B84C1C3309;
	Thu, 10 Oct 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560152; cv=none; b=UuOuT2Aox1BEJl5JkzHGmy5rL1XXkTiitxdlmkpG30v956k76ehyD1SUxV/FW8gDX66erqeNZ2HK31r+EFFKHdkYV27E80sStQMnwHAhSAzJgJ9FuJiuDt+tRvuYufCsBmowTGBIvW3AnfgZvvXJCKOxvEM/7PWs6kD3+VVRMu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560152; c=relaxed/simple;
	bh=Wtz5Xrjtx1jJsHvUJrpxoPdBEDCmRN5XufUeSqQkcL0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VENOBqjBmwkDLiwI5RmzY+iQCXLN/xC4mX6uuRJAGs3ZsHm68LjU7YOlSl/Uzamgv6r3w6kpD1KG/5kAY9YI/FaLJfWGqG5yfcIgqsWSBugRNJ01INAZZG1Pgfo7qDzaemy21A/zMJv3PauIpbm3sAtygl+4OIcgDLVudH7j6hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWYFEtV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1AAC4CEC5;
	Thu, 10 Oct 2024 11:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728560151;
	bh=Wtz5Xrjtx1jJsHvUJrpxoPdBEDCmRN5XufUeSqQkcL0=;
	h=Date:From:To:Cc:Subject:From;
	b=qWYFEtV+3KAiwc0i7xeBfhs6sXw+cgJqSVGg4u4E27O3gcNyDVFAqv/XBcKCLBNzl
	 U6N+Z6zOA5+5ljrA4EO86ED6up5heEBkzK5iT/1+enyfKwNEpUckOREN7XFgLQPzhr
	 yPkdLHHqcWW5840VDw0vmdwe4jwhnVE2MR2rwfdukg58X1DGz8yZOkqFz8vQx33U4P
	 e1bx2GbHlf0kkIhwU8GHo21VUGr/SGXjx/6xlWJndi+B1tEoWGIyLsprjw+TUq76sm
	 5zxGnG5njA+yWMHQPvgXWIIU/ttrAmPO86jgyHF1wQblOe8olTtOiVPi8CfU7qeNWs
	 6EOwjr5NWiUEg==
Date: Thu, 10 Oct 2024 13:35:47 +0200
From: Carlos Maiolino <cem@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: bug fixes for 6.12-rc3
Message-ID: <ftxj7acikfuwhh2spky4jlnqdob7vjxxxtoibq5ekiriirrxy2@uer37e2phsit>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Could you please pull the patches below? They are fixes aiming 6.12-rc3.

I did a test merge against current TOT and I didn't hit any conflicts.

These patches are in linux-next for a couple days, already, and nothing got
reported so far, other than a short hash on a Fixes tag, which I fixed and
rebased the tree today before submitting the patches.

Hope I got everything right. Thanks!
Carlos


The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.12-fixes-3

for you to fetch changes up to 77bfe1b11ea0c0c4b0ce19b742cd1aa82f60e45d:

  xfs: fix a typo (2024-10-09 10:05:26 +0200)

----------------------------------------------------------------
Bug fixes for 6.12-rc3

* A few small typo fixes
* fstests xfs/538 DEBUG-only fix
* Performance fix on blockgc on COW'ed files,
  by skipping trims on cowblock inodes currently
  opened for write
* Prevent cowblocks to be freed under dirty pagecache
  during unshare
* Update MAINTAINERS file to quote the new maintainer

Signed-off-by: Carlos Maiolino <cem@kernel.org>

----------------------------------------------------------------
Andrew Kreimer (1):
      xfs: fix a typo

Brian Foster (2):
      xfs: skip background cowblock trims on inodes open for write
      xfs: don't free cowblocks from under dirty pagecache on unshare

Chandan Babu R (1):
      MAINTAINERS: add Carlos Maiolino as XFS release manager

Christoph Hellwig (8):
      xfs: merge xfs_attr_leaf_try_add into xfs_attr_leaf_addname
      xfs: return bool from xfs_attr3_leaf_add
      xfs: distinguish extra split from real ENOSPC from xfs_attr3_leaf_split
      xfs: distinguish extra split from real ENOSPC from xfs_attr_node_try_addname
      xfs: fold xfs_bmap_alloc_userdata into xfs_bmapi_allocate
      xfs: don't ifdef around the exact minlen allocations
      xfs: call xfs_bmap_exact_minlen_extent_alloc from xfs_bmap_btalloc
      xfs: support lowmode allocations in xfs_bmap_exact_minlen_extent_alloc

Uros Bizjak (1):
      xfs: Use try_cmpxchg() in xlog_cil_insert_pcp_aggregate()

Yan Zhen (1):
      xfs: scrub: convert comma to semicolon

Zhang Zekun (1):
      xfs: Remove empty declartion in header file

 MAINTAINERS                   |   2 +-
 fs/xfs/libxfs/xfs_alloc.c     |   7 +-
 fs/xfs/libxfs/xfs_alloc.h     |   4 +-
 fs/xfs/libxfs/xfs_attr.c      | 190 ++++++++++++++++++------------------------
 fs/xfs/libxfs/xfs_attr_leaf.c |  40 +++++----
 fs/xfs/libxfs/xfs_attr_leaf.h |   2 +-
 fs/xfs/libxfs/xfs_bmap.c      | 140 ++++++++++---------------------
 fs/xfs/libxfs/xfs_da_btree.c  |   5 +-
 fs/xfs/scrub/ialloc_repair.c  |   4 +-
 fs/xfs/xfs_icache.c           |  37 ++++----
 fs/xfs/xfs_log.h              |   2 -
 fs/xfs/xfs_log_cil.c          |  11 +--
 fs/xfs/xfs_log_recover.c      |   2 +-
 fs/xfs/xfs_reflink.c          |   3 +
 fs/xfs/xfs_reflink.h          |  19 +++++
 15 files changed, 207 insertions(+), 261 deletions(-)

