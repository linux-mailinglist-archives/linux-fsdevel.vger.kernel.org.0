Return-Path: <linux-fsdevel+bounces-3819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 363ED7F8CA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 18:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C1D1C20CA6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 17:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD142C852;
	Sat, 25 Nov 2023 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAR15COC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD720305;
	Sat, 25 Nov 2023 17:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F03E2C433C9;
	Sat, 25 Nov 2023 17:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700932395;
	bh=xFKxYEeeMm35OvSpt7MHWJFkdy0CYP5cNDUvH54nJso=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KAR15COC5AjkrqLul+wA4MRLXIe3siDgUrjUi+VxFR15SKCH66ozXPuiDsukwI0eR
	 PLGLBIKBu+VjcqZIKa4pvGzwHNRlheoGjseLdizJwuo+G+wogmKpTOXpw4BxrZKfj/
	 4CwH5zFoLeeOOAe12vDoAlYHziqzZWWayksZlIWStio0ZIr/xPmB7YaFJPYkXovj0S
	 8T58EOx7fHYLY133j+Va2tyQU4Pm8S+Eaq4z1G0SWxK0ZPpsJBnxB+paS9NvIjj/Ug
	 00pEr6qSzfFUABCYEPp26wSBDPliX1Zv9wmeO4ARMsdRIxXHXKC3Hx7P45+8GTWNrc
	 J4O4TOIExvuPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D86DDEAA95E;
	Sat, 25 Nov 2023 17:13:14 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <87fs0um1rw.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87fs0um1rw.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87fs0um1rw.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.7-fixes-3
X-PR-Tracked-Commit-Id: 9c235dfc3d3f901fe22acb20f2ab37ff39f2ce02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b46ae77f67874918c540feb1e37a63308b2c9290
Message-Id: <170093239487.710.6463474129665620526.pr-tracker-bot@kernel.org>
Date: Sat, 25 Nov 2023 17:13:14 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 25 Nov 2023 18:17:49 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.7-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b46ae77f67874918c540feb1e37a63308b2c9290

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

