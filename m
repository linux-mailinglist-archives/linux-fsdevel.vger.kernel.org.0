Return-Path: <linux-fsdevel+bounces-23982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783759371C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 03:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3475C2828E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 01:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C2FA936;
	Fri, 19 Jul 2024 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3uUXh4Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7524404;
	Fri, 19 Jul 2024 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721351068; cv=none; b=WPltjvVSwSbwebPN9OBGnpuPtQQNUUXPTgY2oX5qyrQyw9YNAWG2a7SSd2+2TOa8wlPzilxH7xA/OP8rt4Q4gSXfm65STE6feNWjp7uExs5KeBlu2HKU5OzdPTfI94wAb2egoJl0obRD1mhYfltto3WuL5jHMRWOwIbmxtBtaBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721351068; c=relaxed/simple;
	bh=MPalLGQehgA578nb9s78gM/nOMBN07bDNVsuNC7Wthg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=boDW8k60dFPSHDWI4Q0cAaTzhQT0+nSUjWcEGgLcqIt+8xoir8753VlrSRpMCNw/xxbi2zOHAAMPOWLe0rTcyvfJ8meHHqIDAsrT2DjIZ7OjeMWcQnbWA0xEJSD2h9caMOMv+Zv+G1KfFAj06ZAjKjimc+kvKD49+P4et2M319s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3uUXh4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40CBCC4AF0E;
	Fri, 19 Jul 2024 01:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721351068;
	bh=MPalLGQehgA578nb9s78gM/nOMBN07bDNVsuNC7Wthg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G3uUXh4QHrcwwd8kSaOTYSwsP7UxUC06npMLI98deme43j/zyW/2xjrVxji/1ohIi
	 xFA8W8jEAQFUEU2BDX3XhG1mmPOfJ9WeWd1n3YCXFISDOC+n++4TCFH9hOp57BahHg
	 zuqebVRWCLUhkIKM8v3thyZbsHHFiS7xq412NveEfCpA0V8DiNhMQSdorTkPzOhQI+
	 D7sBLpeSqDTj3XojMM9Wa4r7i/xavSN8a4hbrFhrU58CQaQID3dH1vuWXeWVcN6WZ2
	 Yq079aSQGAmdHZ3Uy6IwOTewnKIvROA4Ka7pM+pC3yu044D8DkVMPWqil7wm83sUe+
	 n7UaqC+yFfNLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38620C43443;
	Fri, 19 Jul 2024 01:04:28 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs changes for 6.11, v2
From: pr-tracker-bot@kernel.org
In-Reply-To: <73rweeabpoypzqwyxa7hld7tnkskkaotuo3jjfxnpgn6gg47ly@admkywnz4fsp>
References: <73rweeabpoypzqwyxa7hld7tnkskkaotuo3jjfxnpgn6gg47ly@admkywnz4fsp>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <73rweeabpoypzqwyxa7hld7tnkskkaotuo3jjfxnpgn6gg47ly@admkywnz4fsp>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-07-18
X-PR-Tracked-Commit-Id: 6f719cbe0c8b3b8a14b403b9e60fdb565fd829fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a97b43fac5b9b3ffca71b8a917a249789902fce9
Message-Id: <172135106822.16878.6156391491901192494.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jul 2024 01:04:28 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jul 2024 18:36:50 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-07-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a97b43fac5b9b3ffca71b8a917a249789902fce9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

