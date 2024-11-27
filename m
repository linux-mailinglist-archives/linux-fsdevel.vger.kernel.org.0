Return-Path: <linux-fsdevel+bounces-36024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F849DAB92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 17:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF012815E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 16:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F5A200B84;
	Wed, 27 Nov 2024 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgNawlaM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA92581;
	Wed, 27 Nov 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724135; cv=none; b=UEccQEh/ObafrKPuOeBVcEh1ttWoJBCkR/gkWY5NTwSHKhCCv5KUR+XoPGwrMRq9QDV9A0Ke5M9ZdoAy1TpEnpRoU3g1dZndoqcERBgDXC9kLsk3qB1n0P7rPIqYwHuaQkdno++ZoZoSlqrMCUKbVlySkOXS34rxN90A7swGBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724135; c=relaxed/simple;
	bh=FwCivQr6S6vuxnr32Yw8TET6cvNCHaBy8KW1soEGpcs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZFbyEkEU5OyNXwchcfzsOM5IYo84vNOfo07CwJlL/0/RT8DkmCPfAGoTtc1mYf4s7c3An5TMgOd2cD0FMzQ7+0dsrDAKfigeByiu2MZfuQp1IUoXv7BhhxKDIZ/slZr7phePFIBamFJyI3l+vnO1bDuP6ojv70jL5MOzfYYrbYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgNawlaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44CAC4CECC;
	Wed, 27 Nov 2024 16:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724134;
	bh=FwCivQr6S6vuxnr32Yw8TET6cvNCHaBy8KW1soEGpcs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tgNawlaM3WcSU8JI/RVkLcCcUStUxkTGYVLeZ0NB43lxMrypT/wSXynMurfLQ7sdy
	 l7KQ6Nqhr/G9DfkiB1BSZk9/U2qliR1UGVRh5Zqz1gLoameTsrmmd7H/vc33X4+ZW9
	 gALbWoS35wYuHCsZBBarGRBT4jYCJ7MEZAUCn0QNUSQxfFtklWLVzQHmGKdPV5E5xC
	 aMU79Z5XYDBTA4Lb6fFMhFHJMPbzfDLUtPXKtWRFQiBuPvDRVCkcTP5Dx8o3eeUTRG
	 uMw2BHpnuXqTfpHbkqrHIwHB748lcXvWLCKCg35yRfJ3ICz/yifozFkskpskaE7wq1
	 BTAhfCLsB4zDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB16D3809A00;
	Wed, 27 Nov 2024 16:15:48 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241127-vfs-fixes-08465cd270d3@brauner>
References: <20241127-vfs-fixes-08465cd270d3@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241127-vfs-fixes-08465cd270d3@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13-rc1.fixes
X-PR-Tracked-Commit-Id: cf87766dd6f9ddcceaa8ee26e3cbd7538e42dd19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d4050728c83aa63828494ad0f4d0eb4faf5f97a
Message-Id: <173272414759.1136650.13938619655130344532.pr-tracker-bot@kernel.org>
Date: Wed, 27 Nov 2024 16:15:47 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Nov 2024 16:41:03 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13-rc1.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d4050728c83aa63828494ad0f4d0eb4faf5f97a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

