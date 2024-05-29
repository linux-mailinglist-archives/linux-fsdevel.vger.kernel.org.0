Return-Path: <linux-fsdevel+bounces-20407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EF28D2DCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 09:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769231C23587
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 07:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230371649C2;
	Wed, 29 May 2024 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3hv+vxv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BE52F32;
	Wed, 29 May 2024 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966558; cv=none; b=TRKv1/dkiHopL33FV2q6jEmi7Zb09v7I0KN6b6VYW26oemwpQJtG9YtA2sMHWwxvfx0cE6a6uUtmtjt3hVyv7b7QPBhXfynDMxRz+Bywc2eTDs4k9ciuVhlag2WfjwqGD3BjKJNPcnh5P1ZFPHuAR22UEsNTsMxLEzxT2jumhsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966558; c=relaxed/simple;
	bh=b+YAwrRdYcKfFOnIPL1HViPw0hDv02uRQVI1ZdE86xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AxwX+xeRwufZRN3Q0zvZ6FkmMF03ZiaAVH4S3RX10XPFqvIYduaMVmeGmiKU0DSf2MYNtzttEuqwcnp+8zr+V66LVdtYQBcVesWaVXsBRlxG+zsaHQFPMU78f1YG6bpxJte6ctuX4ECXsf2nZJcW2gcOD7VxSvp2UU5aGRN9tz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3hv+vxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A02C2BD10;
	Wed, 29 May 2024 07:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716966558;
	bh=b+YAwrRdYcKfFOnIPL1HViPw0hDv02uRQVI1ZdE86xg=;
	h=From:To:Cc:Subject:Date:From;
	b=q3hv+vxva8whLTDrS+RIROnGg8zomWvQslUjF7xPGMV3mUuwyzVAT6ZaPStKDd0ZM
	 vOnOua7sI/OkxDChO7Wz/kUFhfWk31DxB6EslJdi0ghVEyipzqccpQWlTJcMeEPSzV
	 zsWegdFnSyv9juUt74kFc9QeRZ6H7poBBgtGMk/W4xcFbxm8et278i8FLiHSaXAK9F
	 4ey4LCpj/Fqqg0UpMnd3azUOCgsxaUHMaO6WZKthf5qnfDmsNfYfXGmnRnW2SIhhPg
	 ZDGG/jipnRYgizMOAeCucQEKR+cciMGqhJD0kj0x+gi8fQkfZZQjxrrx3/taISNdlz
	 y8F126Rgw8tsw==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: disgoel@linux.ibm.com,djwong@kernel.org,hch@lst.de,john.g.garry@oracle.com,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,ojaswin@linux.ibm.com,ritesh.list@gmail.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to b0c6bcd58d44
Date: Wed, 29 May 2024 12:38:04 +0530
Message-ID: <87cyp5qelo.fsf@debian-BULLSEYE-live-builder-AMD64>
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

b0c6bcd58d44 xfs: Add cond_resched to block unmap range and reflink remap path

7 new commits:

Darrick J. Wong (4):
      [2b3f004d3d51] xfs: drop xfarray sortinfo folio on error
      [97835e686679] xfs: fix xfs_init_attr_trans not handling explicit operation codes
      [38de567906d9] xfs: allow symlinks with short remote targets
      [95b19e2f4e0f] xfs: don't open-code u64_to_user_ptr

John Garry (2):
      [d7ba701da636] xfs: Clear W=1 warning in xfs_iwalk_run_callbacks()
      [b33874fb7f28] xfs: Stop using __maybe_unused in xfs_alloc.c

Ritesh Harjani (IBM) (1):
      [b0c6bcd58d44] xfs: Add cond_resched to block unmap range and reflink remap path

Code Diffstat:

 fs/xfs/libxfs/xfs_alloc.c     |  6 ++----
 fs/xfs/libxfs/xfs_attr.c      | 38 ++++++++++++++++++--------------------
 fs/xfs/libxfs/xfs_attr.h      |  3 +--
 fs/xfs/libxfs/xfs_bmap.c      |  1 +
 fs/xfs/libxfs/xfs_inode_buf.c | 28 ++++++++++++++++++++++++----
 fs/xfs/scrub/scrub.c          |  2 +-
 fs/xfs/scrub/xfarray.c        |  9 ++++++---
 fs/xfs/xfs_attr_item.c        | 17 +++++++++++++++--
 fs/xfs/xfs_handle.c           |  7 +------
 fs/xfs/xfs_iwalk.c            |  5 ++---
 fs/xfs/xfs_reflink.c          |  1 +
 11 files changed, 72 insertions(+), 45 deletions(-)

-- 
Chandan

