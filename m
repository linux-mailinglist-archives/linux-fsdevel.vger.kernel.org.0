Return-Path: <linux-fsdevel+bounces-63046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EAEBAA762
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 21:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCE142058B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 19:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95A126E712;
	Mon, 29 Sep 2025 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MII53B6h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B63F26B759;
	Mon, 29 Sep 2025 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174274; cv=none; b=DBzv8CMO0WF9w3iWnl6BCvvjJmF8lK026P0qxXuiNh6ncTbR6Osn3o3ZKNI53nPWV2/e5zOw50urXJPdBsTnreernLUH6LKYW1UrWjsjJtVGDQtkXQxIDKd8fzlQ5EWibiyWwcalCY5UuTUwDrSuu0jUhG/V7Jgbx8+f8jSvvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174274; c=relaxed/simple;
	bh=hVAy+m7esOUANiV7lnjrNi307G2ZqDU/pchSWXjFNNo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hx1y+IL5c6Oume3iHnZuQNog3CNVpA+qD0wXeoobbwejBEB439ECiy0YUBbJiSUBsmTT+qIAIH+0dZVMhb0LBYMA6bIBwTwKJYBbSiob2KAdecABgTBdZv2rBYPsXpueHRVzDCxWtNvIvFcWI+LW2JVk6aCbyWEfjPq5wZH5cqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MII53B6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AA7C4AF0C;
	Mon, 29 Sep 2025 19:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759174273;
	bh=hVAy+m7esOUANiV7lnjrNi307G2ZqDU/pchSWXjFNNo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MII53B6hAFrwkKBaQ7NLcN/XeZnDSjDbg3uuBI/+aL9QP40dCc7EOnNnmdZLBtgUU
	 elIO2tb9w/D+cmYeVv4P6bFIVhJyT43Rzr15StqzmVPgjjF4Kmof2oul1fY/3pPnC4
	 LnlZxw+3nY0r4hxNYV2WblWO3dZZtiuNsDLLFBf3LLq+es6Fw87AvdmABG19CICf69
	 VByhh+Z1eeVy3j/fIfLk+c6YH5dLX2/8sefv8EfhXWUwimlszYaNgMSf0XT8ktgg3I
	 3vFF/KSmhQu8ydTS+ret1uHOvytgPyzubFV0OpH8FbQkA79ElvvUcEmbEI7+hSDEyF
	 7i4N0nMtbp96A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE19539D0C1A;
	Mon, 29 Sep 2025 19:31:08 +0000 (UTC)
Subject: Re: [GIT PULL 03/12 for v6.18] inode
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926-vfs-inode-be4062725b4f@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner> <20250926-vfs-inode-be4062725b4f@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926-vfs-inode-be4062725b4f@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.inode
X-PR-Tracked-Commit-Id: c3c616c53dbabddf32a0485bd133d8d3b9f6656a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56e7b310717697109998966cb3c4d3e490d09200
Message-Id: <175917426730.1690083.603169591913373796.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 19:31:07 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 16:18:57 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.inode

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56e7b310717697109998966cb3c4d3e490d09200

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

