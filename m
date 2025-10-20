Return-Path: <linux-fsdevel+bounces-64735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A773EBF3501
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723983AEEFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 20:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1860C2D323F;
	Mon, 20 Oct 2025 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6gZYQJ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB19238C2F
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990416; cv=none; b=e4+ZZKz6CXHqWUgrqSc5Wjhu1WyKE+CEaBZXSkiGscjgaGGFX5w79v15M8W+HG1hKIHbwe6jN0ijB7fNXfDbqLpsg2/sfW/DcGjBj3cMF3ArdlkfXPRo8QjAu2era7Ej9ndVSbvvuo1vmJiGGboCTdbyA/jTSfV0u2kzWvi+bKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990416; c=relaxed/simple;
	bh=tK98uVwahLHhUFvk66NChgalWQUt9FSyHJG9ZNJOSo0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Qpa+ScROBjycrvD8W7DIKu1LujzC5xHoD5YQb/py9jO+sMYcdGBDQZLUuaDNJlbKPpVo1QZjJJHrTC481oXk45+Yd3VBRs6j4KQjDFWgjH7QizFRLHUAhNfHZ3McfWw5g1zQ/oQaUm3uQyFe7wdwBC9GnuwbH/iU0AjK0uA52wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6gZYQJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49284C113D0;
	Mon, 20 Oct 2025 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760990416;
	bh=tK98uVwahLHhUFvk66NChgalWQUt9FSyHJG9ZNJOSo0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=M6gZYQJ2ieCKMvikp17qu2fAf0Xkkfd87SyXFgMJzKjEGLO/sOAeZRv2+e5cy4hR0
	 LSmwbupVK5vHOmwozbj2qOFk19ZRyHnEj96+HexRzFWyZMRCM7T0MRsvHpPzjVemqX
	 wZjc1yBU5WA13YokJ2E6vTYScoJez8gSooSbllatvGyKaoC36aNgOfIN5OzzmNZ1i/
	 WMHB5MqlBVMB663vLU+5a+bXpf6Ef8FleBRUKxAjdeX7pTtzfhLdawth0PGqEjH9Uf
	 UzD6ug+KfJiSkldkuNCBsBtoeWXkkrx7tFC6wpk31mqMxVc3ywx0y1q+uePuk5sdAY
	 EvdWN8G1R8WRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E4B3A4101D;
	Mon, 20 Oct 2025 19:59:59 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify fixes for 6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <uxjyfajfg7zfe43r7lryobk4c7jfevqmlwobbqavmbs5mwyph5@pbftyugt3k6m>
References: <uxjyfajfg7zfe43r7lryobk4c7jfevqmlwobbqavmbs5mwyph5@pbftyugt3k6m>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <uxjyfajfg7zfe43r7lryobk4c7jfevqmlwobbqavmbs5mwyph5@pbftyugt3k6m>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.18-rc3
X-PR-Tracked-Commit-Id: a7c4bb43bfdc2b9f06ee9d036028ed13a83df42a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 380cb5d3533cddd93050d72d65f7b1fc997823f7
Message-Id: <176099039793.389793.11976039906836245559.pr-tracker-bot@kernel.org>
Date: Mon, 20 Oct 2025 19:59:57 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Oct 2025 11:16:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/380cb5d3533cddd93050d72d65f7b1fc997823f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

