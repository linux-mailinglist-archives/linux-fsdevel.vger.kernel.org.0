Return-Path: <linux-fsdevel+bounces-26197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FD795591F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 19:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D571C20F20
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 17:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565F915575B;
	Sat, 17 Aug 2024 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7aLOCB5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8A484FAD;
	Sat, 17 Aug 2024 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723914742; cv=none; b=BdFwK9SWA/kAsCNMHEKLCC1+rIAFUiGEm3c19tr21fTTupKF58GT+kXQP/By5WGS4l3VXxDOqShI/uHDoFp/VTEPZMO7TosFd3rim/yLh7C1h1HFVrG7Y3uMbYfTGqW4N3Pv71HzLwI/K1pkdW6O84FcAQ6ksDL1FFiWlCnnG6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723914742; c=relaxed/simple;
	bh=3CXBie8MW8kB0xG4nVLzfsBLrZwTQuGIvctbhd8pNlU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pHPZSzS1LBW8aX1dmo227k/xrLxyL9z1KR6HUQxD0TrpkL0GYvwaOx4ZEsg2ceFAUfzps0OCyqxeOEG+w3FSr7qnTi1CjTt+yR2zqTFwFbx6A7H+Ol6KCF8nfhin1+ocR01fGN4AxX3lUMVWJm3zzBkB2dD9TOfIzj/H/Jrl2Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7aLOCB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D07FC116B1;
	Sat, 17 Aug 2024 17:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723914742;
	bh=3CXBie8MW8kB0xG4nVLzfsBLrZwTQuGIvctbhd8pNlU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g7aLOCB5i4Hv9DoHdFR1eYLSzSWDr75Xle0/HRrnWgkQmRdxCA9tqgJOhli5OSWdQ
	 VB/VGSiAEtlu7jyC3Kzc3hnOohlPIJZD0ngd90XzpZr45E5mNPb3lY3ALwDTLp2PgC
	 bOY6RRCcTEsAfBWqQ8QHWcmhZUdekJixlciaxznZeG3k0qkTBANpQp0AAHnaVJecdX
	 UI72gIEx+KFG7DLtDbFSEkGRJKVWgbul0qohTEYYgNsrO9cDmed1lZJzx34iK+wesW
	 cjHhpoqc7Mr+rqD4V6+sHMmhjidTEXpQ1j0iyD0QSYh7Q/WcBoxhf1w4C8Y3w4Za6p
	 bo8wFypIlpBxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344C138231F8;
	Sat, 17 Aug 2024 17:12:23 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <xu2afkq5jhn62z3juxkbvs2idoyldruyv3h65ympwx2svbgjia@2qqk5e6pcdoc>
References: <xu2afkq5jhn62z3juxkbvs2idoyldruyv3h65ympwx2svbgjia@2qqk5e6pcdoc>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <xu2afkq5jhn62z3juxkbvs2idoyldruyv3h65ympwx2svbgjia@2qqk5e6pcdoc>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-08-16
X-PR-Tracked-Commit-Id: 0e49d3ff12501adaafaf6fdb19699f021d1eda1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b71817585383d96ddc51ebd126f6253fdb9a8568
Message-Id: <172391474168.3799179.3737766336124813850.pr-tracker-bot@kernel.org>
Date: Sat, 17 Aug 2024 17:12:21 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Aug 2024 21:20:03 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-08-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b71817585383d96ddc51ebd126f6253fdb9a8568

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

