Return-Path: <linux-fsdevel+bounces-18470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 067498B93E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 06:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887E02839FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 04:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C0A18E28;
	Thu,  2 May 2024 04:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+xkHzc1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB87152787;
	Thu,  2 May 2024 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714624538; cv=none; b=qhx7QEYDBXiBur4Udm1yJWPoc0T7mL+GKkgBIgovmKLTWWMi6uHbLFjU0ZiLDb/x9YGhA+0N1t/42WM2OIGILcdPQActLSJ43o0SBAKk+Knav4xlWYwat/nMazaj2qtmF9mZsik79pjqIpdABamYzBmKV9iTR9xBDIqruoqxWS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714624538; c=relaxed/simple;
	bh=iO/6UUKfxOT08s+52q0gTJbC24uE5kRnypK8acHGNbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kFt225ITfLI0+pMmGpAMbJdne693dmxiiAUrXFtVbDRWRueB0N5TMg1ZydnT9Yd+iTGyoDJfMEihJu6uGAcUwVaN9wxBe3Otg5FKJ9DGSH2015ycZIK5Bp5fZMdiJD1zsSwW1BNUaAWshQ2Q6o/nn73u3raIeaI3GIYGUo1b4zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+xkHzc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5B9C116B1;
	Thu,  2 May 2024 04:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714624537;
	bh=iO/6UUKfxOT08s+52q0gTJbC24uE5kRnypK8acHGNbc=;
	h=From:To:Cc:Subject:Date:From;
	b=p+xkHzc1WSaKQnqgYLYzoRLLcCYKO2tKvCB+ObLllda/m77D7wv7zsAhnbwJ0fde7
	 jVq+p3R7WWjkqyHA7Q88HYdbvP7q2xSblBk0mW+2JKARtTGFQyXCiHjIb8dGXyL+ts
	 SAayeXmJNSmFB2hWl3dqcQoLh+UgqF2uI8DXds95Hd27NYx0pFLHML5ZdJnonmHtkL
	 iccS7ycj9ZiH7Di56VifiXPmKvwg0Kin0PloBGnU98CVkntlKz1ttZugdZ0b5nBi+P
	 CMAzDSJxmYNWqu3/yfGqGjPTqfeNTjLzsSRaNgIGqygMI7oU+6X3SEVmEx6lQjQvHq
	 xGkHbqpQum3qw==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: david@fromorbit.com,djwong@kernel.org,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,lyutoon@gmail.com,yi.zhang@huawei.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to 21255afdd729
Date: Thu, 02 May 2024 10:04:25 +0530
Message-ID: <877cgcde5l.fsf@debian-BULLSEYE-live-builder-AMD64>
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

21255afdd729 xfs: do not allocate the entire delalloc extent in xfs_bmapi_write

12 new commits:

Christoph Hellwig (8):
      [6773da870ab8] xfs: fix error returns from xfs_bmapi_write
      [b11ed354c9f7] xfs: remove the unusued tmp_logflags variable in xfs_bmapi_allocate
      [04c609e6e506] xfs: lift a xfs_valid_startblock into xfs_bmapi_allocate
      [9d06960341ec] xfs: don't open code XFS_FILBLKS_MIN in xfs_bmapi_write
      [2a9b99d45be0] xfs: pass the actual offset and len to allocate to xfs_bmapi_allocate
      [a8bb258f703f] xfs: remove the xfs_iext_peek_prev_extent call in xfs_bmapi_allocate
      [d69bee6a35d3] xfs: fix xfs_bmap_add_extent_delay_real for partial conversions
      [21255afdd729] xfs: do not allocate the entire delalloc extent in xfs_bmapi_write

Zhang Yi (4):
      [bb712842a85d] xfs: match lock mode in xfs_buffered_write_iomap_begin()
      [fc8d0ba0ff5f] xfs: make the seq argument to xfs_bmapi_convert_delalloc() optional
      [2e08371a83f1] xfs: make xfs_bmapi_convert_delalloc() to allocate the target offset
      [5ce5674187c3] xfs: convert delayed extents to unwritten when zeroing post eof blocks

Code Diffstat:

 fs/xfs/libxfs/xfs_attr_remote.c |   1 -
 fs/xfs/libxfs/xfs_bmap.c        | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------
 fs/xfs/libxfs/xfs_da_btree.c    |  20 ++++------------
 fs/xfs/scrub/quota_repair.c     |   6 -----
 fs/xfs/scrub/rtbitmap_repair.c  |   2 --
 fs/xfs/xfs_aops.c               |  54 ++++++++++++--------------------------------
 fs/xfs/xfs_bmap_util.c          |  35 ++++++++++++++--------------
 fs/xfs/xfs_dquot.c              |   1 -
 fs/xfs/xfs_iomap.c              |  47 +++++++++++++++++++++++++++-----------
 fs/xfs/xfs_reflink.c            |  14 ------------
 fs/xfs/xfs_rtalloc.c            |   2 --
 11 files changed, 180 insertions(+), 164 deletions(-)

