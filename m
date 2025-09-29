Return-Path: <linux-fsdevel+bounces-63061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D03AABAABF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 01:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93EB617838D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 23:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C57B27E049;
	Mon, 29 Sep 2025 23:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8gvkscx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C5427BF7C;
	Mon, 29 Sep 2025 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188169; cv=none; b=uoq4/yARjHSDApDOquNMP1gXBB9olBBE4nVo/mk/vZat6gVIzj0MwXqSFHu5NGAe9B40guX19e+9SX4p7nYG+TZgKXT4m0pqckBEFUtuhmCqimfAiI/xGrgN2WbxkDFimHg7+HyapJDnDn3NRGDEDXraHRwXAjoPJDbqsQycE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188169; c=relaxed/simple;
	bh=pt+AcjHx1iHwgOQNT8aDmhz7DK44pCRHQnqSYZGkh6Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lTNXRuOnsOtmIa4AMYaMiD+hYvashVniWa/gIt5jM9eLWbVDGtMTYkQV+bBpPcx5XfJCWEVskcjQ5hyYNdN4HMeDWDE3ZhCwPOKmJcjMiD7sDscWg+7v4EwZ82yIQv0Iu691jib5RYxLMRBK7hOH+qiBcr9BfDrUherE/JAFqCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8gvkscx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D0EC4CEF4;
	Mon, 29 Sep 2025 23:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759188168;
	bh=pt+AcjHx1iHwgOQNT8aDmhz7DK44pCRHQnqSYZGkh6Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I8gvkscxlWPCsuYhO1Ulks24QU9TpZh7eaZAi0poKOFPSaBkNskbd2K2BP1PRf3zK
	 kb2+y91SKnd2K8WOU40A+t592rh4Dw3dBykWSSfwzmvFnjHs6ZG5+45Ce2tBK6AhhS
	 yfEx3/75qACK+x1y/pDj5A73IQIXzQkpplUsDjCdd0YMo44Esg/ijl93F5LYpK4mEJ
	 BGkBry0nQrxwr8sXJXlILDyfnrc+9WXhTDhv9T0E7MlvZw6nGfcejn+ZLks1+U7nNo
	 VpQWf6a+c5muq5k2DVua1nhASVjY5PlpG864xx8CgURH4LoG6FWr3J09tOCUnPPgnc
	 ubEJks1+Joz9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D4B39D0C1A;
	Mon, 29 Sep 2025 23:22:43 +0000 (UTC)
Subject: Re: [GIT PULL] hfs/hfsplus changes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <5d45d2ba2504ca365ac36c65cbcc6db413bf7e98.camel@dubeyko.com>
References: <5d45d2ba2504ca365ac36c65cbcc6db413bf7e98.camel@dubeyko.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5d45d2ba2504ca365ac36c65cbcc6db413bf7e98.camel@dubeyko.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git tags/hfs-v6.18-tag1
X-PR-Tracked-Commit-Id: f32a26fab3672e60f622bd7461bf978fc72f29ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3e1c7855e8e1c4d77685ce4a8cd9cdd576058eb
Message-Id: <175918816208.1748288.12185551865918583191.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 23:22:42 +0000
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, Chenzhi Yang <yang.chenzhi@vivo.com>, Kang Chen <k.chen@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Sep 2025 15:53:45 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git tags/hfs-v6.18-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3e1c7855e8e1c4d77685ce4a8cd9cdd576058eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

