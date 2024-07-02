Return-Path: <linux-fsdevel+bounces-22947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1A0923F67
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 15:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E055283EDD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FB91B4C55;
	Tue,  2 Jul 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3xZmkLP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F20D38F83;
	Tue,  2 Jul 2024 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928072; cv=none; b=kPTlhllrjlSSYSoRt2UcJQbqUwajfMV/JSdUnRNh7dacEBOSihDx55hVswMglOHVqmYPjltwP7OVA/e0TuOdwrVsiwCuNrtijZVt6GrM4kzfPfTs1os14ezxM/DgBYFSI69pFo1z1qQUGAff94snArQzaZnoaC8YsG33ni+z/Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928072; c=relaxed/simple;
	bh=wTAGGPz5RZwwOrDI5MiT8Qlab3A7rVI4fdnHkNtqt+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eAjl8ubzpkreyFYe0ulGRENJpNRGXfqZ2pWm+tTrDcc2hSjLeK6Ii+D6uGPwAM19/qH1t/zSEWMfSjd6/oFaQwGurHcQ3gGu4tK3pyDZBs2o/W9f/ECm72x0SqaICU8LVnkrBp6cZlTRYnf8clZBDhYnqJ6dmv/uedrrTrFqEYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3xZmkLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E538C116B1;
	Tue,  2 Jul 2024 13:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719928071;
	bh=wTAGGPz5RZwwOrDI5MiT8Qlab3A7rVI4fdnHkNtqt+k=;
	h=From:To:Cc:Subject:Date:From;
	b=X3xZmkLPtLvQZTk7vM6AQznn+4LFam3xDpSzHKw0e1bwGxES2LixXIq2Vn66f4nHF
	 ck6Ls11PXT3lDzNNU0397TrTzbYmxdfcCsXd9UlRaM79ZerIczGEOmmiIXmR/2GypS
	 M38afacAV6x27r1gtlPPVMuchzKHTbBX+wLFFLqedGKn/+vpW5S8NnHfOgxhfjdBho
	 OiD6npM9IMLJZAOdg/Vsoi05NbPodY5krZZNoeyOXKpO8esDwh1rww7RCDBPHclPIT
	 WA3x6NBxNt726ERYKkVj1DR960Hdazx0n6xEc96RwYSTGA75OZtPUTXnP3iEOvP4f8
	 xKGCIS2aoP73Q==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, 4@web.codeaurora.org,
	cdlscpmv@gmail.com, dchinner@redhat.com, djwong@kernel.org,
	haowenchao22@gmail.com, hch@lst.de, hsiangkao@linux.alibaba.com,
	john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, llfamsec@gmail.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to 3ba3ab1f6719
Date: Tue, 02 Jul 2024 19:16:47 +0530
Message-ID: <8734orc3cr.fsf@debian-BULLSEYE-live-builder-AMD64>
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

3ba3ab1f6719 xfs: enable FITRIM on the realtime device

13 new commits:

Christoph Hellwig (6):
      [8626b67acfa4] xfs: move the dio write relocking out of xfs_ilock_for_iomap
      [29bc0dd0a2f6] xfs: cleanup xfs_ilock_iocb_for_write
      [9092b1de35a4] xfs: simplify xfs_dax_fault
      [6a39ec1d3944] xfs: refactor __xfs_filemap_fault
      [4e82fa11fbbc] xfs: always take XFS_MMAPLOCK shared in xfs_dax_read_fault
      [4818fd60db5f] xfs: fold xfs_ilock_for_write_fault into xfs_write_fault

Darrick J. Wong (1):
      [3ba3ab1f6719] xfs: enable FITRIM on the realtime device

Gao Xiang (1):
      [d40c2865bdbb] xfs: avoid redundant AGFL buffer invalidation

John Garry (2):
      [d3b689d7c711] xfs: Fix xfs_flush_unmap_range() range for RT
      [f23660f05947] xfs: Fix xfs_prepare_shift() range for RT

Wenchao Hao (1):
      [a330cae8a714] xfs: Remove header files which are included more than once

lei lu (2):
      [fb63435b7c7d] xfs: add bounds checking to xlog_recover_process_data
      [0c7fcdb6d06c] xfs: don't walk off the end of a directory data block

Code Diffstat:

 fs/xfs/libxfs/xfs_alloc.c      |  28 +--------
 fs/xfs/libxfs/xfs_alloc.h      |   6 +-
 fs/xfs/libxfs/xfs_dir2_data.c  |  31 ++++++++--
 fs/xfs/libxfs/xfs_dir2_priv.h  |   7 +++
 fs/xfs/libxfs/xfs_trans_resv.c |   1 -
 fs/xfs/scrub/quota_repair.c    |   1 -
 fs/xfs/xfs_bmap_util.c         |  22 ++++---
 fs/xfs/xfs_discard.c           | 303 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 fs/xfs/xfs_extfree_item.c      |   4 +-
 fs/xfs/xfs_file.c              | 141 ++++++++++++++++++++++++--------------------
 fs/xfs/xfs_handle.c            |   1 -
 fs/xfs/xfs_iomap.c             |  71 +++++++++++-----------
 fs/xfs/xfs_log_recover.c       |   5 +-
 fs/xfs/xfs_qm_bhv.c            |   1 -
 fs/xfs/xfs_trace.c             |   1 -
 fs/xfs/xfs_trace.h             |  29 +++++++++
 16 files changed, 476 insertions(+), 176 deletions(-)

