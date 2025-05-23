Return-Path: <linux-fsdevel+bounces-49779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E82DAC25B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 16:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7688C54652B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0A6296D1A;
	Fri, 23 May 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRlCoqPn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EC3295DAF;
	Fri, 23 May 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012142; cv=none; b=gAtA1vPQH4DuVnt/uiSb5QX5bQxXWyhvglDcODALNOZQGuGjvUA1Mt8iASsDqpYTh2B4JFIthK8JDwLFbQC7FtXZ9gVR/6xwwYpQOzF1+mFXGLvH6py++I6+ds4oRlnQQDwZlNA1Whbe6ju6PKYZFmRGcWgKtJ7/OHyMFlsmCsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012142; c=relaxed/simple;
	bh=Ocxt4qmtcW74dH2GxERUGGUuxKehM6jSfH1rDHNoVoY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Sds3cxdBEpNA0Cw2iXjieJPLYCjwcZtLh7Idab46VdjhDYdmCjTmJJ765r+LNAeSqDMoZeiiaDCZA72uc323QuRS5F9GMYMVB3VmPb6Y9tny5q3pESdk9/GI/b7InTshb3EKOMH0rI4YM5aKidkJ4NyI6RV11Laht0Jxh3qPoAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRlCoqPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB544C4CEE9;
	Fri, 23 May 2025 14:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748012142;
	bh=Ocxt4qmtcW74dH2GxERUGGUuxKehM6jSfH1rDHNoVoY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GRlCoqPn2xMUjKJmuify8yEjLkk4KWKkNPlVFoN5Gkj9R53hmBfn8J2TRt4VKA5wi
	 1YBa0vmJep69ry5MpT3NS9H3N1v69bmiwiZIOUZS5qodzL9lafoT4IODwCq+STv+ZG
	 Lr5uDs4BNG5YH7JwOddv3oJD39dXglVzrH7Cesq2KnEcOMGXQarmFhae4jbEvEoWT8
	 PvDYRU+MVr+td3SXbA2+KFuZJfomoHgu5qVTv+uPzc8dD4f7AWRSeF3v88oDrkDv20
	 fUQonoiMpzzj9/GGa8TWRkurCcYinA+e8RB2n2TXHjgQjI8TDLvBWXVGTjGfabWige
	 8K8Gz2Pjq4XLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7110C3810902;
	Fri, 23 May 2025 14:56:18 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <t4kz463dyrlych7ags2fczrgeyafkkjdppe2zmk7zxdmvdywmb@cs2b2txhexje>
References: <t4kz463dyrlych7ags2fczrgeyafkkjdppe2zmk7zxdmvdywmb@cs2b2txhexje>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <t4kz463dyrlych7ags2fczrgeyafkkjdppe2zmk7zxdmvdywmb@cs2b2txhexje>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-05-22
X-PR-Tracked-Commit-Id: 010c89468134d1991b87122379f86feae23d512f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 040c0f6a187162f082578b431b5919856c3df820
Message-Id: <174801217714.3623503.15407751522612775095.pr-tracker-bot@kernel.org>
Date: Fri, 23 May 2025 14:56:17 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 22 May 2025 21:31:58 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-05-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/040c0f6a187162f082578b431b5919856c3df820

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

