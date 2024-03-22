Return-Path: <linux-fsdevel+bounces-15120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A518872E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 19:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A78D1B24964
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 18:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BBE633FC;
	Fri, 22 Mar 2024 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbILFQCZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43D360ED1;
	Fri, 22 Mar 2024 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131473; cv=none; b=nKDk7yP9bqC6mt5xG5UAejuv7SfA+VN+Sm1FqIt4PZV+RLnSxSeav4g2CiaZ5ANCHUdZwBX4+tZbJgmMXI0HGuuWA9oKBmZa9TeK8gLiDj3X4YJvDiVmzNGn6DhhXOJjBG3ueG5lHNHUd4DfOFezxLJ9VhEYxy+A8r3O1sC5ht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131473; c=relaxed/simple;
	bh=iBn2p3wyd060jdIp4uJQJ12OXO5ZzLXapD8UYNe05h0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EbipEDzjfCyBeUN/fKL4qyopCwaMigWtm5Xe+bAti8mAm0uRELPISgPe8Wjn2MaRvjwTgVEPAj3WuFy66enS4COld8mOjx1Z2dl/TN12yg0DCQX1CLAAbKHDqAv0uvReMZAh1GDtA4z9/PPu5rttHDS23ZR8YNFq5/+oVt9PTG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbILFQCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94431C433F1;
	Fri, 22 Mar 2024 18:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711131473;
	bh=iBn2p3wyd060jdIp4uJQJ12OXO5ZzLXapD8UYNe05h0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EbILFQCZ6kO5Ya13JaaVoim12eih88eefUsFy0RxzGNVoaqFnFxMY0uAODlB5cl04
	 1kRijHkgxpAk6FEkFpPRbTYpsZTiqLtGVR9+uDowYZ0SwgWI4gKOwvkvgST5rGj7OO
	 h4PF25kAaM6LU4CFb2h2vxzyK1Z7bqlzhfYPtgNV4cZZw6zxjKc1giDeZ9dIw9yIG0
	 uT5/cWfT+xhQ4T5qA9KgQiAbxGPVeuFC82ZTrBAn0nvV0VMHCmQ7HROYkxbL1ZKU64
	 8/1uaBgtNSpCFAo3D7hxFw1dYfXV6GxtizQyo1DobCdJ5kKBvON32TJoaWUprM02BW
	 8I2wRXW1pn1UQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 895CDD95058;
	Fri, 22 Mar 2024 18:17:53 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: Bug fixes for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <874jcymlpd.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <874jcymlpd.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <874jcymlpd.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.9-merge-9
X-PR-Tracked-Commit-Id: 0c6ca06aad84bac097f5c005d911db92dba3ae94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f6efce52d3a035b8332969ecf254b4dfc62e4ec
Message-Id: <171113147355.17281.9514370945927305585.pr-tracker-bot@kernel.org>
Date: Fri, 22 Mar 2024 18:17:53 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Mar 2024 19:02:00 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.9-merge-9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f6efce52d3a035b8332969ecf254b4dfc62e4ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

