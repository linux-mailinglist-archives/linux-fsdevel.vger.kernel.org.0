Return-Path: <linux-fsdevel+bounces-29894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84E497F118
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 21:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98991C21A08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 19:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50A61A0716;
	Mon, 23 Sep 2024 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRmOjODu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319F1A08A3
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118405; cv=none; b=NE6DysnZgdg2cjU7GiSx67J4+cGxEgeSq4YXVpMgXJ3lxBu9+wY0GRXZpiP4nEQLK10ehdBLgUimdBXgahueLDfHyHnEC7m4g57E77rp69wdj8q5e/A6oHm5oNohfEkqErImNAfFteA4EeJl4jJhEBLtnnyypxyoX3RBYIJh4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118405; c=relaxed/simple;
	bh=mdjrqHyRpQh+Zjc2PTt+kkGTlS22Wbit7w6zOOx8GyA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g1bsIZwhb4vQIhCuaOwStfd14erk3lio+D6pMdb5BZ88zUDUBLF9NXiaR+yHPr7qTWGgooc7MZlVdCCLvIpr7Ko8Jz99TOBFHWZAFsl8j2xt++yy3kZ3TD0bnm/Q9yp9xtVe5G/4h6S+N900dILkrxsuoXtr6izHEeRc7x/SOUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRmOjODu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A57C4CEC4;
	Mon, 23 Sep 2024 19:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727118404;
	bh=mdjrqHyRpQh+Zjc2PTt+kkGTlS22Wbit7w6zOOx8GyA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GRmOjODuxkC59aDhIEbIJ4HwN84pOb/XIIYmcqw5FjxnxqFu1kb4X9uIPr1vZchU2
	 rkwBw0XisfCe2E/AnjhR+UK+oSqXiQU60vYCbCD0RS7iJoDlL0Ke4aw5bbWmoiWT/y
	 Mne00ukGK7kRAx+A7YOlRIR0F3ay8qBoyEnZX06uj80zJZr/YGuqRw4YyTqRNtILGJ
	 UCKY3FCLjggk+gKubQVEi0F5mkGN0Q+EMBtWyHXygX9hwJrpw8ANBC6bPQoku5KvtI
	 Sk+q88KYZOpGJ1EmWWNqxDIEJaSRloifp77/CQcZ5ucFx5WBeB8hbSWrru+Y6OIFIB
	 Y2/bNJb4DKqiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA23809A8F;
	Mon, 23 Sep 2024 19:06:48 +0000 (UTC)
Subject: Re: [GIT PULL] Quota and isofs cleanups for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240923102617.fblre3yqve5kqwu6@quack3>
References: <20240923102617.fblre3yqve5kqwu6@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240923102617.fblre3yqve5kqwu6@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.12-rc1
X-PR-Tracked-Commit-Id: 116249b12939a8ec13eb50f36b6fffd1c719a9ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0359e4ca0f26aaf3118124dfb562e3b3dca1c06
Message-Id: <172711840692.3454481.3989434350128457540.pr-tracker-bot@kernel.org>
Date: Mon, 23 Sep 2024 19:06:46 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Sep 2024 12:26:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0359e4ca0f26aaf3118124dfb562e3b3dca1c06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

