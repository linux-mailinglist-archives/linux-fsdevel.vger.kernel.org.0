Return-Path: <linux-fsdevel+bounces-63408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D78EBB832F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 23:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0599E1B208E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 21:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB1A289374;
	Fri,  3 Oct 2025 21:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7YExdio"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3F287259
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 21:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527081; cv=none; b=aIYEN2u/jZFYBDVnmRoaWWPqQe7vUM2Ye1wXdnlCL/fYultAxt8hQQGN/Pq65t62WZ2J6+Oxr1Lnvhno2fzpctoa8vZdfdYh4LHrXRBjcpp462Jcxy9AOZiDrOt7yg+d9N1jC95tXf25j8QfqBIxY9ygOqbP+Ws5YSZdQGH+53Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527081; c=relaxed/simple;
	bh=ukw0xVpTbOaT1otHKve13v091YXvgOiLEV1WUjmF6cE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EyUbVu90d9aXX+NDVC+a/Jqgd20MSx5SjzSibz+vkXcNOJkZ6lquSEPuQ+JQYF6KojPJIWJjpWLxD0E72VSMgL0zy3QZuCumKwDoQNZaEK1iBMb6nX1skriVWYE5EqV4A/aw9KEoMmB+Ufkr5jJG5XlRwt/43B1K6f6H9txsczc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7YExdio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1457C4CEF5;
	Fri,  3 Oct 2025 21:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759527080;
	bh=ukw0xVpTbOaT1otHKve13v091YXvgOiLEV1WUjmF6cE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=H7YExdioea6uFfhvAv1CfKddK2NwqPlFUbR2bFLglr2nqqX5l1XQXP95Mswe8RTxc
	 +5jCDAZs0wQ/TOVCUTSqzXc7YS1A/749To6NseDvXmeALgYOgq1S11lRrr5xIxd8u6
	 JwQu57bprEOkGbljJz7RubatX7UXJAIzlsOQ5OZjtpMmegMBne+BiCGVptT5wRlm6B
	 E7QO53j3w+lTtiFgLjwFbq/TCL+WedQigI+E2n+WzV0PnnmFKqtGe1FsONO4JJ0gBW
	 iaKdwHd4hjM/J8vnnib4KN1vCD4g25NuFIBmKE+oiMahcVkAYpEpdxeecdO1SSvEEE
	 Mou0iLiXqyfLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7130839D0C1A;
	Fri,  3 Oct 2025 21:31:13 +0000 (UTC)
Subject: Re: [GIT PULL] udf and quota fixes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <6lzkazta75sjxv2wrxqmskzqzm36zxgbo7w7yjqqlaejbyjegn@tdxtdkkiqzks>
References: <6lzkazta75sjxv2wrxqmskzqzm36zxgbo7w7yjqqlaejbyjegn@tdxtdkkiqzks>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6lzkazta75sjxv2wrxqmskzqzm36zxgbo7w7yjqqlaejbyjegn@tdxtdkkiqzks>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.18-rc1
X-PR-Tracked-Commit-Id: 3bd5e45c2ce30e239d596becd5db720f7eb83c99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4eb9356480fa47618e597a43284c52ac6023f28
Message-Id: <175952707204.82231.3413697764903818061.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 21:31:12 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 1 Oct 2025 13:29:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4eb9356480fa47618e597a43284c52ac6023f28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

