Return-Path: <linux-fsdevel+bounces-63808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2254BCE947
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 23:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB0B4068E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 21:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAACB2EFDA1;
	Fri, 10 Oct 2025 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChOKInRl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4160A2701C0
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760130568; cv=none; b=Qt41BUNTjEDxACh6+j/kaEL/8jkTmaVBCC+UOL7FFVZX/73PqpymH49bB4guvrx/qweNTEv/Oy8FaZ5PJAA0fnJ7N+6mrEleZTUxdf9N9TM+FmSmYNrn60dURmVTg9Wp2YGnreohhLlFjTf4n7XlOO7fIorNai93yIsGoAMkG1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760130568; c=relaxed/simple;
	bh=myWb5NwLbtdeKkWljX5is7u8h3GoyBt1mkbbUX0h/Rc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BnVRZ7b5dBFrMTUzvDEjldVbI8wNbUouq3XMrmPZIOyd4s2MABng6gULOVX0Sj6VqrZGM4No3VD5RPQbUh96xtjh27zeL+FioaMptnca35ZeaXJvMfqYU8LCykW2efH+jx/7rWVVxH3+BcV2wrCARps74x/I8OsCL7FUdgEwqvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChOKInRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C533C4CEF1;
	Fri, 10 Oct 2025 21:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760130568;
	bh=myWb5NwLbtdeKkWljX5is7u8h3GoyBt1mkbbUX0h/Rc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ChOKInRltWBo/KOoHjSxFnvtBD2jfoIL1HuUzIQNnbW4jAuJhaJQBwlw7yVCD5NvS
	 zNzZUxu+7DEPqh0PRk1DYopYjh/2K2VgDB34ZPkGZcRuDeyVJUPKSF8EKxfrtMcUQD
	 ijcynNqTRf1PiwFGifrBBpaZ4uM4iiUZH/FyQ5+utfThjhio5en3mbzOtbRjTo2lU3
	 DKG7twinqPVpZBu2o4XIEUskUoYy+ZTQS7pZ/dV6GoIdCuAQ815C6NYdanAwyg6zs1
	 YLins4Ws34NQ562soyeFc6AB0MeO26A5/Xzd80L7pM2iqR3KdMVVspPDU3Bq2VnHLe
	 TE5PxCTNzqvag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1363809A07;
	Fri, 10 Oct 2025 21:09:16 +0000 (UTC)
Subject: Re: [git pull] HPFS changes for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <fc8d9173-2586-cb80-b70a-bba7c8be02f5@redhat.com>
References: <fc8d9173-2586-cb80-b70a-bba7c8be02f5@redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <fc8d9173-2586-cb80-b70a-bba7c8be02f5@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.18/hpfs-changes
X-PR-Tracked-Commit-Id: 32058c38d3b79a28963a59ac0353644dc24775cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0739473694c4878513031006829f1030ec850bc2
Message-Id: <176013055534.1128757.13346285919132812042.pr-tracker-bot@kernel.org>
Date: Fri, 10 Oct 2025 21:09:15 +0000
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Su Hui <suhui@nfschina.com>, Yikang Yue <yikangy2@illinois.edu>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Oct 2025 22:12:43 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.18/hpfs-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0739473694c4878513031006829f1030ec850bc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

