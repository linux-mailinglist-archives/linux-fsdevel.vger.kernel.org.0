Return-Path: <linux-fsdevel+bounces-10213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FED848BE2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 08:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16158282A47
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 07:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67690BA29;
	Sun,  4 Feb 2024 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBPU5eTM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE7B65E;
	Sun,  4 Feb 2024 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707032675; cv=none; b=LckAkHsiLdxPuOpBc+hvN+T/lryL2WP1dlaMUE6GX9SEPh36CEawlns12luEfIUAY3cYsZe+rd33jEZIlREu1eIlj/xyHJ+pUZR+sMTSMlX3vwKOKf1UxIwvih0lmPgdczBo75UCCc5SCyvWP4HXftOG0zh5Vwn9K7MFJ3Bs61o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707032675; c=relaxed/simple;
	bh=FHjk/8TX+XnjgESf9y3O1ebe63N9xGIrhxABFPJi36g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qFJIP6kZ82vBLBncbRhc2cp3hh9QjN/APgv7FMC/U6Rh6CMRNvNqkeGio98f4d80zPhQeHSJD4QHDkHqoVDnnP2a6bYfCUc17wwQmQ+IBODkG2qzoTVeSv7J5ApGa2w/0bhsnoKXRLF1GOoNYhSTBWjx0xCdWbalctKfbMqPT0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBPU5eTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BAD4C433F1;
	Sun,  4 Feb 2024 07:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707032675;
	bh=FHjk/8TX+XnjgESf9y3O1ebe63N9xGIrhxABFPJi36g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gBPU5eTM4jmLZouwS26hqtE6PkeTg4BeHwd2VzXFHSjGjVbLmBldmCybTiOXZG/ka
	 ICLrQkKflMuDoJbdZtTYFnyQ4OAPDNCMgXGeaUzashoRZCxKVtgmh2qg/Q4775MSCS
	 AtbAoKmWrOnNFdkgIqq3sJz58fzEGgya1f2DKAIRo1VIDmJLSwTRMA/TDeqP0Vbeup
	 5HZsdmlzMTuN5JhWO+p5CcjXklEMxfIfvtsTWzr/YyJ5M9ZpWV0H/IvH3IUc4phI+x
	 E7ip2eNUSoOG3Rj2Ab7cEqgqUzGpeh3xZw9KBqtjoTrW2Go6q6PnZaaI/QKj9bcEH5
	 oFNWdNRu03y3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82609C0C40E;
	Sun,  4 Feb 2024 07:44:35 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <87sf29efj8.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87sf29efj8.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sf29efj8.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.8-fixes-2
X-PR-Tracked-Commit-Id: 881f78f472556ed05588172d5b5676b48dc48240
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc86e5c9909b1b9a80ff0e7946279dfae6b96ded
Message-Id: <170703267552.4518.4332597130950953883.pr-tracker-bot@kernel.org>
Date: Sun, 04 Feb 2024 07:44:35 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, aalbersh@redhat.com, djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 03 Feb 2024 20:52:40 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.8-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc86e5c9909b1b9a80ff0e7946279dfae6b96ded

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

