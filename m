Return-Path: <linux-fsdevel+bounces-56217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4CBB144F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 399CF7AF71A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F88289358;
	Mon, 28 Jul 2025 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/yz/nEu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269B12367D2
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 23:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746056; cv=none; b=QChC9x/iFKYVIDTQi8RCHbvMCWSvRRUDTtFodTyssk3u9sO6KWt/lEELBXsGjwDMOitt+ebBb+hRHT8y7VHXn0FHbkPFjd7XE+nlkhqThFgJIqO+TXhH9SX0SjRcF6VuEVjYu91WXz3+C9CzK2fk9BsNBVb7chXmmcsxnccqcMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746056; c=relaxed/simple;
	bh=8RaVWObqDpAIyFbJBiAUZko9cFmq5Yx0GM1h23HeTFw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EKgyYGwHdI0pHdTGps84ddExDLO2IiddKT1qywtYd9zu6XHrAT8yd2Oxl+SMhvEsXvs9DIL1GwG4WlDPrbq8jNZZ6QuBLhZw3VfMxNPa4/5xv0tf8eIWNPNCW/5e00Y7SNxfBD9KIUlXAQhrJS+mU3k9AonNaqRvEmesB+gHrjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/yz/nEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F0BC4CEE7;
	Mon, 28 Jul 2025 23:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746055;
	bh=8RaVWObqDpAIyFbJBiAUZko9cFmq5Yx0GM1h23HeTFw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a/yz/nEuEeGk01mNpiAqt+iRz3QatZ1dY2wUO/pg2JZaH2G+zzb89L78ze3ZAcFOR
	 EeN/Gf2guP1QTwD+nWn6BugDgcAPNZS+3/REegyqpXIRRGAQO9MhGafaZ9l866Slbl
	 G/nXKTOYb2W/a2PQHSh3JORq/JDvgtTke9ELNM2s+mqdPf3kj/xo3suYnfOIholnpP
	 ZeCyoXS9Gg7/s63CqNgcPyDzdwmgUvZmCBe2oX4nzK95ZSiVFdAVGbrZeXWIswmZOX
	 2db2Apjlx/ZahqPuw4U3ZFMaqrRUfYG6W8f+7HuF7snWW/duA1m73MVbTEkAQMG2kC
	 YahTNdnaydI6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB9383BF5F;
	Mon, 28 Jul 2025 23:41:13 +0000 (UTC)
Subject: Re: [git pull][6.17] vfs.git 9/9: mount pile
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250726080942.GH1456602@ZenIV>
References: <20250726080119.GA222315@ZenIV> <20250726080942.GH1456602@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250726080942.GH1456602@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-mount
X-PR-Tracked-Commit-Id: a7cce099450f8fc597a6ac215440666610895fb7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 794cbac9c053155754d04231b9365f91ea4ce7d2
Message-Id: <175374607212.885311.4729205184636980365.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:41:12 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 09:09:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-mount

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/794cbac9c053155754d04231b9365f91ea4ce7d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

