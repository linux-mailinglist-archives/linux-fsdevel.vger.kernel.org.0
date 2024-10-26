Return-Path: <linux-fsdevel+bounces-33008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4959B15D2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 09:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFAA8B21315
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 07:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710A618308A;
	Sat, 26 Oct 2024 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMqtTUcu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C560B13BAE7;
	Sat, 26 Oct 2024 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729927504; cv=none; b=JpzxuludAkaYxbCSWtnx9RQvnc/tDom4A5sw2YOEx1cYnM/FMjijXieI812L9QszpX9rXnS5qs2RjVMr3oKEv+xSDKw5MqLBZowtZFnpOhW3otWA+T3Rjjnl8I82EPBmklEmyy33giIru+b7dc5nI7wO8a7fQaPod9lNT22HFaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729927504; c=relaxed/simple;
	bh=Juo3gyToYT+P2HYsP9X1nD50JMezA7MDXqAXWX+v+pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XRZ1yuHnGMFQt4W0Q1Xes+3cWu9zY0eJs8RDqp1NndxHF/4EyLMq7jnvywGfgeJTor3DRzn2yZrFCDWomBxgTflMorhx37rCpqcn3+CQ4bySAKH2kIikDNCqYe3KGJ9vZG7m7tHxqE/FNUvk/8V1J3nkVkZJXaPTWaCicPCY2B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMqtTUcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69819C4CEC7;
	Sat, 26 Oct 2024 07:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729927504;
	bh=Juo3gyToYT+P2HYsP9X1nD50JMezA7MDXqAXWX+v+pQ=;
	h=Date:From:To:Cc:Subject:From;
	b=jMqtTUcuLYd19Yor4QCFJJ6WqhyWk8lji1swGQwGTWagR8aD3U7+ZbtZnOBoxyVAm
	 sQXQY5g5jNr2+bIlBO8j55pPj9Ro17c/RD2L8VLl0z6BuZax3rQNsYtsDeCkUGrJlK
	 7N53bLwHC+tgdVkKbScctNHC6XbunibPMsEkui5b6Efw5tOwJQ9KpU5Tu6RROaWci4
	 47/5sS0NhvewfpCwOJGaoiXppCfchcp1wxr5TuP2Yftip4lGIDb3ePUWpQq7DySBpQ
	 WKiGbv0GA+vfNhYuYbIFHV+NyXb2zFUf3NojNpDKtVfiaF6p/6FFC3Tufh2KeR8V05
	 ZJk3jeofKqHQA==
Date: Sat, 26 Oct 2024 09:25:00 +0200
From: Carlos Maiolino <cem@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] xfs: bug fixes for 6.12-rc5
Message-ID: <utvsskliarptudc7dl2c6vmgurm7kywhzdagm4zbdolo3rxmtd@bwqub7ivgmdk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus, could you please pull the patches listed below?

They have been in linux-next since Wednesday (IIRC), and I just tried a merge
against your TOT, and everything seems to be merged without conflicts.

Thanks a lot.
Carlos


The following changes since commit f6f91d290c8b9da6e671bd15f306ad2d0e635a04:

  xfs: punch delalloc extents from the COW fork for COW writes (2024-10-15 11:37:42 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.12-fixes-5

for you to fetch changes up to 4a201dcfa1ff0dcfe4348c40f3ad8bd68b97eb6c:

  xfs: update the pag for the last AG at recovery time (2024-10-22 13:37:19 +0200)

----------------------------------------------------------------
XFS bug fixes for 6.12-rc5

* fix recovery of allocator ops after a growfs
* Do not fail repairs on metadata files with no attr fork

Signed-off-by: Carlos Maiolino <cem@kernel.org>

----------------------------------------------------------------
Christoph Hellwig (6):
      xfs: pass the exact range to initialize to xfs_initialize_perag
      xfs: merge the perag freeing helpers
      xfs: update the file system geometry after recoverying superblock buffers
      xfs: error out when a superblock buffer update reduces the agcount
      xfs: don't use __GFP_RETRY_MAYFAIL in xfs_initialize_perag
      xfs: update the pag for the last AG at recovery time

Darrick J. Wong (1):
      xfs: don't fail repairs on metadata files with no attr fork

 fs/xfs/libxfs/xfs_ag.c        | 75 ++++++++++++++++---------------------------
 fs/xfs/libxfs/xfs_ag.h        | 11 ++++---
 fs/xfs/scrub/repair.c         |  8 +++--
 fs/xfs/xfs_buf_item_recover.c | 70 ++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_fsops.c            | 20 ++++++------
 fs/xfs/xfs_log_recover.c      |  7 ----
 fs/xfs/xfs_mount.c            |  9 +++---
 7 files changed, 122 insertions(+), 78 deletions(-)

