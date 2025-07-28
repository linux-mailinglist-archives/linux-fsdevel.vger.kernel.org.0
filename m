Return-Path: <linux-fsdevel+bounces-56209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97917B144EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57F24E3845
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BBC24DD17;
	Mon, 28 Jul 2025 23:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuaRqdb/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B4C288529
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 23:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746045; cv=none; b=cxlle/R9z0ToJZhLJ8TWo2YoIAtZ5VcAsIOysyuIarzIDCsNqYr34xECRH5mcybQ7qX9IofrqsLxmnN6xSIJ0LfHt0a3eOZw65J9tVgiP4TeJS3ht5z6p24uESKXJI6JQYSDniErgaH/PTaoaEU+tm0WUuJ/ZeZ99yx7FfD45lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746045; c=relaxed/simple;
	bh=3LZKuZ1e9+/EsMBWbYYpGJGEdN4OEF/3xp/FkiEgvDw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tDI+qIiKeCAr1+wkvTEkxDJp1ctQjjeg9DvxS94VSW5enOHaIqHeV7y7VKbsWSRlbW0mi3uI5HL/M6tWYpU7Pos+Cs5mJ6duHtdQU5jfbvKzJdKu+ndgxrhYcrCS/IbtN5aENw0jt6e4SveVSXc4s+GJCmQmOzfojbcB4bI650o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuaRqdb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F5AC4CEE7;
	Mon, 28 Jul 2025 23:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746045;
	bh=3LZKuZ1e9+/EsMBWbYYpGJGEdN4OEF/3xp/FkiEgvDw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WuaRqdb/KRBLGdg1HDJeLi+EQjR5Va4M6ftZRZZk2ZKYHAiBxH+yG97Epmt8UThHu
	 dKoLNHWMhp9Ewbbqb/Zr9sGNUmvmNq/0m5u8+No28CPcW3BjJ3cDjCF0bSgB6SgINq
	 SrKx3rSEr9zycOwsEXDN+GC1szXtmZcf2n8dq7IyLl/2KK3a+HR3H+yfTQ2rew/ufo
	 Y/+PLXpvQdHg8Gia+S60jtMRaqjNaTQJqRg7W4PAFAiV0iCWbCaR24TCHp9DnZU4mF
	 0PFwRmF/aD9u4/2EuSg27sLRPvAa48U5JtaeykK6//6qulq81o92zfBXs4R0tgxTFc
	 c/8MFTCdc72JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB7F9383BF5F;
	Mon, 28 Jul 2025 23:41:02 +0000 (UTC)
Subject: Re: [git pull][6.17] vfs.git 1/9: d_flags pile
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250726080119.GA222315@ZenIV>
References: <20250726080119.GA222315@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250726080119.GA222315@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-dcache
X-PR-Tracked-Commit-Id: a509e7cf622bc7ce3f45b1c7047fc2a5e9bea869
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11fe69fbd56f63ad0749303d2e014ef1c17142a6
Message-Id: <175374606171.885311.6944917402405275285.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:41:01 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 09:01:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-dcache

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11fe69fbd56f63ad0749303d2e014ef1c17142a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

