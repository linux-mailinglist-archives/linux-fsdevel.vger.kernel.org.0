Return-Path: <linux-fsdevel+bounces-27384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB59296104D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 17:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E8E1F216FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 15:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2DD1C68BD;
	Tue, 27 Aug 2024 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSDVP3Az"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5671C57BC;
	Tue, 27 Aug 2024 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771243; cv=none; b=dNFiZ4/PTyiivkgz1aPHKq+OqMZg6Mz86ZsV2FcCJ5rdD7h4aLnM0BiN7oeQ0NnCgommscDDDTOSWzFCgMqaAv1z362jSZd9vhXqDnSLRTbG0dPph4nzQsmkJua8G0kIsHg2eXyOVkXXYT+3xuSwT6PMqVWsJW9Cg5TVFlM5bew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771243; c=relaxed/simple;
	bh=kMSsQmggHA7LKhrxoDidg83Zhp8xwVvxPo5nHm/kfnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fD/H1RQjJshRMdNv9h6jPRTvXGXtivJluJVl8LBTSqj39TzRA6jjY4C7OYThFsy5+V08vjo+h4jpLg6NaUE9Wvf42FY0KuegRuxepoLDHbVZKw5FzmC/CTFHtP5A8SlMp10Bi1VPEqio9UWH/I4ZG6oVWfxE5IkllG/7QY78IZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSDVP3Az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A19C61074;
	Tue, 27 Aug 2024 15:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724771242;
	bh=kMSsQmggHA7LKhrxoDidg83Zhp8xwVvxPo5nHm/kfnE=;
	h=From:To:Cc:Subject:Date:From;
	b=BSDVP3AzRHz0qPAsX1+N28lb+lsBF6hn36zKijtW3k1iC9CtQq/jHG85AAlyWlsRk
	 nUEIjd0jrj23lusAZuiP3QyVrMozCjIv/7ii2TovAxwAQLgvlAF469f67TusobMD0k
	 wUE1ZHChyi+VgqvRIfrPP95vFQD2qtNDh1gWvM3rO84rlkdolJzCIdlEztK3kaBZwB
	 qZ4RmG6HeneHlgVttDJpHuiOu72xAsDcH8jo3HcD2AhhGf6eJwUf16Gfn/AdQcmIik
	 UUB9nQ7ZwprlkQNbt2a2h9gC9/rL95CtntZ27Lw9n4xYNmzMxYBZmIVx3/3ayRpu/Z
	 8UBSTNhEcf58Q==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: anders.blomdell@gmail.com,dchinner@redhat.com,djwong@kernel.org,hch@lst.de,kjell.m.randa@gmail.com,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,willy@infradead.org,wozizhi@huawei.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to a24cae8fc1f1
Date: Tue, 27 Aug 2024 20:35:39 +0530
Message-ID: <877cc2rom1.fsf@debian-BULLSEYE-live-builder-AMD64>
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

a24cae8fc1f1 xfs: reset rootdir extent size hint after growfsrt

9 new commits:

Darrick J. Wong (6):
      [e21fea4ac3cf] xfs: fix di_onlink checking for V1/V2 inodes
      [5335affcff91] xfs: fix folio dirtying for XFILE_ALLOC callers
      [410e8a18f8e9] xfs: don't bother reporting blocks trimmed via FITRIM
      [6b35cc8d9239] xfs: use XFS_BUF_DADDR_NULL for daddrs in getfsmap code
      [16e1fbdce9c8] xfs: take m_growlock when running growfsrt
      [a24cae8fc1f1] xfs: reset rootdir extent size hint after growfsrt

Dave Chinner (1):
      [95179935bead] xfs: xfs_finobt_count_blocks() walks the wrong btree

Zizhi Wo (2):
      [68415b349f3f] xfs: Fix the owner setting issue for rmap query in xfs fsmap
      [ca6448aed4f1] xfs: Fix missing interval for missing_owner in xfs fsmap

Code Diffstat:

 fs/xfs/libxfs/xfs_ialloc_btree.c |  2 +-
 fs/xfs/libxfs/xfs_inode_buf.c    | 14 +++--
 fs/xfs/scrub/xfile.c             |  2 +-
 fs/xfs/xfs_discard.c             | 36 ++++--------
 fs/xfs/xfs_fsmap.c               | 30 ++++++++--
 fs/xfs/xfs_rtalloc.c             | 78 ++++++++++++++++++++-----
 6 files changed, 114 insertions(+), 48 deletions(-)

