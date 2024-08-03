Return-Path: <linux-fsdevel+bounces-24921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03297946A86
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 18:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360491C20A8E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F8D11723;
	Sat,  3 Aug 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPvoCA/P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1BFF9F5;
	Sat,  3 Aug 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722702729; cv=none; b=LbEqSapW6uA1rtGgxJ1pB0kPMN71+jISRXyBvNNoj0G8hX/hJGqycbReNmQdio5ta1E7u39CPtqrDgRGoR3UdZg1BWhV3j3HP5bS4o2I4iiVJe56vOTUetEQvQlK8/qwLy/V+aW710u7bcRfXpJMj3Q8Z92554SEE88oSQtvjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722702729; c=relaxed/simple;
	bh=DBbjwRMnitLvA4ueHFUZLGHwEvfLDJffQGG12lg/sJ4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oK/khdonGM5ZzCh8FxX5iwJRWVGMmG05x//SthzPCxrDXevNbbC9TkOnf4n/P3936eE5VhFGKtjHYIDnR/jRpYGa3h52XI0t8uzCqdF/PZeWOa5VF+TFUWdPevfcFp5mE21geZyiFL6BCfMBCoX6s+A/6/6k+JJnzWJnP7og3tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPvoCA/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2925C116B1;
	Sat,  3 Aug 2024 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722702728;
	bh=DBbjwRMnitLvA4ueHFUZLGHwEvfLDJffQGG12lg/sJ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vPvoCA/PjMsJwaTnTzQsAzAO5tSBqd8qu6PvaM+iTtHINQiqBYLShoC2Pl3xeuaRL
	 gWF37erZURAscmGkuAVr81YLyujH7bf39iYEQRdYYUeOsGIXHdYF1LZhaHI7809Npo
	 ayfqvxF8YRz35u9Yk5KXppAX/vwJ+RdfkK7aueEoRe0Uz4mNa7dm5MSAKR53waJT8M
	 7e8CwU5pzZtU+6MRQgKidZoYzSeGLOg/oiA1ZJ+TwMrGNVET0jXvRDHl88aOofKmlR
	 sheP08vp1QQEpViY5sXPr3sl0nFAECWrB0/BFbG9nHkBMd/0aCDEgpSfIqzx6+ynWH
	 EZ6EbC2WW4Lqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3072C433F2;
	Sat,  3 Aug 2024 16:32:08 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <87ikwh1wpg.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87ikwh1wpg.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ikwh1wpg.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.11-fixes-1
X-PR-Tracked-Commit-Id: 7bf888fa26e8f22bed4bc3965ab2a2953104ff96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3426a6ed9d8398bfee2a1c5cd0ae50f2f4494a8
Message-Id: <172270272878.23596.11466645572339820596.pr-tracker-bot@kernel.org>
Date: Sat, 03 Aug 2024 16:32:08 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 03 Aug 2024 20:20:49 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.11-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3426a6ed9d8398bfee2a1c5cd0ae50f2f4494a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

