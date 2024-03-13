Return-Path: <linux-fsdevel+bounces-14364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C7187B3C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 22:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6171F23FB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 21:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE24D59175;
	Wed, 13 Mar 2024 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF2saW8s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B70F5787D;
	Wed, 13 Mar 2024 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366448; cv=none; b=O6p5A9uEvLASbvoRZHxiYRU16fifO62PEUZxwmyVqiwGFGHYZCRhclWDd0fH2tOsrqV01HMkqDSK9JpuS3IlorFIIkztBHHwORSfpgzlnzhoOvxS05h41l/sfJ3jyJpQyfmKnpMigX5uHrUztVAWrd/R7kV/h0E/buj6AQLyDFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366448; c=relaxed/simple;
	bh=KxBto5SAi7PJwerFuYXB7e7F+78Zd/jtqG8kqQnCqU0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZsI1gTSbQQDXosjLLx2ndR42yJurkU1cbjDLNADkjZ6TqUCANc01J4deb/lqwM5pRxDVVePSAab6a1eygTd4+awmbKjTbkLHrMykXUVO/+ayfY13NFGfXPNSeIgYvHchB8M+K8TPyNASnXN3XwJE1ijDfvqkvTIsvFbMLtyzPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF2saW8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05305C43390;
	Wed, 13 Mar 2024 21:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710366448;
	bh=KxBto5SAi7PJwerFuYXB7e7F+78Zd/jtqG8kqQnCqU0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mF2saW8sdxjRfxlojD/n8cTtVeAghF55FpMh3cPK7B228u9zMAbTQjfiDtwH0Y2Oq
	 Vl+tht9NawHB2IeN+vvYnAZd6g741QpTypAVafZIN0LySVIX8BmqzqcIMEheMttRzE
	 kNsFlr7HAFgrx9pekok53I9wqSciaTueTMLQo9Rlut1cCO04bqPU5cjWT/7pwWbmcD
	 MNvX6NCG95kaHdIQm/+OvmFjn/FPh7q44uTNiF3whDTLsEru+w3OHjs7l9GrnHpBGr
	 8tr2uYO/MY3RhneY9iCLHD3dSFCLuwp9+aT6O748bublwi91fxG+agJdHd+1BAXby3
	 z89cpOFXifFcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB17AD9505F;
	Wed, 13 Mar 2024 21:47:27 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <87sf0uhdh2.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87sf0uhdh2.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sf0uhdh2.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.9-merge-8
X-PR-Tracked-Commit-Id: 75bcffbb9e7563259b7aed0fa77459d6a3a35627
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: babbcc02327a14a352a7899dc603eaa064559c75
Message-Id: <171036644789.31875.4819322888155935557.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 21:47:27 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, akiyks@gmail.com, cmaiolino@redhat.com, corbet@lwn.net, dan.carpenter@linaro.org, dchinner@redhat.com, djwong@kernel.org, hch@lst.de, hsiangkao@linux.alibaba.com, hughd@google.com, kch@nvidia.com, kent.overstreet@linux.dev, leo.lilong@huawei.com, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, longman@redhat.com, mchehab@kernel.org, peterz@infradead.org, sfr@canb.auug.org.au, sshegde@linux.ibm.com, willy@infradead.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 11:21:46 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.9-merge-8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/babbcc02327a14a352a7899dc603eaa064559c75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

