Return-Path: <linux-fsdevel+bounces-14365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784F287B3C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 22:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B2D2889E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 21:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B23E5914B;
	Wed, 13 Mar 2024 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwEb6sLR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AAF58106
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366448; cv=none; b=Tp/NmGkK/F4QEB4lIb/N1PMA7SeZOknWKEn4B4Kwes2dVwbpvkljVZE9DK78RUhwW/U6b+1gnO2OQPXzCbZhYFMdcu6+O44DMaxqnKDotAVLpqgmwnD3olCrz8GUJmDgb3T1diizpYMo0GbrlwcYE/AOS37kqf4E/cUk3e0cT4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366448; c=relaxed/simple;
	bh=JAaPRzIWpPT0V0ZIliJe7MgdVBX9HUd8NWjR8Ts5vYY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RBEKK4u2+X//ywAmjBzOy3LvVe5XSPTaL56ZjPASttW7T8ibG5RJZzjwFBcCAp6Q0KwhRLccq/TUcqZ+pYeewuqArBxB5751JMYHRte6thmCuK2sUWJ1TgcYbUfw2XrKEqQkJZsyhtoP4d/lRbSxAfNzMokd2FiVEcaxcpHbDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwEb6sLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 460A4C43143;
	Wed, 13 Mar 2024 21:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710366448;
	bh=JAaPRzIWpPT0V0ZIliJe7MgdVBX9HUd8NWjR8Ts5vYY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YwEb6sLRIVEOIhpn/xc4slI/KP2XhRN4Dzf2iwnU9c3YGp7d7cEMHu7vfJ1sGGFXE
	 kcGLrKVtGHs1Z1i7ThIaFHm4lB2zx5JcyN6DhFgJrDJEqsogin1kf0+97OfcQ5Oph0
	 nMSV2m+JU8EfMNb8nnCMzwDx6DNdC8nYdakbx7kB8mk7bUvbzN+J+CWGJ1N+ZX4LcO
	 2kbjNow7hJBkfBTlCHmx50KGStJ+C7yukhf8nqDJq3wmYPaMY6tYRBIXwlO/QeVnLc
	 hzrrc7u6iYtafuy6CbtTbxxM0aImE/uuXinCfvwWo2iKVzdV9ZSH2mXC19zhrvzhZF
	 GylX0ADsyuCBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 329ECD95054;
	Wed, 13 Mar 2024 21:47:28 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify changes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240313174459.vrjqn4g35dxdknfv@quack3>
References: <20240313174459.vrjqn4g35dxdknfv@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240313174459.vrjqn4g35dxdknfv@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.9-rc1
X-PR-Tracked-Commit-Id: 0045fb1bab4eaa8f415c2fd76020bf7b2a3be47a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1715f710e787493f3631d5890c86c9bdb30a36d8
Message-Id: <171036644820.31875.10467647925157764727.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 21:47:28 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 18:44:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1715f710e787493f3631d5890c86c9bdb30a36d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

