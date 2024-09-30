Return-Path: <linux-fsdevel+bounces-30421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DD498AE1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 22:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E181F214E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 20:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113D6199EB1;
	Mon, 30 Sep 2024 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaS5nJlN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101A47F53;
	Mon, 30 Sep 2024 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727690; cv=none; b=bLYQiKI6Gk6M10H2xmt5YjSpijmh33wuxXFCBawn8+hFb5nnc/Y8By/zhpLzZfzJMA2Gs/UIsdTNfAui4ywtLcyIggAkJIZ5odmekxY+hvDoO2JbYybST0h079jr++Nc2jaPnTj19RJDphl9OjMuvk3QbSFZ/c1abZGZeUB5N28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727690; c=relaxed/simple;
	bh=Xk5z7I/m6VFRpdXKFZprkD/eNvW8TyhSwFki8GQvjCs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nODSs1m93XogQlzpS2t3uRij17m509fY8X3MtrqmIzdjfDPadpx/Lzs71Web/S+yp9eGnTYRehQJwU7Wf+aBzsqdQqIddMvYHHve2mIQhIv0jHUBM0YMNawwsxkuYhaBs3FqskUXFFRDscTHJhjzJIw6+SOUOl/3pVY2rlD3V+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaS5nJlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04875C4CEC7;
	Mon, 30 Sep 2024 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727727690;
	bh=Xk5z7I/m6VFRpdXKFZprkD/eNvW8TyhSwFki8GQvjCs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VaS5nJlNq2tT8+3PvcIoGJKRQvurCKXHA/Tn4eErjDd+U99A3MaRKHeDZQ5f0+oZx
	 Vas75gVR0gCfC0zGp0RzXmAwfUkVv3oz0JCX1l0Ku9JYuFe1kcQiOi7kZ7wbwKQiZE
	 Ux2F7UgF6I2NvLXoEaWizOYv5jPOKL+rcMWmGfy02RgsZn8SrBL/TCl4sByVgwQjh1
	 JeazhQG8TE+AVpo8UKdahMGW1UyekonYJwIameLnkPEH+qS7UhxGA4HMTlKODCoF28
	 QQY7XV97StDk4/Fffz671AVGJmkW1lyts/PveNRg9dEYdj9CWC8PIbK3wyqDm2wy6k
	 Tp/2j0TSnIt1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E2B3804CB9;
	Mon, 30 Sep 2024 20:21:34 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240930-vfs-fixes-cfedf8d8fa81@brauner>
References: <20240930-vfs-fixes-cfedf8d8fa81@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240930-vfs-fixes-cfedf8d8fa81@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12-rc2.fixes
X-PR-Tracked-Commit-Id: f801850bc263d7fa0a4e6d9a36cddf4966c79c14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5f24c795513ff098dc8e350e5733aec8796fbf8
Message-Id: <172772769282.3918229.5635880436127776991.pr-tracker-bot@kernel.org>
Date: Mon, 30 Sep 2024 20:21:32 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 30 Sep 2024 15:46:29 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12-rc2.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5f24c795513ff098dc8e350e5733aec8796fbf8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

