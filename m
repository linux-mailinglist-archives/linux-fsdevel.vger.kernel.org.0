Return-Path: <linux-fsdevel+bounces-1792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21CA7DED30
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 08:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4615EB21219
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 07:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D2C5C99;
	Thu,  2 Nov 2023 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaogNLAa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA555678
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 07:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2E13C433C7;
	Thu,  2 Nov 2023 07:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698909794;
	bh=SWiJ8HDCVOzU/RmdaeaMb1iWYoXl2ujIZkdLEkmxp6E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gaogNLAarjtkSvxD1Psv+xFk8gAmn1sIJesP8UfAbKdBctb8pnS9zG2qoz+3Cg6ml
	 0RvwMb1B0V7PRYzZpUxg5/DKxcGTiK21SgbGCPa2SJ5YefMjIaSakmB7FItf28nZxh
	 Waudxt6/hpX2jyHaXgJAyRdvlJT4qIsiHsPdnxjnGeJ2R4bTo6WeXKJvwqPqHTTYTL
	 g0hL4ByvKxAeX4ehiHivGph+3LUaDExj5dpn15piZtrsu+Q0hCJbiw7wYBmYFu83rd
	 CTdCbUTuP0JSvxs7TepkREFpF6X/w0MVrO0vbmTwZzdIAo/V3bD/S7jX0CsUBmjalO
	 QRaSkTX1k9WYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FB6AC43168;
	Thu,  2 Nov 2023 07:23:14 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.7-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZUKttkQ2/hgweOQP@bombadil.infradead.org>
References: <ZUKttkQ2/hgweOQP@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUKttkQ2/hgweOQP@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.7-rc1
X-PR-Tracked-Commit-Id: 8b793bcda61f6c3ed4f5b2ded7530ef6749580cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 426ee5196d1821d70192923e70c0f8347faade47
Message-Id: <169890979456.20895.8527754234743304909.pr-tracker-bot@kernel.org>
Date: Thu, 02 Nov 2023 07:23:14 +0000
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Joel Granados <joel.granados@gmail.com>, Krister Johansen <kjlx@templeofstupid.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, Iurii Zaikin <yzaikin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 1 Nov 2023 12:57:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/426ee5196d1821d70192923e70c0f8347faade47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

