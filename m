Return-Path: <linux-fsdevel+bounces-14157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CD6878764
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 19:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BFAD1C2100C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 18:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3BA56B62;
	Mon, 11 Mar 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLzYXyuK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDF954F88;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182029; cv=none; b=nSj5czFv6xAVI66vK9rDdXyUJsitthxqXdB8/MrcUQ390qe/9JsfiPRaBq8UMgt2J62QrzLyPdCPW6nXB0KBdIETuuPBHKTQ8PyOaRGMHcpRy5u59zmeijakzyDjlYnmd7jyaiF3GRv5gaViBqoNIdBcVEgCWla1WZ7IvXXWDBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182029; c=relaxed/simple;
	bh=4tKacRWYzK/RAv7lAji410+hbcyTj1w0BihBQG6BRDQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bWEH0VtIDqZOgvv5WsE9iwZXh40PBVz4mhujf8VLJi7gdLV9mVl6eB99rYakNHaMuDJhCB5m4AQJmWwnQHjHc1t7cUFgV4ZBLS2fPycpYUCx8KJ1ERvvJUSfGkbhMXdsKiXKZVA0yHria5Jj4637UwmiDHwmx8BCzKmj3vVyS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLzYXyuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB727C3277C;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182028;
	bh=4tKacRWYzK/RAv7lAji410+hbcyTj1w0BihBQG6BRDQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HLzYXyuKNGDOkAyvnxaixsf1lvLExKsscZI1uuHJA2AxDvNGFHcC/jCEDfavfyQ4E
	 oH9HVORPLyrDEBIZolp0MZx+5Oh+ShSgGmjGmeccuKRf+xq9kugn65clUIUbnkn/z1
	 ZsWiX8lcD4tSCpFtFxtLTftwPyt+2w0gk6ACr3LfBTgkZ5mHkqgOAIPqAmxmgltR55
	 7KaSlftwFNdF/1jd+hGEnG3WrRwDcWc0m3Rmpx+F3DWm2kT3ABHX4TZ1BhkSembdHA
	 7Zu1zohv02a5hISvGi3Nw69SBFQRoAqxOqO0Yt1laMjpa6xMLs9VFK1lxbtIyo6Kbp
	 Cah/11sQp8Mew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AAD35D95055;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Subject: Re: [GIT PULL] vfs super
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240308-vfs-super-ebcd3585c240@brauner>
References: <20240308-vfs-super-ebcd3585c240@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240308-vfs-super-ebcd3585c240@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.super
X-PR-Tracked-Commit-Id: 40ebc18b991bdb867bc693a4ac1b5d7db44838f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 910202f00a435c56cf000bc6d45ecaabac4dd598
Message-Id: <171018202869.4685.12895240962177595511.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 18:33:48 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  8 Mar 2024 11:17:38 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.super

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/910202f00a435c56cf000bc6d45ecaabac4dd598

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

