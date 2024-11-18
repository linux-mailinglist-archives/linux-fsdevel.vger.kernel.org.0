Return-Path: <linux-fsdevel+bounces-35146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05259D19FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 22:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59C3DB2217D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 21:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731311E767D;
	Mon, 18 Nov 2024 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KO6NefLY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4801E631D;
	Mon, 18 Nov 2024 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963618; cv=none; b=iPwzF/21lN8Rztp+yy5GtVF+ZYriJ2Q6LIFncFc71v/WnkTs6PcIWiYBq+SxbDGo0G+qTowngPTjgEoyajnBhqqOGflmm/WY4DAB+OboV5HgAH5r3PGfL1AmLOIA4bzlMySLtGIaXQX2YnfzFrd9k5JZRjyd2NHXbNslOO7iQ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963618; c=relaxed/simple;
	bh=WjjkdzkqkVO6PePM3tvNVGio90Xt8Zai3gnAoJQB+h8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PjiwqamywWCdFj81McsYetapapaYnT1b6ac2vyCZEuevrP6pI2cFZPpfT7lWxsagrvty0E7HU9Jm2m6XowPi+OJCQpRlT9WCO/xMcd2Mm7h/tElPdZcQR/o8i0ILmKXeURjq4jPucZ5mzSrtdoz62qCgCZZpVZcGZL00xWSEooI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KO6NefLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE79AC4CED7;
	Mon, 18 Nov 2024 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731963618;
	bh=WjjkdzkqkVO6PePM3tvNVGio90Xt8Zai3gnAoJQB+h8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KO6NefLYoQGNnsrrVW4yYRu9PIUpCYMU4cHzHR1FRFzO4mR4jawlRApxMB4OkRYj8
	 BkxdvZEcQ5ty8BcsZUz3KTLFCbGPFKg1uK04RTii4WuXWA9hHtHOzAHS/62+hPFMXR
	 O5we05lhOZ54X2H47+jhen7ZB9y5um7XCpOPjafG9WXlzCas5NTNWAx+b4HFO5o0Mv
	 X94NWxjlN0wtpmunmGA0K8LQWr+suSBRptKG1rt5/V6rYgKFXNxbCUmpcgrx3KRrRy
	 fKHuGqVIzN9jU0lMsP/QbW+cUZ1j3uBFKLTR9+BFDxQsHm0p4Ir0RF+I4x2VHStYkR
	 NGMEjJs8pX3JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EAE93809A81;
	Mon, 18 Nov 2024 21:00:31 +0000 (UTC)
Subject: Re: [git pull] struct fd series
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115150209.GT3387508@ZenIV>
References: <20241115150209.GT3387508@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115150209.GT3387508@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fd
X-PR-Tracked-Commit-Id: 38052c2dd71f5490f34bba21dc358e97fb205ee5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f25f0e4efaeb68086f7e65c442f2d648b21736f
Message-Id: <173196363000.4176861.8787654796750919846.pr-tracker-bot@kernel.org>
Date: Mon, 18 Nov 2024 21:00:30 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 15:02:09 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f25f0e4efaeb68086f7e65c442f2d648b21736f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

