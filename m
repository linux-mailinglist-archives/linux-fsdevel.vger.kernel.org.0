Return-Path: <linux-fsdevel+bounces-18727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFEE8BBC69
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 16:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5091C20FE8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2CD3D54B;
	Sat,  4 May 2024 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRWI5GFA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F843CF5E;
	Sat,  4 May 2024 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714832619; cv=none; b=gfXd+1AIYWOY970dP+Vcg0a9pXv/WSCIYA6Kow1jWiXIfHuML9R3I0tJK70On18qpT1xV2sjQfaLgKygJQx3fWyHJr3wv9t0V0NZSPRO8nIsj/l/WjZmnQrn3wBHui22jLupke92Q/DSAfvy04Mkl7tZdQT3CLf86YPodQ9AZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714832619; c=relaxed/simple;
	bh=KWmi8ZHXEGCO7MdhtzcgU0EUB3tNVlp789IrQ+CIDJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dwaNmWW9+MM7zMQO6uG1elYHQK/cQUmzPqU5YqJB3xdGjkdzWH/XggVl3PqOE4w+o7anmGZTHGRiYEckJ+FgRN0lyAdmRn3UWo+17EJNjHjqU1sEX2oP/DF5fxazM1RUHBpVwgo1QsfwQov67qNdVdi/h7bZBja+MpPbfwVtBRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRWI5GFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D271AC4AF1B;
	Sat,  4 May 2024 14:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714832618;
	bh=KWmi8ZHXEGCO7MdhtzcgU0EUB3tNVlp789IrQ+CIDJY=;
	h=From:To:Cc:Subject:Date:From;
	b=QRWI5GFAW6z8fUWFxdiQGDzgXvtk9krletOSjAd6lXQPBv0SrcjkBQb++cU8R7lVX
	 UOivlMJMa/FBsbUZxQhmXJVwEnv6Qb2GGIoncKAJQFIFYGWvjYU3rhFR7fJ1EyTSCM
	 Q+7w4mfMXc71wPs0VNuZvU/rX0dTzuDXT4PZgOpXFFBffwgL+iwzwwXl4D8C/H9ngh
	 AWtf5MUN5wt0tfKJ27DS9WBd3bwivlo0QSHTr7jlgdK346RFPSJm1fsShYiiW7wCBy
	 FE0X40nwE6iQbFiLT8hgw9WkRUJF5oXV7Uxauduwiyfc07MXV8pmazCkVazC6NNexa
	 xLp02XsYY6B9g==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: aalbersh@redhat.com,bfoster@redhat.com,dchinner@redhat.com,djwong@kernel.org,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,samsun1006219@gmail.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to 25576c5420e6
Date: Sat, 04 May 2024 19:52:33 +0530
Message-ID: <87o79lejvd.fsf@debian-BULLSEYE-live-builder-AMD64>
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

25576c5420e6 xfs: simplify iext overflow checking and upgrade

13 new commits:

Chandan Babu R (1):
      [0370f9bb49f1] Merge tag 'xfs-cleanups-6.10_2024-05-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeF

Christoph Hellwig (7):
      [45cf976008dd] xfs: fix log recovery buffer allocation for the legacy h_size fixup
      [67a841f9d724] xfs: clean up buffer allocation in xlog_do_recovery_pass
      [f7b9ee784511] xfs: consolidate the xfs_quota_reserve_blkres definitions
      [cc3c92e7e79e] xfs: xfs_quota_unreserve_blkres can't fail
      [99fb6b7ad1f2] xfs: upgrade the extent counters in xfs_reflink_end_cow_extent later
      [86de848403ab] xfs: remove a racy if_bytes check in xfs_reflink_end_cow_extent
      [25576c5420e6] xfs: simplify iext overflow checking and upgrade

Darrick J. Wong (5):
      [a86f8671d03e] xfs: use unsigned ints for non-negative quantities in xfs_attr_remote.c
      [a5714b67cad5] xfs: turn XFS_ATTR3_RMT_BUF_SPACE into a function
      [204a26aa1d5a] xfs: create a helper to compute the blockcount of a max sized remote value
      [3791a053294b] xfs: minor cleanups of xfs_attr3_rmt_blocks
      [1a3f1afb2532] xfs: widen flags argument to the xfs_iflags_* helpers

Code Diffstat:

 fs/xfs/libxfs/xfs_attr.c        |  7 ++-----
 fs/xfs/libxfs/xfs_attr_remote.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------
 fs/xfs/libxfs/xfs_attr_remote.h |  8 +++++++-
 fs/xfs/libxfs/xfs_bmap.c        | 21 ++++++---------------
 fs/xfs/libxfs/xfs_bmap.h        |  2 +-
 fs/xfs/libxfs/xfs_da_format.h   |  4 +---
 fs/xfs/libxfs/xfs_inode_fork.c  | 57 +++++++++++++++++++++++++--------------------------------
 fs/xfs/libxfs/xfs_inode_fork.h  |  6 ++----
 fs/xfs/scrub/reap.c             |  4 ++--
 fs/xfs/xfs_aops.c               |  6 +-----
 fs/xfs/xfs_bmap_item.c          |  4 +---
 fs/xfs/xfs_bmap_util.c          | 32 ++++++++------------------------
 fs/xfs/xfs_bmap_util.h          |  2 +-
 fs/xfs/xfs_dquot.c              |  5 +----
 fs/xfs/xfs_icache.c             |  4 +---
 fs/xfs/xfs_inode.h              | 14 +++++++-------
 fs/xfs/xfs_iomap.c              | 13 ++++---------
 fs/xfs/xfs_log_recover.c        | 33 ++++++++++++++++++++-------------
 fs/xfs/xfs_quota.h              | 23 +++++++++--------------
 fs/xfs/xfs_reflink.c            | 34 +++++++++-------------------------
 fs/xfs/xfs_rtalloc.c            |  5 +----
 21 files changed, 160 insertions(+), 214 deletions(-)

