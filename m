Return-Path: <linux-fsdevel+bounces-22175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA8E913434
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 15:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B84B23325
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4285816F269;
	Sat, 22 Jun 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOxGh6Ic"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35A1581F0;
	Sat, 22 Jun 2024 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719063534; cv=none; b=bJ0pVGrgIZxPeYDwkvYTTWsE4jUy/sEoH8K6oRylBP6DmINjABrMPmkHpEmjaDvLF9WMV9pmTyDE4ndeP9t/FEYE/n1Q7UYBw1Yd0xhsHu4W9x2nacxYD2Nk92aQGFgA3c4D8qorqzMgKYnE3EPtEOKGDLwsAIgsOu49E2fFh84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719063534; c=relaxed/simple;
	bh=Sp9yOYZHymIqT0TBXS0ZqZWwW4mP9SIZPkTdYOOGfGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AMaKSmUilTpeTEprIT+2wrxIsPyYVkGNc6VM+dcF+HoEN0wGlUSk+jcKSZF2NKHAOelsSPH13VD7ivW5IxeRJef2IOEv00Nq1mFslFr2Vc6N/PDJZewwV5YOHnaa0xocuncBtfJ6EJObJ4EIGc3LF3nd5b/iqRPJPnqqCnuTHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOxGh6Ic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F72C3277B;
	Sat, 22 Jun 2024 13:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719063534;
	bh=Sp9yOYZHymIqT0TBXS0ZqZWwW4mP9SIZPkTdYOOGfGY=;
	h=From:To:Cc:Subject:Date:From;
	b=hOxGh6IczbOxpUQWxSCr3DaQamZz7tEFlR+u7dgWV9kmCr6j33LT1UX2EF/+m3g/G
	 rO9zyCORtDllnXnqbVbXbGM5z+OBo1mSjYcgwu99H3pG9MKaz5gOyWn8YD1ZEhc8EM
	 b1HibO7KxnoLXQzbDqIGDEQAJvCM3LJCWacy+ZsC/25xbjWz8yje4Ua8Wc24HdGRxp
	 GJKAhuZV5zbuoheJf3lCh8ZnWYdBydsGIhFEjSis7B5CEsowkoLGg5Sdx2KTa3/qJo
	 VYXbymSIsOkfO4hSz3ijYicMBP0gvLV4KVUH07a5rTiZkr3dzIt1tQgL34tr5oj9tI
	 VDO/AzjLyQhvA==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: chandanbabu@kernel.org,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: bug fix for 6.10
Date: Sat, 22 Jun 2024 19:05:49 +0530
Message-ID: <87r0cpw104.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch which contains an XFS bug fix for 6.10-rc5. A brief
description of the bug fix is provided below.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.10-fixes-4

for you to fetch changes up to 348a1983cf4cf5099fc398438a968443af4c9f65:

  xfs: fix unlink vs cluster buffer instantiation race (2024-06-17 11:17:09 +0530)

----------------------------------------------------------------
Bug fixes for 6.10-rc5:

  * Fix assertion failure due to a race between unlink and cluster buffer
    instantiation.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Dave Chinner (1):
      xfs: fix unlink vs cluster buffer instantiation race

 fs/xfs/xfs_inode.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

