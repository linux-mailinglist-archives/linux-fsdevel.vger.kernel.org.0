Return-Path: <linux-fsdevel+bounces-27289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD449600C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16FF91F22669
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD646EB5C;
	Tue, 27 Aug 2024 05:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="he2QB7YF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB04017993;
	Tue, 27 Aug 2024 05:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735096; cv=none; b=uI24jZu9WReTlwWwWweSv3cc1Jfz3DZXMG8VrgeHVcdJPd7r7yz7+ajyxZCMaP+nSr/0xoDZ/UTz1CWDcWcvPCgtxsKTSuDbV9zJBDJ2X2VCqYSifwClogW2ppQsZcfns9Gqjkm6Uj9iEoA1VoyrWWdC7YnFSZZS04MM0Shrs/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735096; c=relaxed/simple;
	bh=OAoazsHHRUAwHCFhxU0/ouvkTEj3ign4cLLYWrYhs7w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OapaGuZDhyFYk4wbvZ09o4oUmMybOxXLFv3yxn0Q4oHiFb3F3EGMFCoXnxfLz64FhMcuseugoFwThXNWXuIl61UpvwYJTZcxm81kwMPyUhe027TPQ2+opVDtzxBSFh6NyIySi9xNwmdQ956kEq4IQBkf0Jw+snvnkoSIAALFpL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he2QB7YF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FDEC581A9;
	Tue, 27 Aug 2024 05:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724735096;
	bh=OAoazsHHRUAwHCFhxU0/ouvkTEj3ign4cLLYWrYhs7w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=he2QB7YFgpG0eAJdk2oJAoHK8vGADspf9IjQ741GBiUQUEYTBpG2OIl3cij0Yoauz
	 W6cXr5kC0p3I89uztndUwFzzGJSGAJg+9U8NZn5HZB1gyAu4a7CYlVIRoLjgPfCDc0
	 pwNgNjcFnxjl1XLIt0wsjVUZa8fLPER+BCtsRF8xxUgdb2HDr9mJCodTJgyDBVZ11P
	 eLrJdIrLAeFO7rQNRoqNExZ8ieiwUA2ovkpUEaISydn4f2PcRRnrEbbp9/jgXXUlgJ
	 o3H27mvb0C0PmhM8hM2S3owhQuIqN6Ip5AjH0Yf2NcbniPvK3CU1BCjDIA4ts4fjLM
	 JQN2NP4/W6W2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF183806660;
	Tue, 27 Aug 2024 05:04:57 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240826-vfs-fixes-3028447211c8@brauner>
References: <20240826-vfs-fixes-3028447211c8@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240826-vfs-fixes-3028447211c8@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc6.fixes
X-PR-Tracked-Commit-Id: e00e99ba6c6b8e5239e75cd6684a6827d93c39a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e9bff3bbe1355805de919f688bef4baefbfd436
Message-Id: <172473509653.215084.12774581314349161488.pr-tracker-bot@kernel.org>
Date: Tue, 27 Aug 2024 05:04:56 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 26 Aug 2024 17:25:04 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc6.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e9bff3bbe1355805de919f688bef4baefbfd436

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

