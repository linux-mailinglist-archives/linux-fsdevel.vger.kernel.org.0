Return-Path: <linux-fsdevel+bounces-23718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FD9931BEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 22:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88011C21D61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 20:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E7213D52A;
	Mon, 15 Jul 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INSOe4nC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD74F82486;
	Mon, 15 Jul 2024 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075684; cv=none; b=SgZI4rk7owvOhdHoB6dhe6W0pJvjSSSjj5NkBCcKoxYrD49iJupiiBv2t7mLPJ77jeUOHnO+ul3EtpmkGc9cgO1Tp/Dc6x+a0wgHUW/mtVpYwMt1YTNbeVs8dccMBEO7ZoKUr5p6tWrzNAqOrs2iC+YKi8gPqlMBfitdEsmD6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075684; c=relaxed/simple;
	bh=266jAlA+BthMeYBW53lKpZnumnn5JdsdQrNP5b4lb2E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=codguxbKgNHQvgXWZpTRovFM7s3GUEb5/0iucHTc4u9MrQMt38bOsf/hFIKEXJSnyWv0NODfaerxK3k41GchaYnCW7wBtNVrh/hw7eIHIvsKXKbKItgecTMqaRmUgujHP9KCIa/T59Fwxt9Byfw+RAydH4tT4DNRkgiwaWuM+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INSOe4nC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83907C4AF0B;
	Mon, 15 Jul 2024 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721075683;
	bh=266jAlA+BthMeYBW53lKpZnumnn5JdsdQrNP5b4lb2E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=INSOe4nCQ685IUSlb2sZsgn/18et8XlqYAhKWt/MH9oh/cL3eBcJsvBzT4V5xzrnV
	 0Yd0KE23aicPbtPfF3Ap7ByCJVDDAzvR8o4nls/dkVKT///93Thq5ujPUFSdNpV0mw
	 vdtjNNgRbE2EHjwosLLhCLQ+hv/b6WAQYeQo03+8HEVsOal4QKzjYVlhjAOdGIKJAa
	 Hyi/6vxwpz8U56SxGq6sigWY7+pphLdbg6DH/ZoKCwGbsO7BwncgcpFSHpZY2+dGOu
	 XenVSG8VbgM0+Q8F6RHt71HvlpdStPrhS/i2sT8RqChY1kee9jKBp0TeQHKeE2/NV8
	 EVYUgPhtuS0KQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 619DCC43443;
	Mon, 15 Jul 2024 20:34:43 +0000 (UTC)
Subject: Re: [GIT PULL for v6.11] vfs module descriptions
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240712-vfs-module-400367af1f9a@brauner>
References: <20240712-vfs-module-400367af1f9a@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240712-vfs-module-400367af1f9a@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.module.description
X-PR-Tracked-Commit-Id: 807221c54db6bc696b65106b4ee76286e435944d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d156879ffd6c48428c2f46d5c2b4b80d9c9ee79
Message-Id: <172107568339.4128.4739393463434390.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 20:34:43 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 15:54:15 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.module.description

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d156879ffd6c48428c2f46d5c2b4b80d9c9ee79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

