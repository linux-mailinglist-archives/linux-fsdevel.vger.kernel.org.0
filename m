Return-Path: <linux-fsdevel+bounces-43988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8111A60714
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 02:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0B516346C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 01:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052701F957;
	Fri, 14 Mar 2025 01:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tl/lhG52"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527B42E336C;
	Fri, 14 Mar 2025 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741916290; cv=none; b=Bm8RWXUzKef/bZIET4MK8cbAOJ7wdZB6XnZJASZyhu+L6VPT+mg1ga8q1heAdQXx6N1B07to0nkPresykAjNIL1N8ul6StibrazN2HscYMfjOcJM+32x3l2Dhv+dA50NZ4+e/kzFZMNq7PGWtPStzF/afz/0Gflom+yEQzpu+Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741916290; c=relaxed/simple;
	bh=v7zvDlgRx2sfNhAiFBb5W2ZUm46c/FpEEaft0pQ9tro=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sWwILZqogVyvHg1HvB83DdBhhWx2A1/0dUAaBfuzbgJ+mCI3PewoXeDMR4QSktY5qwhh5N+G1Ba8eS3QvZAREJXRfCsoa9vkxD7UDYj1+2aJhCOP51aipHOI7YDnQA4UrW+5RRa0Wrcx0SPp59T+lsE9K1QFf96+ssHlHNM2CaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tl/lhG52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3BEC4CEDD;
	Fri, 14 Mar 2025 01:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741916289;
	bh=v7zvDlgRx2sfNhAiFBb5W2ZUm46c/FpEEaft0pQ9tro=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tl/lhG524RlQuH1MOqm2ov3Y+7nAuf9kCb5m0F174MEBTd3/Z+UYFDvWL+lI10WzM
	 ZBWt9OCc68mg6Wc0b9EMLlnRZOCxUlO3LS4EKxk2tqn/kwrv3cU/m76sPqPOVwQwpR
	 rlKaHBMjSLff204lV78HxWcgjO70wsTSXVeeqOdCUqt6GdguX7mvqHT5UVMe+VCLG2
	 dT2bLAsanaOjkqZUqhtu2O//Jpyt4RV0EQ5Sj9+W4weCb/sePUW29I7lch1d5W7We4
	 Rysk4HvzGm2OR12hnK+vMoBuFDkZeMT6NBzg9LfLL+/NX9kTJSaJKTckRQk/ab40Kf
	 n3hFiCbOH3v4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEE23806651;
	Fri, 14 Mar 2025 01:38:45 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.14-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <de7fintuxlgh7wteymuo4oproofqngifpul6gq5f66p4b7qih3@5q34khdi2ikv>
References: <de7fintuxlgh7wteymuo4oproofqngifpul6gq5f66p4b7qih3@5q34khdi2ikv>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <de7fintuxlgh7wteymuo4oproofqngifpul6gq5f66p4b7qih3@5q34khdi2ikv>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-03-13
X-PR-Tracked-Commit-Id: 9c18ea7ffee090b47afaa7dc41903fb1b436d7bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 131c040bbb0f561ef68ad2ba6fcd28c97fa6d4cf
Message-Id: <174191632441.1722086.11557226538495304115.pr-tracker-bot@kernel.org>
Date: Fri, 14 Mar 2025 01:38:44 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Mar 2025 18:45:30 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-03-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/131c040bbb0f561ef68ad2ba6fcd28c97fa6d4cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

