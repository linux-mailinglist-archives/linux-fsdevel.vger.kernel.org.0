Return-Path: <linux-fsdevel+bounces-63048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2983BAA76E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 21:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FE8420631
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 19:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC33527E05B;
	Mon, 29 Sep 2025 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hH02ZTDL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A9227A107;
	Mon, 29 Sep 2025 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174277; cv=none; b=BebS3OwicEWI9KbIHHU/bbwdtwGdVXNVZqROuSPGtbTNwBqHGehjfnOKNGe0QAKyaKDH5ixlKRgKx6AmG/4omrLYxlZDXlxGMOz5bN0IU/n5IEBAHE3fkmScgZtt58U3p1FNY+4imUJP89PoZpbd1fXjjV1g8D24zthc6mp5WmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174277; c=relaxed/simple;
	bh=jkMRjp3ROcfNQkkr0WxYbNik3/AdXUPJ1jUkv1zWdxs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tV8Q+wPRskL5CiwRt2zprS2RVPyCm8Phd7rEXszwU9tUV0U11HIBLVNKXGDIcD8w2kkcjEYjrS2po+VMq+w66RwhD54m/1ZcUWCqGcuhvJTSbb8i6G/3R6P7WJpc8tzFiATMDuc7vejBJeDaCbq+9+QYUsTGeNn1+iNAQWVw6PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hH02ZTDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCCEC4CEF5;
	Mon, 29 Sep 2025 19:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759174276;
	bh=jkMRjp3ROcfNQkkr0WxYbNik3/AdXUPJ1jUkv1zWdxs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hH02ZTDLdupMRCzjuhxMq/PAsUqKg8Q4Bg1LiXdxUJJ+MtWNnt0mei8i4b6cGfYzU
	 72wYkOJtLjYIQBZaaGdAqQNR0KX/VePq8zBuyUsdCcvVAOUDSXXP7i3KOr3RLF9Rsk
	 JfS98bFG/aZ/ux4nVd/mDN+MbeZY/i6MAucT63p5RWWxAxoN6lote/QzYjpgklMgLc
	 VEs+yZQ3beank+fJDWqTj+FG2VwuHW6Qsmt499ktJBZS8vXtUrySTDr3DC9p1B5kxZ
	 1g46WuaXE9yttlhypDhaiWF/R9uSMcEhDmjP5ZfOdBvkmcYQ0qlb+l0e8iy8lz8kpY
	 Y6v+X73Lov8Ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC8039D0C1A;
	Mon, 29 Sep 2025 19:31:11 +0000 (UTC)
Subject: Re: [GIT PULL 05/12 for v6.18] pidfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926-vfs-pidfs-3e8a52b6f08b@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner> <20250926-vfs-pidfs-3e8a52b6f08b@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926-vfs-pidfs-3e8a52b6f08b@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.pidfs
X-PR-Tracked-Commit-Id: da664c6db895f70c2be8c3dd371c273b6f8b920f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e571372101522fa91735dac6d30a160b2abe600c
Message-Id: <175917427030.1690083.11907131433251474744.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 19:31:10 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 16:18:59 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.pidfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e571372101522fa91735dac6d30a160b2abe600c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

