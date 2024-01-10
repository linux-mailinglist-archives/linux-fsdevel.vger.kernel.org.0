Return-Path: <linux-fsdevel+bounces-7733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B5D829F50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 18:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D448B228D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 17:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B547F4D139;
	Wed, 10 Jan 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6qcRh8w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4DF4D10E
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 17:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03983C43390;
	Wed, 10 Jan 2024 17:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704908254;
	bh=9pM+ZGvAXeO30ACzKKPdt8D7X7CuFoVhp8ghZ3TOxIE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W6qcRh8wq9/P9uxX5wRRGc5nvCQ0EaJljH/LHSO/O4vg58cKUNyHmuODyLLpVfXVK
	 VuYPzfdc7qwOQ8gDI2EnqZe+UnqY0KECBVKllCXrPlCq6btoqnMwgua6A0Z35aqjJ4
	 NGXFQ68VM5/cBaqL6xZL7hHH/5Cp75GMe2jvBN7s30Bv3gRJ1UpzHO3hcWrJ/WkBFn
	 cmK9mHYlT6F9mWsyxa1erPw8bwISZrbE8g6Vo96jAVnTq+JQrwMA8YFSnKH6/mdDMn
	 OJqN3ooWn0D7ED1usJQu0Qvf2xShiZLpigte4Rwtzj6XXSfnepReslQcaTj2umLul0
	 YxjwF/C3ZrCaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E71C7D8C96F;
	Wed, 10 Jan 2024 17:37:33 +0000 (UTC)
Subject: Re: [GIT PULL] quota cleanup for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240108135000.hshmcktxiqb4gsao@quack3>
References: <20240108135000.hshmcktxiqb4gsao@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240108135000.hshmcktxiqb4gsao@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.8-rc1
X-PR-Tracked-Commit-Id: d1c371035c8204112d84266e6bde7537f25448f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9963327f8e578bb29de2e283ee16b0f95c20201c
Message-Id: <170490825394.14271.17436139776826151067.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 17:37:33 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 14:50:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9963327f8e578bb29de2e283ee16b0f95c20201c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

