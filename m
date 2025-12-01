Return-Path: <linux-fsdevel+bounces-70408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B619AC9994E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 00:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA7C74E17E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 23:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184B32882C5;
	Mon,  1 Dec 2025 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2qEJKf4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7245523B61B;
	Mon,  1 Dec 2025 23:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764631550; cv=none; b=GZgOn5hMLW7G0BR4cBKtDeWb95okVLzkup6skxsB5BnyzY6SlWCDmv6wvyAID55X7WPUhRbxcB/9sdM3jRTqcueNeqTOKIKegwioGDNRtAnU4lBnXlKAsBo9f0fuFPCn30svJAaa5Kov8vgxOcJnFRgabJGhqfB717PzKkngDmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764631550; c=relaxed/simple;
	bh=josRyQeVezsd40ZFTMGG9BGCaiOKAnluhT8HWU/aUNM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MJ/UkpAPmwtl8QGNRJmPuEuC95ATon+QEKy44dKwkWgvDMrEhSSoY7zlsCinrHqdSvLnIH5OQTcoSfYXmF9XKKDEOt5/yQn27qaHCEpTT9zxJWfoqlb4Z78o82BCyLKHbpTCdUbcbODsw93Ges7MwyNXk7SkU6tJh+nXv6qdsRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2qEJKf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B5DC4CEF1;
	Mon,  1 Dec 2025 23:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764631550;
	bh=josRyQeVezsd40ZFTMGG9BGCaiOKAnluhT8HWU/aUNM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O2qEJKf4tzofrIskXp9+YfR/fBnXGoxVNzsOvD0ygQflHkmAkFbI1lGAQSBxM97a1
	 tVYRJFNcjsAHWpUAlGTPjPWk/ol2RLsFS8DkdH32mxF5QCR7CNKQWM2BFUPI9PArVV
	 5NINOHmFU+gFe4Bvt2DHp9W0N3uxyWp6/5WgY/oXkGo1PW6If7nXXW06+OivYEDP5x
	 4WtPLsgqMHo7fnavY8jvrCfpXdXWSNtP4bPkOMDyp1tSdK1aXqKQ0HjjeTeVX11XSe
	 YVd/wa2KUizzQzcjFUEGi+cXB+ZlUtu9nUH+M7HGFVASasPTkXb71HHiqVYNgX1Pa2
	 amMfj/TiGThhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B9B0381196B;
	Mon,  1 Dec 2025 23:22:51 +0000 (UTC)
Subject: Re: [GIT PULL 09/17 for v6.19] vfs headers
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128-vfs-headers-v619-d2ce5e771a9d@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-vfs-headers-v619-d2ce5e771a9d@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128-vfs-headers-v619-d2ce5e771a9d@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.fs_header
X-PR-Tracked-Commit-Id: dca3aa666fbd71118905d88bb1c353881002b647
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afdf0fb340948a8c0f581ed1dc42828af89b80b6
Message-Id: <176463136996.2594946.9591814716680106822.pr-tracker-bot@kernel.org>
Date: Mon, 01 Dec 2025 23:22:49 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:48:20 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.fs_header

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afdf0fb340948a8c0f581ed1dc42828af89b80b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

