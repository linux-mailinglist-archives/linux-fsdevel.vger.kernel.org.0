Return-Path: <linux-fsdevel+bounces-7849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A8A82BAA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 06:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58626B22BEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 05:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301455C8F4;
	Fri, 12 Jan 2024 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1QQXl7S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DFE5C8E7
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 05:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FE5AC433F1;
	Fri, 12 Jan 2024 05:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705036067;
	bh=8houUmOj7pqJOyIURKOlQvC7sspMvU3rfm+69daPF4o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V1QQXl7S0033+jjhKMHfwstCw+CKyYHgCG7DBROx6XQjwi33oVZUJXRIeUojMnzCf
	 SB3VBVZdfga4KjWmVIYEynDpOPrsYfpe838DAK5dLDdxStbWoPnI/1xYDbLHoQbLfY
	 AOXnokrfL1SHcRxcQQRmOP7LRcRb/wD3pO2f54drpdzZaB1gBSb62Ob2heFgFd0QuS
	 n6TAgKuBwKR2vdqGKZFtuSrr78g+2V29WCF0e6iuopXThqdvGWT4IXuGcFOMfg/voK
	 D3Wd2sWh/j1z/NVsjFO5XG5r1n78O0jlpB0H3ST/jLls4SA8Ea5O+7K9ka9Iu/OB/P
	 oPSzKX2B6Hclw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F437D8C972;
	Fri, 12 Jan 2024 05:07:47 +0000 (UTC)
Subject: Re: [git pull] vfs.git minixfs series
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240111101634.GV1674809@ZenIV>
References: <20240111101634.GV1674809@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240111101634.GV1674809@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-minix
X-PR-Tracked-Commit-Id: 41e9a7faff514fcb2d4396b0ffde30386a153c7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f444347a8d6b03b4e6a9aeff13d67b8cbbe08ce
Message-Id: <170503606738.7299.17535488313295398263.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 05:07:47 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jan 2024 10:16:34 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-minix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f444347a8d6b03b4e6a9aeff13d67b8cbbe08ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

