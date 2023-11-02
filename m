Return-Path: <linux-fsdevel+bounces-1875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0527DFA09
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 19:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ACEDB2142D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 18:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE52200AB;
	Thu,  2 Nov 2023 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiOkiGFl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C421BDEC
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 18:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C177EC433C8;
	Thu,  2 Nov 2023 18:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698950259;
	bh=623K6Wyxskk05A99rg/QqwpjErVo8ejBqmb/bbrE1cM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BiOkiGFlaEGmVGohIwx7ljoEBvqLXA1PA0KZUbWT4Io4Wmn/LCg+hpAO8AByhAjxD
	 wVhF8DSVLy7rGDCo8r3KH93hZQtz4xn2q78L9Fv1hRC4twMVizLRsiSdUN5dUFqdTC
	 E+hnygFrRBr3obZOVl2S1JrTivCcKkZozhhpyuSsjSsYGkycXZdxEuorJEQOg/j0T5
	 uBZhlv/ICERN5rMBVJZmXhv9DNfaWWl/UxzgbZkeuIHVnLn+OJVWIpazHTrIgNoNaz
	 ynfJqU4o+VjBiyaM7u3o5Gax/5xx+4CPvGI3vTWRlCQJBetnEzGvibVli2t9rGJwUC
	 CbR1bYmhslLPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0111C43168;
	Thu,  2 Nov 2023 18:37:39 +0000 (UTC)
Subject: Re: [GIT PULL] ext2, udf, and quota changes for 6.7-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231101103618.blacru23bck2xfe7@quack3>
References: <20231101103618.blacru23bck2xfe7@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231101103618.blacru23bck2xfe7@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.7-rc1
X-PR-Tracked-Commit-Id: 82dd620653b322a908db2d4741bbf64c12cbdb54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5efad0a7658cea6dfd22d4e75d247692e48dde10
Message-Id: <169895025971.19486.504760001869149531.pr-tracker-bot@kernel.org>
Date: Thu, 02 Nov 2023 18:37:39 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 1 Nov 2023 11:36:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5efad0a7658cea6dfd22d4e75d247692e48dde10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

