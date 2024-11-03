Return-Path: <linux-fsdevel+bounces-33575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841289BA38C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2024 03:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6931B220E4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2024 02:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC8E70808;
	Sun,  3 Nov 2024 02:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIfaZYb1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF7EBE6C;
	Sun,  3 Nov 2024 02:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730600770; cv=none; b=K+QcJBVYDMq5mUTCQ1Y4I3vQdspQm1FiJbJMhSwoAZ5zvAl1uGPzlMAejex5lgZMAARHo97m4KaCoZpOE6Y7ghNtJkCgn4fL9sy6oOSun76xgwCo0XfXEBNSdyhYNdfpeZZR8Eio+QrCera7kzileb7xDlOcWABlwXRZjhAqao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730600770; c=relaxed/simple;
	bh=ytS0Oi/jkMsNK/v0Rkrr2hPe6/+C0Cz0ODz1b+kBhtw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DQF4RRcA1D3vRbLzqHAy+pY2toy67m+qmAaWzL8gVI3iWFsyoBUqDGFZ2IPxKPSZrIu0lo8jHCBlnmJ6PiHbDPZz+xFeF92xU9LpD2Bw81cU1HK1L3QCyBWj2ZFPjeuGu+z7axAWK37gqBJw9Bj0y97HgKRSodOdKdwuDgt3/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIfaZYb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF35C4CEC3;
	Sun,  3 Nov 2024 02:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730600770;
	bh=ytS0Oi/jkMsNK/v0Rkrr2hPe6/+C0Cz0ODz1b+kBhtw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mIfaZYb1O3WpX+7F/PgIHt8ns+HGqcrp7jQH/ygcV3l595TeBxY8loAXBINzsKlO5
	 cRpmFuePJD185J0coTxG9IJldTwzkFGncUXMnM5tzO3vLG7ZlRqRUYUP7veH+RY1XV
	 3QWV+IHqiq4vbwGEw78y/BHT4bJSiIkvh1V6TTFEg2dCFHhC6tVRebPlBLHLnQXdAn
	 NyA27h+I6m1dVtqzbyfh5CTu5aoLljoIdXE9x0ZqWh5QJkjb68+gEsJO5Jy0di1Jv+
	 Qijk/+C/oWEuznp+YPjo2x3Yz2uFddO6WUYuBsnfiXTXJcE0lrRA4qW/bxtZjNEKJc
	 3IKB+dsfpFZWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB10738363C3;
	Sun,  3 Nov 2024 02:26:19 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: fixes for 6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <p6nyyqtmlqnkmfkikvughdqbgusnvf2gaohrmkmhbm7x6zccts@vfcbxfefbtzf>
References: <p6nyyqtmlqnkmfkikvughdqbgusnvf2gaohrmkmhbm7x6zccts@vfcbxfefbtzf>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <p6nyyqtmlqnkmfkikvughdqbgusnvf2gaohrmkmhbm7x6zccts@vfcbxfefbtzf>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.12-fixes-6
X-PR-Tracked-Commit-Id: 81a1e1c32ef474c20ccb9f730afe1ac25b1c62a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6a7b4ec74a03cb9ad1fee6b8b6615cc57b927b1
Message-Id: <173060077869.3103663.8854130613832362089.pr-tracker-bot@kernel.org>
Date: Sun, 03 Nov 2024 02:26:18 +0000
To: Carlos Maiolino <cem@kernel.org>
Cc: torvalds@linux-foundation.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 2 Nov 2024 08:37:43 +0100:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.12-fixes-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6a7b4ec74a03cb9ad1fee6b8b6615cc57b927b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

