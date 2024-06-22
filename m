Return-Path: <linux-fsdevel+bounces-22186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B619134FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 18:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89601F22A86
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 16:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A684170838;
	Sat, 22 Jun 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1q57vLr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703C16F913;
	Sat, 22 Jun 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719072607; cv=none; b=GqBcwGkeBcmkhH2kSLWyI7+vVXTO/eqZDJOxn0kscgXClHJIOhQ6bsf2j0plO4A/DfaR9kS7D76BoCwakbN2Am9JJ8OYeKMUeWnG8P1h6Dow86X7vYfUbMmyjSxW9Va+dzRxDb+HAUfHWE+gK/486NgBYJ+UAuTtpo7atQ2Oz0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719072607; c=relaxed/simple;
	bh=WpxSIouvBFxC9L1AhBoKoMtOGKHeq80LvsCWNT85bvg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RTKwN9XYQqm0f6FT0WxmvRYw2fG2XwUc0mK5pSgT0zd2RkIuaw3vI50fYob4MBH35T154wqgyraeF2f5WBK9wGarWGUQFPbzQew3oxOVl+5AjkKZ54kQn2xAfyYB+YyTX8BGoT9DOFQgMn7K38kEFoZX2djMlHT0+i1ryAucczo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1q57vLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C433AC4AF07;
	Sat, 22 Jun 2024 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719072606;
	bh=WpxSIouvBFxC9L1AhBoKoMtOGKHeq80LvsCWNT85bvg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q1q57vLrDLngc7kshcOQ6/mqNeWL/MNSs2GBG05LJxpN/HIX1CBzsQ6ZK+nSDw7uN
	 yfsUcvxb1DBfyj/TgZGj1wDGR7hLL8RLVokCgKsGHVC4PuJwvBrxPbYf2nKX4nLVhw
	 CKGNLeE1CXls9iQyglCGu3ArsDswF095k5+4WzdNrzZFupa6AGdP4I5iBkVxtDMXW/
	 1Rs/y2a8sUJ44YH7IYuHT+vMec7SXCnX20l/ftBA7JQ1QS1K0xvLhTbd0EUp4g6gSJ
	 69jIn8nkJvP7ZeJNTp6f0KjZ1ybmndcV7nEVC/gtSbqNO+xA1kgbshCIs5AUJli9Y8
	 Wx1vHb8QymmJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9E1ACF3B81;
	Sat, 22 Jun 2024 16:10:06 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.10-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <nbed7rrwexwonrtxvv6zmlxrvheicxxx6vlzcq4hzcxhrtm7ps@s5nkcab6f3cp>
References: <nbed7rrwexwonrtxvv6zmlxrvheicxxx6vlzcq4hzcxhrtm7ps@s5nkcab6f3cp>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nbed7rrwexwonrtxvv6zmlxrvheicxxx6vlzcq4hzcxhrtm7ps@s5nkcab6f3cp>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-06-22
X-PR-Tracked-Commit-Id: bd4da0462ea7bf26b2a5df5528ec20c550f7ec41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3de9b572fc2063fb62e53df50cc55156d6bfb45
Message-Id: <171907260669.30765.11576903904385555925.pr-tracker-bot@kernel.org>
Date: Sat, 22 Jun 2024 16:10:06 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Jun 2024 10:00:27 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-06-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3de9b572fc2063fb62e53df50cc55156d6bfb45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

