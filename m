Return-Path: <linux-fsdevel+bounces-32660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B60F49AC9FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 14:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E579B1C21A0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 12:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DC41AC438;
	Wed, 23 Oct 2024 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/LqXfkI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE61ABECF;
	Wed, 23 Oct 2024 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729686165; cv=none; b=UtNoVepjU8RlYy6aE5EOtWUWY7R0f+tlsaMUFXLfuS7gAubSlJmczpJL+NIWuhviQh9N5YeXecsRC5U8gyFtopjPjERU75/ttNGlWEG2Jy8QyAROCUTMmGsZfxHoQKHnOyAQDQdiPC0zSjOXAK73iTGQx0veOy8Upf43TV62lV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729686165; c=relaxed/simple;
	bh=y3zcOM/4kne5pf0eeIWps+3RL3Uu2L2GFqqgFraUGwU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YbPHYen3V+TKVhsN88mE1au6C7EENONardS/HTOIbNlFKnAbNvcDwxxFSrjBSVQx9BX008OhpSeVvEey9n+3XnlNivZWEkBfNp9eGWN6qq6yE9QkYBnpmRacvyqtrlH/PCgmUGbc4XHcxpO7xnlY6RRxfbUzfq1uUpmYtDtNoh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/LqXfkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD989C4CEC6;
	Wed, 23 Oct 2024 12:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729686164;
	bh=y3zcOM/4kne5pf0eeIWps+3RL3Uu2L2GFqqgFraUGwU=;
	h=Date:From:To:Cc:Subject:From;
	b=n/LqXfkIpMKBLVqght/cg7LrDzCdoH/j9WwGO8A16f9aWxTRSCNxeOhTEPxzRFXvP
	 HFiHu6NDBpKjtaYPVSXAiqHgReaTOe+bp1Me7oLqNIBfpdxuuVNJrhI4AYNMImqZh9
	 cVBNf25qbSsaMblmxnCeLHLHNNcd3GzDN6ODpXQypQAqjCDDVXrXBr80Z51rfjRQuN
	 +GKNoDaln6yUgjt7iU3EDzRUplPOfB83ImB6xlBNTNffXtHadf6jHawE6bVdH5rBT6
	 qG38V66MPWBsq0bQZaGxqLopePr5I2HPq2k8qDeX+vQU1Gl052BFxJC7Cwau9mPbji
	 zyIVPeNfrEVQQ==
Date: Wed, 23 Oct 2024 14:22:40 +0200
From: Carlos Maiolino <cem@kernel.org>
To: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to 4a201dcfa1ff
Message-ID: <7zpzm4ddafifcbalyamwc7xip6wfu7ewjolk2wvlmkt3fykop6@5t54h6rvypiy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Hi folks,

The for-next branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the for-next branch is commit:

4a201dcfa1ff xfs: update the pag for the last AG at recovery time

7 new commits:

Christoph Hellwig (6):
      [82742f8c3f1a] xfs: pass the exact range to initialize to xfs_initialize_perag
      [aa67ec6a2561] xfs: merge the perag freeing helpers
      [6a18765b54e2] xfs: update the file system geometry after recoverying superblock buffers
      [b882b0f8138f] xfs: error out when a superblock buffer update reduces the agcount
      [069cf5e32b70] xfs: don't use __GFP_RETRY_MAYFAIL in xfs_initialize_perag
      [4a201dcfa1ff] xfs: update the pag for the last AG at recovery time

Darrick J. Wong (1):
      [af8512c5277d] xfs: don't fail repairs on metadata files with no attr fork

Code Diffstat:

 fs/xfs/libxfs/xfs_ag.c        | 75 ++++++++++++++++---------------------------
 fs/xfs/libxfs/xfs_ag.h        | 11 ++++---
 fs/xfs/scrub/repair.c         |  8 +++--
 fs/xfs/xfs_buf_item_recover.c | 70 ++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_fsops.c            | 20 ++++++------
 fs/xfs/xfs_log_recover.c      |  7 ----
 fs/xfs/xfs_mount.c            |  9 +++---
 7 files changed, 122 insertions(+), 78 deletions(-)


