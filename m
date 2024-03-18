Return-Path: <linux-fsdevel+bounces-14768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7707087F057
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 20:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331BF280F38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 19:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C60A57336;
	Mon, 18 Mar 2024 19:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6z/PHQR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D54956B6E
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789672; cv=none; b=uAbYeKgcGk9PKtXEhDl0zyjDCd/Ks+8aUWxWWciAYVVGm/T3oLvMo3UzuTrbjN+pd6jmuacuiTomOh4l4YuNAgP53OzkeaIrPvASf5CfiRE/QoppGUsxYi3T+wDFjLbagZkZvJCkZcJDU8X3RP5CG3vVdZDV8/t8ufGpmq5nWiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789672; c=relaxed/simple;
	bh=ItQxVBv5ji7bV93wQYwxWCA5isrwFThlWY4ndKeMuSM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kntlHMab0W+TdkwyRtASKunDL+e9hcYMvBpkGjbG8BOOjUdFMR8eIWDs1Bv9BuS2/4nkHVYowf0Ru/Ht8UQ4xWVeKC70eGNHBPRhT01hx9mBGGh6sICxVePMzAMt+giQ58vbj7ROzHQiz0l7ago14FDjyXa0LHvF3xpqjDF4djQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6z/PHQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00678C43390;
	Mon, 18 Mar 2024 19:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710789671;
	bh=ItQxVBv5ji7bV93wQYwxWCA5isrwFThlWY4ndKeMuSM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=F6z/PHQRjLaCJV2LZv+NnKRqqfCcSfpaZWoGb5voHDmRzUL3/3TQ713b+r/0ltEdu
	 uyfXv53fNPGaAI6dPd5Xxh7vrbJzFFtfh5STfdxTYlzZttj9AsF78j8M1HGeM157Sw
	 ApzzCDDeI8jaU/dLsXEaTyVtAYzeSkbAp9SjLis2vQws4+RZYdjxWXkRRgtw27ETjU
	 9cwDJjYT+l92WEmbFyaDOMZ7dNRuP5BHTI24mkjNWqGzNMRDlwyIVMN6QqWLh5B3ze
	 1QO6vEgMUW7LD4X3lrIh9n0IzIQKBPMChaSmFPTn1uzfllZz7Poosf9PQ8B7B+G02X
	 dsNJENEkKcgjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC65317B6474;
	Mon, 18 Mar 2024 19:21:10 +0000 (UTC)
Subject: Re: [GIT PULL] orangefs updates for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSSsSvVzxVfkyv2vNoYNE50pLpnm040K1eA+2KV281ugGA@mail.gmail.com>
References: <CAOg9mSSsSvVzxVfkyv2vNoYNE50pLpnm040K1eA+2KV281ugGA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSSsSvVzxVfkyv2vNoYNE50pLpnm040K1eA+2KV281ugGA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-6.9-ofs1
X-PR-Tracked-Commit-Id: 9bf93dcfc453fae192fe5d7874b89699e8f800ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf3a69c6861ff4dc7892d895c87074af7bc1c400
Message-Id: <171078967096.17817.492138087272801786.pr-tracker-bot@kernel.org>
Date: Mon, 18 Mar 2024 19:21:10 +0000
To: Mike Marshall <hubcap@omnibond.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mike Marshall <hubcapsc@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Mar 2024 14:43:26 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-6.9-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf3a69c6861ff4dc7892d895c87074af7bc1c400

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

