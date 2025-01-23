Return-Path: <linux-fsdevel+bounces-40015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF94A1AD17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 00:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D17318893C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 23:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21391D47C8;
	Thu, 23 Jan 2025 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNc2P6wW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA4B139CEF
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737673342; cv=none; b=haoaUEMR8SqecKvsqrgHZ3Y/mPjx1MPhARGIjvNXQ3Yjmvmt2eoNciMM9Rnk7p64aqpzbs7xa0Mh7MO4fA7lnoymnNl8QAXaIEaKtDZZqtk4YLYaBWCfruZNEpeTABgD4hu/xwGrIlpajOJ9v5CTbZIe14NU11XDCuFPSAkDEhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737673342; c=relaxed/simple;
	bh=Ubw3EJA5AXBbBo0Tos7XS2O0W3MngaeIG71EcJSB1Wg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HELW96doZfvCZ6DfiF/gfR/XuYesq2p+cCh+GpHXSy6LFatKYT3FMsddbU1WbWmZOJ6Tt9rq5a2RTUIiGKskQq3EVYZaSYRtX5Z1VkNlDJMTUOW9awuHHMzuDgZibANhYJsMG/1OFm6LjMccAgCF6oWm7fyRVMqbViQ8vu0t/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNc2P6wW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F225FC4CED3;
	Thu, 23 Jan 2025 23:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737673342;
	bh=Ubw3EJA5AXBbBo0Tos7XS2O0W3MngaeIG71EcJSB1Wg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sNc2P6wWqVMNtd1ttT5cZoylPi0LYsa1KNPGmCbe+GEuLX+bnEy+KkAJCIXNaRtBG
	 r5pUgKTRHeKwbPTCRxB3e5knXJj7nVJnVJwD9V6yYcb0ooV8Z35aAXBxD9xKKl4GRE
	 iuzwpWJP/T1He8OEud3mdtcQiTx0AK1BhulE06xAUKMhTDtxvW2jSe/oWWpsnCcm54
	 s7+3sBKa+nJ98aKt2eDSf6GNhSYwE7U00E3MYZPAw8NUz+kbxi/hm/yrgg0zXF3Hct
	 42+Fyw1nr7b1VlBqjsdpObqvZ3aroPEW49/ih05/fDpsERI5f5EPmdah0AE43RuTYF
	 34WOv9ZvMLj6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC8F380AA79;
	Thu, 23 Jan 2025 23:02:47 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify pre-content events for 6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <uuxkzulie4wewcbfdtdn6sx75ncm7tbhg3ptj3jpu2sh6q4lx3@zuahiyvmnigl>
References: <uuxkzulie4wewcbfdtdn6sx75ncm7tbhg3ptj3jpu2sh6q4lx3@zuahiyvmnigl>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <uuxkzulie4wewcbfdtdn6sx75ncm7tbhg3ptj3jpu2sh6q4lx3@zuahiyvmnigl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_hsm_for_v6.14-rc1
X-PR-Tracked-Commit-Id: 0c0214df28f0dba8de084cb4dedc0c459dfbc083
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8883957b3c9de2087fb6cf9691c1188cccf1ac9c
Message-Id: <173767336642.1527693.12225519054110794861.pr-tracker-bot@kernel.org>
Date: Thu, 23 Jan 2025 23:02:46 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 Jan 2025 16:44:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_hsm_for_v6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8883957b3c9de2087fb6cf9691c1188cccf1ac9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

