Return-Path: <linux-fsdevel+bounces-19836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507888CA34C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 22:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE60282857
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 20:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3832139CEB;
	Mon, 20 May 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFUlTl03"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB3F139588
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237029; cv=none; b=AJVeqmaAK8KcSmrqG/ch7hC/L0inBXmsXXDrKpciPt6RdIqylHe2z1+t1dfnRIZsNYKTcHFHU1lttxrN1oRjBIwY9NUCjfgNx3gw1kI03tm9udreG3CDB/+laDbKazhSDYO+uRvnB4Rb7w2bmyQHMq7eam9qZQ7qsD4GbAbtTPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237029; c=relaxed/simple;
	bh=Wo94phhQ8oD32my8gZyP4UM3k/YQ5q+tmimoiWMv0mc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JyPJaSXfTtA8QhfXuvwu6e7cejd4VwJ5lscz1d+Inx/G10/6FTC4bPZ2sfjvm++j4Q8dvmTooSFxtHI/xO/03WsiDe6jihyqftzpRtnF0EG9ftjniNXegdIWm6Itn+aXMUf1Ln8B2//fvlYiID4CYuvgg5IthCE/KngHs/8yGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFUlTl03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3543CC2BD10;
	Mon, 20 May 2024 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716237029;
	bh=Wo94phhQ8oD32my8gZyP4UM3k/YQ5q+tmimoiWMv0mc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YFUlTl03fs//txMQaZ1/SL8NXpe44E8xdrksEKAO9ZJ0uN7wEEOP3o3+KeTYprcI8
	 ZfzplrUmK0+Z4rQKo+Pp7E/3JZa5PdSkZnub6GPAUBeZaok7D5/l6M17wlBYrC+U6W
	 bNTEqqdt39J+VhnTFsAc6gwC6Jq2k9Zpdjp13/tNXby4VBGl6eLcOnVCjzahgyANAC
	 edujGRKbWH0WLFC56iJXjG2YB+LQ+Qjrt5W2J9RogvvOjXBC+vvog1aIarybOnYo0L
	 339IgLpKqklEW2I9CTi7sOPCXn47elir/9dqOJcoj4LLi+j05wx5RxY7dHNuDJG80F
	 v/qo5kh5QQ2mA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29194C54BB0;
	Mon, 20 May 2024 20:30:29 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify changes for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240520112239.pz35myprqju2gzo6@quack3>
References: <20240520112239.pz35myprqju2gzo6@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240520112239.pz35myprqju2gzo6@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.10-rc1
X-PR-Tracked-Commit-Id: 795bb82d12a16a4cee42845b0e4c7e3276574e5d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5af9d1cf3906171de28f1c395264f29088bdd267
Message-Id: <171623702916.8142.4272229981996691867.pr-tracker-bot@kernel.org>
Date: Mon, 20 May 2024 20:30:29 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 May 2024 13:22:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5af9d1cf3906171de28f1c395264f29088bdd267

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

