Return-Path: <linux-fsdevel+bounces-63052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7699BAA783
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 21:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D01A1C6B3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 19:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEFA29C328;
	Mon, 29 Sep 2025 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJZylGGW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0339A29AB05;
	Mon, 29 Sep 2025 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174283; cv=none; b=KgowcDaToxawkInSmXMf2fCRvWXDu4fVSVg0grz/Dvl0ZzAdKqg0L44pDPp904IAvodcOKJJeM4wdCNC6U17XjE47BenWIW5txMy2k+GX/J18oDehjSQp7KSs4BIPJebN7Wb/5DaaIbWadP0+fdEAqtzS3ucjzfSpBWsmgBGQL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174283; c=relaxed/simple;
	bh=ptJu0zQNzVgW74b6+fWLLC6qXBQEA8Dj5+tiW/o5dec=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tZd/dtfwaXkYAhf41efU9VjruDyAf66Y4mbTG8Cwn1DvwWTBDfQg3jkmZd6SIlT7+m0R9wwVpdb3Apj5Zwkf4bPpZtCBQYMt4MMLrNDv9gyRZNwg++mToPKAQG0bCBhgGUmPWCG9bzZJcnsobxmL+tWTNV4yJNwVogfH9LGhqFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJZylGGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA324C4CEF5;
	Mon, 29 Sep 2025 19:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759174282;
	bh=ptJu0zQNzVgW74b6+fWLLC6qXBQEA8Dj5+tiW/o5dec=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pJZylGGWy3v03MSabmgyw0S+UCIHViBEEkxtbd++xtdHiwzbm9UvXHvf0bd5be2Gq
	 G13KLmA8S1UCEcEJzgTyEvayKLqFBOYNLuOVFmJBxS5Cu7X7a8kjvtQJV8rT1oMTaC
	 l+RFYsdfyLJLq8qb3eDktqAyjSTIN/Dm9K3NLbwljeChh85bWPDcdrXGn6w21wLl4K
	 0e5M7yqN8GJTUc35yIjJOoY7LkNWxAgHgE1gas+E35ue731PdfNTEZ17n9LEJVai66
	 LlW0UuIy7jkSu5NNVkTB/0EVrUYSye7XUp9t7FFKUgSizgi0RhspzHW+0jt8fW/p83
	 fikFpnzdrdNHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE4839D0C1A;
	Mon, 29 Sep 2025 19:31:17 +0000 (UTC)
Subject: Re: [GIT PULL 9/12 for v6.18] afs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926-vfs-afs-633c36e4c55f@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner> <20250926-vfs-afs-633c36e4c55f@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926-vfs-afs-633c36e4c55f@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.afs
X-PR-Tracked-Commit-Id: a19239ba14525c26ad097d59fd52cd9198b5bcdb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5484a4ea7a1f208b886b58dd55cc55f418930f8a
Message-Id: <175917427631.1690083.8716490915694997397.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 19:31:16 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 16:19:03 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.afs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5484a4ea7a1f208b886b58dd55cc55f418930f8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

