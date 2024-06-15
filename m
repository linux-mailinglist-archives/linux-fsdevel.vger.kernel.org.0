Return-Path: <linux-fsdevel+bounces-21764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B545B9099B0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 21:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1E71F2227A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 19:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E2D60DCF;
	Sat, 15 Jun 2024 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt+1b3HQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9D5339B;
	Sat, 15 Jun 2024 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718478918; cv=none; b=D37QO/SIhq25gXkj2PFUFKooTubP8tB/23vWla9QeC/xT8itV2idk9NrytMieFVFCkVuVatYI0qqZDDoYp5yc/3E1FA9LKH8YR3zWuXvh+yeMNZu3jchsy58gtnEoIMeRtgNFbC7J/sAcqWF2v+XOGk8WOEbH7IGT7MXUs/vbIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718478918; c=relaxed/simple;
	bh=iRnhuKa69obDvtKWa4ilJY2fVRCML7yGp3H0OawyiDo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FM1X8J6jNdodogd9jwW/pY7w41lPsHdKXZSdPQQyGcnNiDYwrs/FBneJIZyhNrdVseBxr/Pj7m3SjeEFS1k8iFm4fx564WqS7YQLVpEBaStr81HZntWN4jOXc4ozs2JeoSEHGeWnL6XWF4n2TwEXzW579c24fVFhAQ4SXBMlmdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt+1b3HQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4D82C116B1;
	Sat, 15 Jun 2024 19:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718478917;
	bh=iRnhuKa69obDvtKWa4ilJY2fVRCML7yGp3H0OawyiDo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bt+1b3HQjH/qJ67L3+ya7lC0gTaDk+1z4S7McEbWBtU/mXmGKUoUOasq5XIXHUa/U
	 8wXyw+UDhkTYlX92fiRqmJn/MzMW2JYM8Vc2bi/HPkCC6vLELgs6Uk79iZBp7+kSZg
	 2HhmDCPpnWXcekj0VJF8RUjHMv/HaQXvB7dUWH/cSQp8URvbP9e6FMiiO516V8QKeu
	 2W4zFRrSUi6qsK8N77TO9oeP6EVSzjXfddx5x6ikUd4JCYS0V7R3EDNikOUPPVDsJA
	 DYRUecSCuPGsvrgJUN8cQy6iuKQmiox2zUZQ83yqngEyNBCZjvj8S8GIIE/ZBwFngh
	 5Nv+EuQNDykRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1F16C4332D;
	Sat, 15 Jun 2024 19:15:17 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fix for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <871q4yfb08.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <871q4yfb08.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <871q4yfb08.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git xfs-6.10-fixes-3
X-PR-Tracked-Commit-Id: 58f880711f2ba53fd5e959875aff5b3bf6d5c32e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3e18a540541325a8c8848171f71e0d45ad30b2c
Message-Id: <171847891785.12391.10756814113224538097.pr-tracker-bot@kernel.org>
Date: Sat, 15 Jun 2024 19:15:17 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 15 Jun 2024 21:30:28 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git xfs-6.10-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3e18a540541325a8c8848171f71e0d45ad30b2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

