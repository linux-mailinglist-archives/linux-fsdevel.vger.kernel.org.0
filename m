Return-Path: <linux-fsdevel+bounces-54763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C97B02C58
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 20:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D41A405F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 18:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA77428D8FD;
	Sat, 12 Jul 2025 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfMtWgUU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EE328CF5D;
	Sat, 12 Jul 2025 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752344101; cv=none; b=lMc+ywduTFtVA4pvu7Y8cgvDLJgy5n5vV50ADfKjQT704MZJ4o3TqjsI9bRggSc85iYdRWCMvonNOQMNIQuNV/tA5qXcJCZ6N5bg5fzCijn1nJHT56Bb6JclEwZp3ZYOxgbI4SqGy1/EWxbpmX+hUM9b3lpFnOYyY7DylKA6YvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752344101; c=relaxed/simple;
	bh=Z40NUk9emlT/nRO6A0g8lOmulcjqezpPuIat1qDc0h4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JrYxbzYmUJLtxWOO2qUt7tIGy2QcIPvmp1kEJsaPMBZXUUI8CSzoYP/BfsRo2Aim4fzR/V8cqgjr38Wom1qkiU8zXHknA7r94nBldxpMoSIgSLztBnZ9K8XoG3gC84uXZQJxrMPg6v+tZJ2qohq/7cH/7nC3Tcwaw8I3FiBOGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfMtWgUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F4EC4CEEF;
	Sat, 12 Jul 2025 18:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752344101;
	bh=Z40NUk9emlT/nRO6A0g8lOmulcjqezpPuIat1qDc0h4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EfMtWgUU7LTZ8XZeOoiEmtbDgEX8tKaEujFAuPxvcTGLeK6KJHJWMMkBEYnVeth7R
	 4o2Xfc/E/C/DJ04Onnpcp4GkowpFnwvGAk+QVqHguDdpnl3JjlYdSsW+EOyYGJnoKp
	 maB73Lc399EhdeZlc9SVTIXIS16HZfCl1wlYXsEaQ/l+dJDOcU0ukpXPWZkaeJEyGM
	 PfjRLns7/uUgdjCK9ZoU8Qjl34Mw5TIoGRMvWL671smM3oWEOMIMgVaXnayK7n2eyS
	 8StqwdVWAu22pIOwKgaDZf0lNNRjGy/eTVTnJj2SJSwEuDBgtlqx6xp7UXInrN4Oem
	 XzFRoTWzgARjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAECE383B276;
	Sat, 12 Jul 2025 18:15:23 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <hmihnrl4tzezjnhp56c7eipq5ntgyadvy6uyfxgytenqfbzzov@swfpjfb2qkw5>
References: <hmihnrl4tzezjnhp56c7eipq5ntgyadvy6uyfxgytenqfbzzov@swfpjfb2qkw5>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <hmihnrl4tzezjnhp56c7eipq5ntgyadvy6uyfxgytenqfbzzov@swfpjfb2qkw5>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-07-11
X-PR-Tracked-Commit-Id: fec5e6f97dae5fbd628c444148b77728eae3bb93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4412b8b23de24a94a0b78ac283db043c833a3975
Message-Id: <175234412252.2616006.1162311898013007042.pr-tracker-bot@kernel.org>
Date: Sat, 12 Jul 2025 18:15:22 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Jul 2025 09:01:48 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-07-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4412b8b23de24a94a0b78ac283db043c833a3975

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

