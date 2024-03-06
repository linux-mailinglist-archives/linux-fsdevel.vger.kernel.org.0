Return-Path: <linux-fsdevel+bounces-13774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1587873C59
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 17:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5CE287F79
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 16:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387AC13BAE3;
	Wed,  6 Mar 2024 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ftq+5Rk+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906FD13BAC5;
	Wed,  6 Mar 2024 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742812; cv=none; b=d87EoYHYD+FmWZ0e1fpPahwD+uuI7KWwc25F7hREPJajO6wRuBD4o/Rstk9puk3oYW60a1YC5BZREgD/GzGZvB+3oFPLjRANo8O35vjdJF4LTBMv8HpbAtJNBJrhSBTLrH3sECXqQHGaTXm5LAwAmQ9EJQLI2yoM8BFQf8xb94E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742812; c=relaxed/simple;
	bh=1gd18fwcmgBKnnQEFVGD+eJIv5wxOfLRH9LFWesFziQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=clP0gAqby54bfokZFuJ9LTi2fbOAqNdrM/W7Z0exDuEzw/FLdf8TbwHDxql3qu9u2AkzA9+5SP5Wyk5YPOuQnvNpVnuohjryu1ktqFI9+LiKAf5O5eBByVeyrL+cKgWbeqwftZ/81gfa9LT0FB/OLN3J1WngwOHG79CLgZmi4f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ftq+5Rk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 193B5C43394;
	Wed,  6 Mar 2024 16:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709742811;
	bh=1gd18fwcmgBKnnQEFVGD+eJIv5wxOfLRH9LFWesFziQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ftq+5Rk+30yktz9aAb+e8YIvTx60ER+InO4xOBbJkRWIVqVSsSqx3siV8C8q4S6i8
	 tuT/jEAB46rHSjxfaOCYRw8uiSiZqFTk7dw5QgmGmY+poSQwr6dXuuIIteEb+7a5NV
	 wGoqavSGL0+clZIiBNh2aXY3y/3pUQET1U4x+anI8pvW7awq3vxqsT9uUgjHcdOwzB
	 KnDzY+hj+zhAezbNOVZfDfY/HjvZprZKX6mriskbOMBJr2NYPWXu23PufbQf2f1ph6
	 HhNpIExEczdZ9QW1eMgo5xZD+/hInMiMRHkabGzPry0DgBW74wRnpwRjl12phjohGd
	 ZMFmBSkDuEqgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E982BC3274B;
	Wed,  6 Mar 2024 16:33:30 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240306-vfs-fixes-e08261f0e45a@brauner>
References: <20240306-vfs-fixes-e08261f0e45a@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240306-vfs-fixes-e08261f0e45a@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-release.fixes
X-PR-Tracked-Commit-Id: a50026bdb867c8caf9d29e18f9fe9e1390312619
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67be068d31d423b857ffd8c34dbcc093f8dfff76
Message-Id: <170974281095.18944.2125698711166467749.pr-tracker-bot@kernel.org>
Date: Wed, 06 Mar 2024 16:33:30 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  6 Mar 2024 16:45:13 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-release.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67be068d31d423b857ffd8c34dbcc093f8dfff76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

