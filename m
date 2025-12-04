Return-Path: <linux-fsdevel+bounces-70623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3E1CA25A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 05:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D3CA30C15AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 04:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A132FC871;
	Thu,  4 Dec 2025 04:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCRv59YG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B752288C2C;
	Thu,  4 Dec 2025 04:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764823844; cv=none; b=Of/xoiBvYrArSDOr/XAnVFC1JTYk1xO+8n5mAZwpaJ2dBZWytJTQe2ayzxdCxhq+p8mf5bGF0QUkVSDrC3MDwuwUsuHSnWZz7jETFNpIpWGy+jkvIn5NXLLEyf+UEw+RmKP6QARQZm8Xg/kh+5km26H3KBSQ461NQ79F14smMNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764823844; c=relaxed/simple;
	bh=ser3dxQODKdCJ/52OXs8MXKZeSF/COdynZf7z4FQ6mQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l00RcPfsdyP/lYox9sVTeCFWUflNW/TY8c7CP5ZSamTRMpmJ4WqmS24+fRVaF80ZAxDP+xpzOy9sA908jPQ/vXTIGZGt+Rd6jIGGAUwTl8b5zbJ6TeZq4L+uAaPUWB0r4KmSa208NLQpZkUkHlxCsm6BLZDZZ2w/Gpl1uVSEzsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCRv59YG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A05C113D0;
	Thu,  4 Dec 2025 04:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764823844;
	bh=ser3dxQODKdCJ/52OXs8MXKZeSF/COdynZf7z4FQ6mQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TCRv59YGQyzRZ+X75emOIRN9aFYNNpOOCv4/XIzi3TQ/N2kCH9wUJDilW+QDaO4iE
	 KNqLo1DC8a7ZyCGNwZsEQ3+svC7LD6X0naQa+Ns8uTsVBIWFM/tFaR0JwWjSpZH5SL
	 ASTZyE800NQhbuYUq35ws7eA4rmcrQFQHH8XrhTuTBZhkYWuypGcbgHaNzYj9Ezskd
	 7QpK7O8zr0wOSoENqYuA6GJ8y5/HEe+kqzaTu66bbJZjGZRRPcO0WFg+MiF30e4aMq
	 gh7HqHrJSMrBAyhEdRcv2F9sXu3Ug3chs1gUveJwW0f3XvV79z1w3EyWGaxx3aWmoC
	 yV7JgKEqCknXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F284F3AA9A8A;
	Thu,  4 Dec 2025 04:47:43 +0000 (UTC)
Subject: Re: [GIT PULL] hfs/hfsplus changes for 6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <dd3e422fdf1624d4275723eb14935400b002f031.camel@dubeyko.com>
References: <dd3e422fdf1624d4275723eb14935400b002f031.camel@dubeyko.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <dd3e422fdf1624d4275723eb14935400b002f031.camel@dubeyko.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git tags/hfs-v6.19-tag1
X-PR-Tracked-Commit-Id: ec95cd103c3a1e2567927014e4a710416cde3e52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca010e2ef64ce2a8f3907a5c02f8109012ea5dc6
Message-Id: <176482366248.238370.13375550348410465537.pr-tracker-bot@kernel.org>
Date: Thu, 04 Dec 2025 04:47:42 +0000
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, dan.carpenter@linaro.org, penguin-kernel@I-love.SAKURA.ne.jp, yang.chenzhi@vivo.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 30 Nov 2025 19:36:12 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git tags/hfs-v6.19-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca010e2ef64ce2a8f3907a5c02f8109012ea5dc6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

