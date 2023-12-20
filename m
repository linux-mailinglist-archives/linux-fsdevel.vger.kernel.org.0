Return-Path: <linux-fsdevel+bounces-6604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AA281A788
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 21:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7E22889E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 20:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4971D48CFF;
	Wed, 20 Dec 2023 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6MuwGzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA1F487B4;
	Wed, 20 Dec 2023 20:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27C7FC433C8;
	Wed, 20 Dec 2023 20:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703103192;
	bh=b7SIMzMYWuwDwBZZBkV1rUx56WnnkCBWjHcD4OAzNeQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=b6MuwGzWxPw9Nn4kcmw0DbjI6lbRR3dnwxknFu2Qx0C9omIKpRCP7N7M4+a/dAcDr
	 nvEntM3H8RL8bIYfm2osST2fWy4SAk3MWxORxjAG1qAXcymipUaSwPWjjStU1+Q5UB
	 Zo9vIjgCujmJ29D8MB1FPIW/FwEMW/3s8VbWjKshW8IU2lmmaKrgnPSCyuqytI4746
	 xmkK83PZTY3prgdOSyUhpEeYnc5QWOdx7E92xvyiLmvgDWy4nIA4PYtWJH1ZJOKw2g
	 jlrBoWby+KDeEM0V1aUdkD5j0GlT5gOPKfVWl4t+njMXbdWRavlS2uqOxjJm5WGX83
	 6xVRppMmrX3DA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10C87C561EE;
	Wed, 20 Dec 2023 20:13:12 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs fixes for 6.7-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231220033505.735262-1-amir73il@gmail.com>
References: <20231220033505.735262-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231220033505.735262-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.7-rc7
X-PR-Tracked-Commit-Id: 413ba91089c74207313b315e04cf381ffb5b20e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a44b0073b9235521280e19d963b6dfef7888f18
Message-Id: <170310319206.16038.17631825269258809724.pr-tracker-bot@kernel.org>
Date: Wed, 20 Dec 2023 20:13:12 +0000
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 20 Dec 2023 05:35:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a44b0073b9235521280e19d963b6dfef7888f18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

