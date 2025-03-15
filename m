Return-Path: <linux-fsdevel+bounces-44127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CAAA631B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 19:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0E21894BBD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 18:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03369205AC2;
	Sat, 15 Mar 2025 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNDJpHhD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F41F8901
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Mar 2025 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742064007; cv=none; b=q2QH7iTFfgNINjZs6+PdHXDzTJzkEwwb9E9lfOPTiEum8ZmdXqWRdrprVJy97GitRLjk/+BTo5gNXAcwG6tRmSmOu7NgCo9IOrrohZkF3LUe/m26dPNODg5PMrH1iR2Ayy9dUEZbseLoQDt4H2zpbcEC+CF25gOfYL6zGqufK18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742064007; c=relaxed/simple;
	bh=/DKreI8JeIRBjqYbkA4unvvpetryCnpDpiS/sTHJzEQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tmuGKatjmYj2pBLz0E4z7hminlCMkh6Y1n/ZlenvmmdGUeqTWzATvOuCd4NlIudpHsNKWCka6OZH5KlRRROS2Wv/YZjJIh0g4hlhi/7L4XRIC8Cpj8U9cs3W0W4rRJz0NqO5je8Wf69dhO6ZDippFwJpV3HM98UoIp1NnUhQXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNDJpHhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FC2C4CEE5;
	Sat, 15 Mar 2025 18:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742064007;
	bh=/DKreI8JeIRBjqYbkA4unvvpetryCnpDpiS/sTHJzEQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HNDJpHhD3cEx3eCma6uha8DpLw+g+i7D0XA0QCE9GmM3PRAPwBWvKGWqTDzgypORf
	 C8ifBeO6jua8joF/5sz2yJLbSkAK0vr3l3B5uxX55vBlAeUjFTfTDj0Y3E8c/JDyrg
	 MlVMDaLlJmjjVSRGI3jRlocGYt4x6pCiUg7FIjvZX2lrDygVLts7o7yKw3795LctZJ
	 lMM90NHXzgB4yGSHsKtr8N+Yg+lhjT2nbkI5OJzFo0iOoG3Q/U8D/ruwg55OqY1zac
	 tKm7/MvnqYBy7io49z10V5m5p69Y4QZtmcuq+LmJInk5WYFX+rL/YjGJYq/BxN4iqx
	 +OxUasQD/ni1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71319380DBDD;
	Sat, 15 Mar 2025 18:40:43 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify: Revert HSM events on page fault
From: pr-tracker-bot@kernel.org
In-Reply-To: <jk4xlwczp2ydzxbib4fi5lfdlclebpexgy7ilds37dptjpmpmh@f2ctckma34ke>
References: <jk4xlwczp2ydzxbib4fi5lfdlclebpexgy7ilds37dptjpmpmh@f2ctckma34ke>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <jk4xlwczp2ydzxbib4fi5lfdlclebpexgy7ilds37dptjpmpmh@f2ctckma34ke>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.14-rc7
X-PR-Tracked-Commit-Id: 252256e416deb255607f0c4a69e7cfec079e5d61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb88e6bfbc0a975e08a18c39d1138d3e6cdc00a5
Message-Id: <174206404210.2630914.4851032723484175223.pr-tracker-bot@kernel.org>
Date: Sat, 15 Mar 2025 18:40:42 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 15 Mar 2025 10:52:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.14-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb88e6bfbc0a975e08a18c39d1138d3e6cdc00a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

