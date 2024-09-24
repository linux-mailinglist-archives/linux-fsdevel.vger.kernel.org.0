Return-Path: <linux-fsdevel+bounces-29990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9D0984B47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 20:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671F91F23E37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 18:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C9C1AC8BA;
	Tue, 24 Sep 2024 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpKRFrr8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AD51AC880;
	Tue, 24 Sep 2024 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203541; cv=none; b=WG5gYKKxDw3pw+aSsMXZ9fq43OUxMbHz00W2/ewJNzXQPbGGzlcOvywGNjZAqsoi7W9lJtuJjZzvI8QzPCWj4IC92mz2YIaCX8ZBrPCB/abSnu+LZxwzIMAVEkazVYQ+0/uy6olwNssifsdGpNbTJMhVZ74QnfEIwz7f5YUDeo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203541; c=relaxed/simple;
	bh=rtsbJ6T+fdsLjDm82XFWIZrdtMbc17UmH1v+ZojEEUs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gkWqIBoWozs2taHL8bgCtUVDtJ+ANcgyiP1sIdd94mFMIY5GujY/1YqkXVR+AuxhroCS5iXi+c365DR/lw0ho2aioZUNxVOrlCO0vP0I+sBAiYqR45y/0G10Ai57HAgB5hayEgKqRZAZ62j0m+Y5CHhiwk6EAGc520m1/vs54v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpKRFrr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8B9C4CEC4;
	Tue, 24 Sep 2024 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727203540;
	bh=rtsbJ6T+fdsLjDm82XFWIZrdtMbc17UmH1v+ZojEEUs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gpKRFrr8s8J0z7CA06pZ16t9sEGE7Hvll3frfbyrXcN56nm8QrNw/+vQpesVaD7tR
	 GVsaoQpl3OBtYnZLeco/xiJMW8cyVLbesu5GKhTgn4UU8AHpaGVepY9c3Y3i87F3lx
	 mPM2xkF3TUr+XoNEGzgJcsPydVC15mjE9FKcNsOAfqA3+OLgERfUmaFy83FOb+SZ8l
	 G5cct3VnTK1YxvofvIiSaiphD1uyh0qyUT9GG9hkfBtaV4HUmeSZDWGCgjdqu4L5UA
	 2wXBmMbYv585Bq0ZOyWUQgkjzyjJNdmfKIBRR+j4krlCxXkjfQb3mOyvurEszWPKte
	 EY8hHronDLdiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711D23806656;
	Tue, 24 Sep 2024 18:45:44 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240923140501.b2i7xggemwvmqcs7@joelS2.panther.com>
References: <CGME20240923141827eucas1p1b9c0dbe3baea82475f7ccd26a0169996@eucas1p1.samsung.com> <20240923140501.b2i7xggemwvmqcs7@joelS2.panther.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240923140501.b2i7xggemwvmqcs7@joelS2.panther.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-6.12-rc1
X-PR-Tracked-Commit-Id: 732b47db1d6c26985faca1ae5820bcfa10f6335d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 172d513936c707e991c3eca1b79cd8a153171862
Message-Id: <172720354295.4158342.212220203694502963.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 18:45:42 +0000
To: Joel Granados <j.granados@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thomas =?utf-8?B?V2Vp77+9c2NodWg=?= <linux@weissschuh.net>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Sep 2024 16:05:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/172d513936c707e991c3eca1b79cd8a153171862

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

