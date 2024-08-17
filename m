Return-Path: <linux-fsdevel+bounces-26194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E78C9558D6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 18:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2637B1F2143F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AFC1537D9;
	Sat, 17 Aug 2024 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESC+WjCr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C838578C7D;
	Sat, 17 Aug 2024 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723911226; cv=none; b=AgYBCWICzB5WvxsAnOmEOm3Bv0sXn6lIQxrxfnsxhpZAdEbWDsL0dpwMV3QOd5ZER0Ssv0WN2wwJmlGhjK2VSKz3GO8n0Iv1MXqaKvlfm0APPsmcU7NY5hKJvqoe8t9bgBRdym//4sNj4AyjQe4jx/Mjk9xaQInt2RPFj1MBFDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723911226; c=relaxed/simple;
	bh=SqiBa7PG3G9VT4srixT6jNMGs+cSfopfQf3pdr2Ko98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FocXw6B/5o+NsB2HXLbgMVHHJ3j0bAi85IgnkfH8vWGgsMKHX66pm1mATaBBiDdlnoyMGP4rM4N/4OLPx47kVuBKPq2Jc+Xumajt12tLECmcZfS552x4XOt5va2nL79/8eSi7oU0IJVYYtirfj4WOLFXMiOR58GZeM6Me4kTcfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESC+WjCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0222C116B1;
	Sat, 17 Aug 2024 16:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723911226;
	bh=SqiBa7PG3G9VT4srixT6jNMGs+cSfopfQf3pdr2Ko98=;
	h=From:To:Cc:Subject:Date:From;
	b=ESC+WjCrJz+ydIximma3WHh62qDuokooq1Ry+MRoFarZZvdwaE/e6uHDPWmvfn7yL
	 SxqwcpfJoVvjmjM4CMW3jQwv823pQkh/Ol/XoBHqlfBLOPd9YmbeXWa0b1tFUoO6NT
	 e8OWmhVKnmD/Qyotvsu2Ryutrgc+WY8N4BypOgq4qPNlrtyTAM46EIulOgnipGPWS0
	 fx6iF62aGlbo0+mKiXe54jDCMgD4EdzQgxmOrJpUFbTmXJ7UxRPEhh1EEdYYiFtSfQ
	 Xy7mvenMu4sPRiFEh9cJzsDaeKWKOEmmF5WNaDE1kZbALIrYg9B97oNwUSwg+rd1gr
	 uNDhQamAOaNrQ==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: chandanbabu@kernel.org,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: bug fixes for 6.11
Date: Sat, 17 Aug 2024 21:41:24 +0530
Message-ID: <87ikvzm8jt.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch which contains XFS bug fixes for 6.11-rc4. A brief
description of the fixes is provided below.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit 7c626ce4bae1ac14f60076d00eafe71af30450ba:

  Linux 6.11-rc3 (2024-08-11 14:27:14 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.11-fixes-3

for you to fetch changes up to 8d16762047c627073955b7ed171a36addaf7b1ff:

  xfs: conditionally allow FS_XFLAG_REALTIME changes if S_DAX is set (2024-08-14 21:20:24 +0530)

----------------------------------------------------------------
Bug fixes for 6.11-rc4:

  * Check for presence of only 'attr' feature before scrubbing an inode's
    attribute fork.
  * Restore the behaviour of setting AIL thread to TASK_INTERRUPTIBLE for
    long (i.e. 50ms) sleep durations to prevent high load averages.
  * Do not allow users to change the realtime flag of a file unless the
    datadev and rtdev both support fsdax access modes.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (3):
      xfs: attr forks require attr, not attr2
      xfs: revert AIL TASK_KILLABLE threshold
      xfs: conditionally allow FS_XFLAG_REALTIME changes if S_DAX is set

 fs/xfs/scrub/bmap.c    |  8 +++++++-
 fs/xfs/xfs_ioctl.c     | 11 +++++++++++
 fs/xfs/xfs_trans_ail.c |  7 ++++++-
 3 files changed, 24 insertions(+), 2 deletions(-)

