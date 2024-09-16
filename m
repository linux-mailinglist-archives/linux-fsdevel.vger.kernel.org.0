Return-Path: <linux-fsdevel+bounces-29440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EDB979C13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 09:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13EDB233C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 07:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3848013D613;
	Mon, 16 Sep 2024 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqfb9YEj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09713C8E8;
	Mon, 16 Sep 2024 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472076; cv=none; b=kOhFh17iz/RsbjE/MmHtGuj+ObJYNv1j9XQxmeWKrWEnhfz0SsX7hBSri8cVgLbLj/S6v/KPrV0Ui8q7nFBTIb+Xzz805ioptipJMifj1GG6CAR7TkZ+AKgRpoRhief8aduMnl+ZtnI7w9ECVUzn6Mo9WJNcDSrbGcjwBm3av1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472076; c=relaxed/simple;
	bh=4QoPQxYSi3P0pO5utQ2IOkafTS8scgTmUgBqu2puZ6g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mMy5bLVcm1gXXr0kOtC5HCy81RSqDODUNRVk4zHJXRWTr5llpNjJHPoBlTG9aroqNW0PhUWyD2KnLDbsmErw7pd9z+uPvjJsCeUCfYAPNmVlRuDFwU2J8NGnjoYWae2yHSr2BiuWHA87QmhX/VjMSbgjI5JnDbFRQL+etIoDcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqfb9YEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D460C4CEC4;
	Mon, 16 Sep 2024 07:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726472076;
	bh=4QoPQxYSi3P0pO5utQ2IOkafTS8scgTmUgBqu2puZ6g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nqfb9YEjpwWvvFMkw0Sc+4R1i9bQGiI/RUk9b07UHMIJL8LX20SGCQ/zKYCkpq6hm
	 hQAE2D9HvgQzrZeJcbdi/DC6RJ/PLEZDjUfB2C1HOfnKnbSb4RQelm7GuzObVLrDEK
	 NUOzH50o21intA1PQorcviRUMDWwKX7TEoan8Bp3g0AcRi8wZ2/znNJoKNvuXYZBuX
	 /CbcuR0gZpLADfd49AAKtsvYnemZG5oAUzbldnCoKRkr2r8UxW3eTLTa1RZaL6clyu
	 WqGGD4zcTFvKUaa1++xjmnQNdkvQp469kqKbmsu1PugxW7MKvHFQkNrVOG67jZtEwS
	 tc0ZAdLaprEIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341363809A80;
	Mon, 16 Sep 2024 07:34:39 +0000 (UTC)
Subject: Re: [GIT PULL] vfs misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240913-vfs-misc-348ac639e66e@brauner>
References: <20240913-vfs-misc-348ac639e66e@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240913-vfs-misc-348ac639e66e@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.misc
X-PR-Tracked-Commit-Id: 2077006d4725c82c6e9612cec3a6c140921b067f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f72c31f45a575d156cfe964099b4cfcc02e03eb
Message-Id: <172647207771.3286942.5097647665281256729.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 07:34:37 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Sep 2024 16:41:28 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f72c31f45a575d156cfe964099b4cfcc02e03eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

