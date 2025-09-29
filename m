Return-Path: <linux-fsdevel+bounces-63054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9BBBAA78F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 21:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF6A1923FDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 19:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15D22C0274;
	Mon, 29 Sep 2025 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLGYAKuL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4B2BE65C;
	Mon, 29 Sep 2025 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174286; cv=none; b=Uve47HkeIyMz+XpBsCmkYcf2e9bA/bL3gwQv7XFHal22SyaEBR2bpBo/QVgchJHSUyDQAvlrFv2MYyP0XbLpgVZuH3pJVeT0GzfK/wdQRad9wuIGenQ2aukK3J6t5ebbzxXda1ZJjfZ/C5F81k4r2NQDCVKG51cM9LXg9hW9ZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174286; c=relaxed/simple;
	bh=bCDzNdk6LdXTPFtpihg3DgooT4i8EkrsGNZ+sptIpUE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L4pn0ZtsLGEGaz6RHxmUYDfJlw8ggNhl4GjsTrmcwfk6JzbgzE7jqF6oewwE2EBKGC4+DdBlY+2RcYdnZpQiGbiZmKW8DF73Wsi44Kr8WIkeIfm2np0VdRFJuTaJ189wC6wKSixWbMBE+TYULkTLMlrUZ/KV+TIW5N/7X/N6tDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLGYAKuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD97AC4CEF4;
	Mon, 29 Sep 2025 19:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759174285;
	bh=bCDzNdk6LdXTPFtpihg3DgooT4i8EkrsGNZ+sptIpUE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qLGYAKuLEd6Kq6fSbJYPHKEuRuM3mVbmJayK3ztPPs8swHAofNrvNAed3oMftJZLr
	 fXSunsT4sxxHUD9FTyMsT5yGKiZgVF443pABsf0emtqDm+Wyoe4bgNopfZlfcJvTpF
	 Hp5v7V3GFLxx1YRjmQ/nuQj7dVJoXv5tKqZui62Qg3BYV1u9A0K+QW3h1fBpvKE4xH
	 bZZmhpX142CIJZyjS7YlWZd3Sh+xLqIo55Rp/8qZeX5lmRKYKRWLk02a7wD4TBWGQe
	 CjyrIk8EpQaJmEyYu74tucvak1YPVweJ8uNylz7fKIgw7KyNegoAbD5uWoCbx12DhK
	 aMDG4Vdq1Ntbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBBB39D0C1A;
	Mon, 29 Sep 2025 19:31:20 +0000 (UTC)
Subject: Re: [GIT PULL 12/12 for v6.18] async directory preliminaries
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926-vfs-async-920f57c61768@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner> <20250926-vfs-async-920f57c61768@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926-vfs-async-920f57c61768@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.async
X-PR-Tracked-Commit-Id: 4f5ea5aa0dcdd3c7487fbabad5b86b3cd7d2b8c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 449c2b302c8e200558619821ced46cc13cdb9aa6
Message-Id: <175917427930.1690083.16092619679825990753.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 19:31:19 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 16:19:06 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.async

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/449c2b302c8e200558619821ced46cc13cdb9aa6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

