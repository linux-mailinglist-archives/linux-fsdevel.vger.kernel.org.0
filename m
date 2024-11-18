Return-Path: <linux-fsdevel+bounces-35147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 090119D19FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 22:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3013B2268A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 21:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3D01E7C31;
	Mon, 18 Nov 2024 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkXph4qu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB0E1E7C11;
	Mon, 18 Nov 2024 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963620; cv=none; b=YpgAbWHIB+dq3U4SDdt3CFZNV9KwHGMCBP9bh6c+k+l5R2IEeg4qvElETt7G4stmTKTQAeAbpkDQnry89nixhVlGI7kVDvcAsENKBOaOExyFeDSPrxOcwbONq/IFNPfRo5psAp1LfQyCbRadNjCyrnls9MW7P9mIYFkpMVcCV84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963620; c=relaxed/simple;
	bh=pYZN+3z94nRKCyTDkqPE28zBzH8DTAOdMoOU1sCVcxY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Z5XhX0enMMLtuuHwtYIdMhaohRXsbd9oNWNj2jdmXVRT4MpUziUaBQ7aMEs7b1KTXeZ2GbOkYEz8mHcxwUCiBLQhmL3KwhyK3ILPDir1EsBuH9GCO50J9ieq7gYWnVPFtQz8ud41UY/GES9fdS5CE2ssDWnlTnVE+G2yUytC2hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkXph4qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029F9C4CED8;
	Mon, 18 Nov 2024 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731963620;
	bh=pYZN+3z94nRKCyTDkqPE28zBzH8DTAOdMoOU1sCVcxY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WkXph4qudyR6Mr3cwoSnpIneRboIoa6x8k5dk4e4hPBbZd5fevQxqEH4g0Ut8AUen
	 yjsqNOsB0/cNIwzVMuRKipaYxVSpFw/nWZZClMS3GXOlfIjd0X/4M5+ZEOGqbeCkXI
	 tZmxUTnkJsj5wHOguO6zwR/fHy2LcdKJ9lBUMflAb35QwDqC6WhvY/IZYSs8xBm5Mz
	 YkrMzNnvLDAzynFEXWADQRff2It6KH5Atzc/v54XTUyFpYKC54KfSGHqrXIwxveLd7
	 BkfhMwzRczKrzMXNPpND+nil/wU7Ght7XqGPWjVSBVmyI+L7gFUIBcx84kkID2rkFv
	 TCzg7RoTbMB3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9AF0E3809A81;
	Mon, 18 Nov 2024 21:00:32 +0000 (UTC)
Subject: Re: [git pull] xattr stuff
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115150806.GU3387508@ZenIV>
References: <20241115150806.GU3387508@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115150806.GU3387508@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-xattr
X-PR-Tracked-Commit-Id: 46a7fcec097da5b3188dce608362fe6bf4ea26ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82339c49119f5e38ca3c81d698b84134c342373f
Message-Id: <173196363147.4176861.5192466636479059630.pr-tracker-bot@kernel.org>
Date: Mon, 18 Nov 2024 21:00:31 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 15:08:06 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-xattr

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82339c49119f5e38ca3c81d698b84134c342373f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

