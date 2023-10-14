Return-Path: <linux-fsdevel+bounces-360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C11D7C954A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 18:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC83B20C82
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906C114AA5;
	Sat, 14 Oct 2023 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjvDhyXD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C975682
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Oct 2023 16:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A869C433C8;
	Sat, 14 Oct 2023 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697300097;
	bh=OKeSvqj54PhQyIp2lsQinU0daZ802sieG/BNv/pYqRk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JjvDhyXDbuEXy+8bSqaeQ/jdilArumXKnHv0FK+PplDaNGro8klvauARvtOq/Rk4N
	 xcM7cqbXYxdUkOyM48+ZkBGajpcGH0DEuxPDU0e5uihtrszIAYfnAWYTk0aH2vqiMK
	 wmf+2DrOoAuTUB0PK5w4TOyHyF1EDrWFOWgTGSaRNMTAJFdVacpbyG4jNKRf3mlQHG
	 ncrc22csZ8pgJVpvvoP6b0UMDEgiXjoWPY0mupeOOi7wjwcoJUTsXZHavwuIje0zZC
	 PnZOyJ1M8E3ur6kA/vrrEsmSAAhIZEzbxd6Eod2vWiSfMtGrCpOjOe9HiWPuulCs7z
	 0QpCulqk7u74w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48587C1614E;
	Sat, 14 Oct 2023 16:14:57 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 6.6
From: pr-tracker-bot@kernel.org
In-Reply-To: <87o7h1eb12.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87o7h1eb12.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o7h1eb12.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git xfs-6.6-fixes-5
X-PR-Tracked-Commit-Id: cbc06310c36f73a5f3b0c6f0d974d60cf66d816b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70f8c6f8f8800d970b10676cceae42bba51a4899
Message-Id: <169730009728.8595.8665112790994175339.pr-tracker-bot@kernel.org>
Date: Sat, 14 Oct 2023 16:14:57 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, abaci@linux.alibaba.com, djwong@kernel.org, jiapeng.chong@linux.alibaba.com, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, ruansy.fnst@fujitsu.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Oct 2023 16:14:27 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git xfs-6.6-fixes-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70f8c6f8f8800d970b10676cceae42bba51a4899

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

