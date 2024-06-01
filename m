Return-Path: <linux-fsdevel+bounces-20707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB0E8D7056
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 15:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4547CB21E07
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 13:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E3215216A;
	Sat,  1 Jun 2024 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHU91Krr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680D14267;
	Sat,  1 Jun 2024 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717250377; cv=none; b=q0WmuiWLzAmAeGJCQMHxO4XjMH1LPORCAOomM4LkSAV7CJAQ05sooq6IIBmEREFnGdLXvZg0U2W2LRyp5Y20YePwyKt6VtcolOZRor8rp0KqVWmQm8wV4K3STAajSvH+v6wkZ9kmby580xIzVfl2CqWKxb9aZc9EVMe439h1Rpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717250377; c=relaxed/simple;
	bh=2n194l4N524yZXAcuX+GKrEjUkd6WzRDbNokvT1uDzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=io+H3Shl4C4ideyLFAUSiQY9/gEi6AaAOKbolF0kPgRRKXb9E6wbVmNY2A1xHcmvBVARWLV9/m3mR2visayDkDFMrp234En53/juBsgDSxdOGJuTclpx2ZtUahuWEC5/6e/9RdQT6IaFrL83BBywEPIKZvyOZ/yutLgwMsdYUdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHU91Krr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CAAC116B1;
	Sat,  1 Jun 2024 13:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717250377;
	bh=2n194l4N524yZXAcuX+GKrEjUkd6WzRDbNokvT1uDzQ=;
	h=From:To:Cc:Subject:Date:From;
	b=fHU91KrrdhBX/PEG3l1SL7O0rnx7It5YZheepYfxEXR/DA3J5RHtdF6FSRjO+i2dV
	 I/4yIlC2lAeE+2CZXaCuC2N9q3sTVKtN2N8NlrCnQHOqiftJ15UyEMISrjWMXHdQCu
	 HC+rdG6oGiIzBHxZQXCWojeG8wF21aftPj1Ttl1lcaSiftYmyNP0cZNYicxlzFWhGL
	 jLYGfz8Z7q1/4WD21eHRYV08orK8S+GKbuPCyvaX8OJWEeR5CyqzvHWYmPWoyFUwVY
	 TLmPD2i7ijiVue6Lt4UkBAisrSvkcUTEHnMEmzzVSL3A26C1lBhmGNFPiZGu1JYH1u
	 kC2lhPsXXLuXw==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: chandanbabu@kernel.org,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: bug fixes for 6.10
Date: Sat, 01 Jun 2024 19:25:29 +0530
Message-ID: <87cyp0wypl.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch which contains XFS bug fixes for 6.10-rc2. A brief
summary of the bug fixes is provided below.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.10-fixes-1

for you to fetch changes up to b0c6bcd58d44b1b843d1b7218db5a1efe917d27e:

  xfs: Add cond_resched to block unmap range and reflink remap path (2024-05-27 20:50:35 +0530)

----------------------------------------------------------------
Bug fixes for 6.10-rc2:

 * Fix a livelock by dropping an xfarray sortinfo folio when an error is
   encountered.
 * During extended attribute operations, Initialize transaction reservation
   computation based on attribute operation code.
 * Relax symbolic link's ondisk verification code to allow symbolic links
   with short remote targets.
 * Prevent soft lockups when unmapping file ranges and also during remapping
   blocks during a reflink operation.
 * Fix compilation warnings when XFS is built with W=1 option.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (4):
      xfs: drop xfarray sortinfo folio on error
      xfs: fix xfs_init_attr_trans not handling explicit operation codes
      xfs: allow symlinks with short remote targets
      xfs: don't open-code u64_to_user_ptr

John Garry (2):
      xfs: Clear W=1 warning in xfs_iwalk_run_callbacks()
      xfs: Stop using __maybe_unused in xfs_alloc.c

Ritesh Harjani (IBM) (1):
      xfs: Add cond_resched to block unmap range and reflink remap path

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

