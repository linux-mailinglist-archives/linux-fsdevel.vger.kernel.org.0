Return-Path: <linux-fsdevel+bounces-978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D3C7D47BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 08:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD8B281824
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 06:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A040A7498;
	Tue, 24 Oct 2023 06:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbEAN1wI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B7D63BF
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32C55C433C7;
	Tue, 24 Oct 2023 06:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698130205;
	bh=PRXhVx10/FrjA7p2MGMU9DorqGW2Xn/JzzYNkmVXj2k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mbEAN1wIsezVUNK4++FZtKNNauljLzZUs7jP7V0tZAhM5k2e43Qhi7MLqdG3XtE00
	 HApA3MkfUe0atLqaVrfNAgfKf9o7MXequ1avpiACLgkEMBlx4rhCi+y7acOSWyofpi
	 x4xHBEgJE9i8gk3IcP07aJT8mr6gXDuSXKul4zBaOs5d653fRnwSe/9V7ib70Y9wj2
	 /e4tZHU2KiPiOooGvWTeeIAWHfF69xcCXmng+O24NI5uJyWGezfw7oGj4EYOGYOpP3
	 DnRX+B+kyVbHEB0/5X3EDp6Ucv0GkgZM+B8UiyUzfqyDxPlejCW7eQoQplWKvZWt8Q
	 qmUO/i1rZEelQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05A8BC595CE;
	Tue, 24 Oct 2023 06:50:05 +0000 (UTC)
Subject: Re: [git pull] nfsd fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231024061853.GG800259@ZenIV>
References: <20231024061853.GG800259@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231024061853.GG800259@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-nfsd-fix
X-PR-Tracked-Commit-Id: 1aee9158bc978f91701c5992e395efbc6da2de3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d88520ad73b79e71e3ddf08de335b8520ae41c5c
Message-Id: <169813020491.9837.3700927031871789177.pr-tracker-bot@kernel.org>
Date: Tue, 24 Oct 2023 06:50:04 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 24 Oct 2023 07:18:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-nfsd-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d88520ad73b79e71e3ddf08de335b8520ae41c5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

