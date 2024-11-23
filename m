Return-Path: <linux-fsdevel+bounces-35627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 259D19D67C0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 06:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3547C282086
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 05:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4FC1632C8;
	Sat, 23 Nov 2024 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOeqYJXH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB17F4FA;
	Sat, 23 Nov 2024 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732341468; cv=none; b=kicwMG3SOnl2rvWK7rvm52psyWmpc/Re6344bOhsBTuGD0LjBkOMCOX4CrUlCVB+Mc4Ma+9933hjGVnowgLKPyO/KjnLqKW9WojnGmXBjnutV4CR8GwR6l847Ba3GOEXQDnhg0g5/Di4wat7bHbgvWbIyEUgPwuTgm7Ms4OIzzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732341468; c=relaxed/simple;
	bh=NRHe2jp+TN1Rty+esTgEtaccKTDf6UdiI8e8O3LLUbQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j5GVU/qxT+LfvCdrnX4xcydG6P7gT/WQ0xpYtCuwbkNiB+N/v+2A1fad5AQgEk2AGVQ2YuvMRkk1sewDpCsRMWf1oWJ1qv+4ebgHDcIqV2S5HfnEPIt+B/NUhl1wERsuRaBT2Ox3G8v50MWr1pd5N9ef9ce6vyMqygzv1dTAYjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOeqYJXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCAFC4CECD;
	Sat, 23 Nov 2024 05:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732341468;
	bh=NRHe2jp+TN1Rty+esTgEtaccKTDf6UdiI8e8O3LLUbQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vOeqYJXH13fEn29qIjLBeyEomSre6RWYb9cFdtK7OKU3SucJwmpJ34P2gPRJLEyFX
	 lF/8eiImqI2+jjvhV9Sbgmj9M4oDCvg86el0iTxpHSNt+lI9MnWAsfHirwprjVh0xx
	 YhoWIjWE9dqVhOgQOk4NUJkmqgNE921b2djh1swQaxcI4mXmwftQD14hvXYftccyjI
	 PxXjqEevnc+yFg1QqlbnPJ7nSGPdZwp/8POzQ/MT8NUhgfXI3TYJcp22a2IwNF4cQg
	 syiJeVKMvndBywRMCqpgKIXd5ohpvplSa4kNjD/qpgmGDiAtJl4MLnQfBmP8XA+pfm
	 7VBUk291lEtNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 739193809A01;
	Sat, 23 Nov 2024 05:58:01 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs updates for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241122095746.198762-1-amir73il@gmail.com>
References: <20241122095746.198762-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-unionfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241122095746.198762-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.13
X-PR-Tracked-Commit-Id: c8b359dddb418c60df1a69beea01d1b3322bfe83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7675238b9bf4db0b872d5dbcd53efa31914c98f
Message-Id: <173234147994.2919735.1843693888245572239.pr-tracker-bot@kernel.org>
Date: Sat, 23 Nov 2024 05:57:59 +0000
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Nov 2024 10:57:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7675238b9bf4db0b872d5dbcd53efa31914c98f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

