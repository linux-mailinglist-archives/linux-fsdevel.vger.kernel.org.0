Return-Path: <linux-fsdevel+bounces-56197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61779B144D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11E71AA0EA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ABB2798E5;
	Mon, 28 Jul 2025 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYc+p1py"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07DB277800;
	Mon, 28 Jul 2025 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746029; cv=none; b=tqjJ9x3fIdMNXkAN0XsvWZxjbkU4HO1gKj88iLIkPsCiuwTtgsmbk/tDQ/Rou/LTDkJWv3EGwnqJe6uB7nrgD6FYvg7/2dO5NgcXGRI1jjgQGZugs6T+6tvm+Cbem4OhYloMujUz8IV2NJMRwXQyk+ZZEw6fefeJP73pxab+fho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746029; c=relaxed/simple;
	bh=oltZebsRgEqlqmONoC8NjgM3Ss1IciQg2FT6mZaMXPc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=igSSYrz4VPruhnlpVXp9ElsN/ZQpB/l3F3ODPEXWhgfzNDpOtIiYWDF95E7zy/gphmkd1UDfJUUDrSu0KHDeoPR5Hf0ev+vUOvOQCoyQNxofOArr+3t70YTeTC5GJBwdNdvHlKCgYFutPDcBFTT8xMHwXmJgPZiumAxcygktaTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYc+p1py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D24C4CEF8;
	Mon, 28 Jul 2025 23:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746029;
	bh=oltZebsRgEqlqmONoC8NjgM3Ss1IciQg2FT6mZaMXPc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nYc+p1pyFKRgvU1azoJrC2d4VQEV0uPa/B25Cxt7gsWccxifkDFgXhEBhsgUqnQW9
	 kJY7Uq4/6QmIRdXjqOUgw60/xqSKGbJTkS/EgA9I6vHoD9NWp+JK1KhTRc3t5MD4ad
	 WGb+byzfUBXyfVAxvQpqp0EGreJWJ8p3Z5mRVdb7smOETv+kbFEqixP3UzfqVnD4Fa
	 oBjRG1j9fwhaiEIhOxi9RF655b+STi9pVCcKNCQykgwMNIEhysARWF2Luoeyb9L58y
	 ZZq93v3xlcj6C2Zys7A+affOWsstmLJgezApQhC9c6SjY7cdKSihm2eWmxfW5yiFms
	 I3MMmoKMR+t9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 73724383BF60;
	Mon, 28 Jul 2025 23:40:47 +0000 (UTC)
Subject: Re: [GIT PULL 06/14 for v6.17] vfs fallocate
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725-vfs-fallocate-91b9067277e8@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-fallocate-91b9067277e8@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725-vfs-fallocate-91b9067277e8@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.fallocate
X-PR-Tracked-Commit-Id: 4f984fe7b4d9aea332c7ff59827a4e168f0e4e1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 278c7d9b5e0ca73a75e5151c22fb05c91cb4495f
Message-Id: <175374604637.885311.8423396207438407920.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:46 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 13:27:17 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.fallocate

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/278c7d9b5e0ca73a75e5151c22fb05c91cb4495f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

