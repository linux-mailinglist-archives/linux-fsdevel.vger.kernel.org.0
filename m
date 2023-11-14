Return-Path: <linux-fsdevel+bounces-2822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED1E7EB34C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9968C281238
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5689B41746;
	Tue, 14 Nov 2023 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tx71B04j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A794405D9
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C274C433C8;
	Tue, 14 Nov 2023 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699975155;
	bh=kRFvVYyQo9h3UdVSK8tFC8FgB4YBcfgkeYjzV9XXjZ4=;
	h=From:To:Cc:Subject:Date:From;
	b=Tx71B04jtt9pLSKi0ZF7CcXShvUoFgliUCSrGttSL9fNsJG2G2HqTk/D/15o3F8wB
	 fOLeFA3UxD4oX7NxkHb/LD4KHfzHgnCspZfyu1w0WNwufOHH5Wz1rD2I2xpSEiWmCD
	 0ad7GcHrFMqKKmPK5Mi/01WNeu6ykPsVmxeTrEGi8T0iqF9Rq27jlYOA7p5aonHi53
	 4Ilq+AhAQn5lHXy3OYHq5PvoTUcxHkEPu0kSvYbH3srPYCw2BTA0rGnJM0Pwevtu3s
	 J4nYszk3aitrEzBuqSPXiJVmsBimWORwqRHqrfi+ugZxsess/pK5znwuq/r2Ol5txg
	 vWvvWEXCCEe2A==
User-agent: mu4e 1.8.10; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: ailiop@suse.com,dchinner@redhat.com,djwong@kernel.org,hch@lst.de,holger@applied-asynchrony.com,leah.rumancik@gmail.com,leo.lilong@huawei.com,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,osandov@fb.com,willy@infradead.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to 7930d9e10370
Date: Tue, 14 Nov 2023 20:44:03 +0530
Message-ID: <878r70icr4.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi folks,

The for-next branch of the xfs-linux repository at:

	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the for-next branch is commit:

7930d9e10370 xfs: recovery should not clear di_flushiter unconditionally

9 new commits:

Anthony Iliopoulos (1):
      [a2e4388adfa4] xfs: fix again select in kconfig XFS_ONLINE_SCRUB_STATS

Christoph Hellwig (1):
      [55f669f34184] xfs: only remap the written blocks in xfs_reflink_end_cow_extent

Dave Chinner (2):
      [038ca189c0d2] xfs: inode recovery does not validate the recovered inode
      [7930d9e10370] xfs: recovery should not clear di_flushiter unconditionally

Leah Rumancik (1):
      [471de20303dd] xfs: up(ic_sema) if flushing data device fails

Long Li (2):
      [2a5db859c682] xfs: factor out xfs_defer_pending_abort
      [f8f9d952e42d] xfs: abort intent items when recovery intents fail

Matthew Wilcox (Oracle) (1):
      [00080503612f] XFS: Update MAINTAINERS to catch all XFS documentation

Omar Sandoval (1):
      [f63a5b3769ad] xfs: fix internal error from AGFL exhaustion

Code Diffstat:

 MAINTAINERS                     |  3 +--
 fs/xfs/Kconfig                  |  2 +-
 fs/xfs/libxfs/xfs_alloc.c       | 27 ++++++++++++++++++++++++---
 fs/xfs/libxfs/xfs_defer.c       | 28 ++++++++++++++++++----------
 fs/xfs/libxfs/xfs_defer.h       |  2 +-
 fs/xfs/libxfs/xfs_inode_buf.c   |  3 +++
 fs/xfs/xfs_inode_item_recover.c | 46 ++++++++++++++++++++++++++++++----------------
 fs/xfs/xfs_log.c                | 23 ++++++++++++-----------
 fs/xfs/xfs_log_recover.c        |  2 +-
 fs/xfs/xfs_reflink.c            |  1 +
 10 files changed, 92 insertions(+), 45 deletions(-)

