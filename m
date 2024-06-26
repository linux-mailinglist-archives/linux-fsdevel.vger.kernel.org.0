Return-Path: <linux-fsdevel+bounces-22482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4821B917C18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 11:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D862862BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 09:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C639A1836FE;
	Wed, 26 Jun 2024 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gW+/g4Ao"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9B91836E8;
	Wed, 26 Jun 2024 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392964; cv=none; b=sN2KUrrRZWKQaHNxuZNa8Way+43EgzIOF2PuGD2MJfGe2JLhkME3jv1+Xv5G5Nlh35tGjuzj+nPir/r7MoI0XHQtzjuhk1R5c9UDW6p20VHGpp0wQ2d4LDNJqHoWsVaSzOJNkC/Uf1VayJy3NCNhG3UYD2bTk1V/8XKiY1ZLgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392964; c=relaxed/simple;
	bh=wa+tyM04iG+PKN7ymC9FogMEj8Kfl3voTZDMoU+nzQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FrkXhdkG054hB0UlvkNDzH+uIOmTbEhMmqGewA35P85SvTK83Z/O6CT+u2M/w/cvFjFDrsad8cdhdlNFIWAS2upmdfb0AqgqNA6MKrWCbUmvU5rCatTw6MH/h0voxLbe5Uos0rZs3ZS/KxESxmKWleDLc88NqAQAuysF5GXs+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gW+/g4Ao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BFDC2BD10;
	Wed, 26 Jun 2024 09:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719392963;
	bh=wa+tyM04iG+PKN7ymC9FogMEj8Kfl3voTZDMoU+nzQ0=;
	h=From:To:Cc:Subject:Date:From;
	b=gW+/g4AoohC+vhUjmbteCa04lfuhtcAGJ+kH/32wggHursgh/pmZ5yXgh/U4H48Nz
	 +p0e+3nBuLPUyoRp7oECoZwcL4r5FW/Y6HQo4+v6OrDXx0dB2q5k3WmtTZPvXvIktI
	 aP9R4APKaLOio5947kSGEjQIhytZx9rLC9Jnjk6sWOA+CszmPny4KAcQ43+e+J4ZzT
	 aZfIk8wvx+SFktK1U8jvvs4S6+UDgq8NKmrbbaSMewnAqAk5WknrkUUPBOgyjOWck3
	 DysR3AQsI7zjDIWltdqWC0HUoIuSMYNcXmLXBB15/CwDbKaCH+Bp7/Dj8LZ+4LLMq6
	 HI8jg/A5sjIvw==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: djwong@kernel.org,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to 673cd885bbbf
Date: Wed, 26 Jun 2024 14:38:19 +0530
Message-ID: <87wmmchxz4.fsf@debian-BULLSEYE-live-builder-AMD64>
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

673cd885bbbf xfs: honor init_xattrs in xfs_init_new_inode for !ATTR fs

5 new commits:

Christoph Hellwig (1):
      [610b29161b0a] xfs: fix freeing speculative preallocations for preallocated files

Darrick J. Wong (4):
      [288e1f693f04] xfs: restrict when we try to align cow fork delalloc to cowextsz hints
      [1ec9307fc066] xfs: allow unlinked symlinks and dirs with zero size
      [dc5e1cbae270] xfs: fix direction in XFS_IOC_EXCHANGE_RANGE
      [673cd885bbbf] xfs: honor init_xattrs in xfs_init_new_inode for !ATTR fs

Code Diffstat:

 fs/xfs/libxfs/xfs_bmap.c      | 31 +++++++++++++++++++++----
 fs/xfs/libxfs/xfs_fs.h        |  2 +-
 fs/xfs/libxfs/xfs_inode_buf.c | 23 +++++++++++++++----
 fs/xfs/xfs_bmap_util.c        | 30 +++++++++++++++++-------
 fs/xfs/xfs_bmap_util.h        |  2 +-
 fs/xfs/xfs_icache.c           |  2 +-
 fs/xfs/xfs_inode.c            | 24 +++++++++++---------
 fs/xfs/xfs_iomap.c            | 34 ++++++++++------------------
 8 files changed, 95 insertions(+), 53 deletions(-)

