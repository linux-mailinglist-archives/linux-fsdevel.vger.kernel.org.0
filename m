Return-Path: <linux-fsdevel+bounces-786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12BA7D01BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 20:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC251C20F1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 18:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690BB38DF2;
	Thu, 19 Oct 2023 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV93abW/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCB339856
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 18:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7E59C433CA;
	Thu, 19 Oct 2023 18:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697740576;
	bh=ZbOL/C/VNWy+53xiRgBBndhAT8gctkkRJfqEABWbbxQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TV93abW/Mrt+ZcJyeBLTuFaUCyvdeHFy6N0kfhAWsUSxIIo/rzPNaRrRqUeDv9/Ee
	 dMGVEVz49qiG0GEEi3qDB/OzFJwEBbizwUVyeIJ6LxU5RKv4HMjKxfG3WuGueQQW23
	 wiID8/u9glImg1GfFnPZfjfsuF2zJMzt7Nf+h1J6Ig0120cmuY0Y+EGMnlaxCBscf6
	 y0oZNeesZcrYJ7Za5jr35M0q7mTu7JrlVVbavd1qiR21AebutLQa1LewqTEjTufATU
	 I3X9gnEZYpOctKh+OFxudndzhnhXVuBxxUXu0tsjt4nTrDS+bjyZ7Z/4cc3E0yRtng
	 eH5w3i8GtbYMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AAA82C73FE2;
	Thu, 19 Oct 2023 18:36:16 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231019-kampfsport-metapher-e5211d7be247@brauner>
References: <20231019-kampfsport-metapher-e5211d7be247@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231019-kampfsport-metapher-e5211d7be247@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-rc7.vfs.fixes
X-PR-Tracked-Commit-Id: 03adc61edad49e1bbecfb53f7ea5d78f398fe368
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea1cc20cd4ce55dd920a87a317c43da03ccea192
Message-Id: <169774057669.20290.2402889102642037711.pr-tracker-bot@kernel.org>
Date: Thu, 19 Oct 2023 18:36:16 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Oct 2023 12:07:08 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-rc7.vfs.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea1cc20cd4ce55dd920a87a317c43da03ccea192

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

