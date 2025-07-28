Return-Path: <linux-fsdevel+bounces-56218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3340B144F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D897F16F432
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E311F289E16;
	Mon, 28 Jul 2025 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2JcFcmy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4445228982A;
	Mon, 28 Jul 2025 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746057; cv=none; b=TZ6z+LxJkR+U+0PFvMVG/vpp5tMVb/4a+nBpjKqDala+VrmaEbFTB+j/GongLA4wYJyu/dgPNLvsBZWm3zrwMaGoDY5wQSGpy77PHLllLMScC79U1/5UzZM+2RzuLJhUEczHWbo+ytmHIkAm7VnGZmsUyxMy+EbHyjYxBQb+AIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746057; c=relaxed/simple;
	bh=qgPlBvsBseyDSfVNg+FNcpU3zUkou+VPtOHpmoMWFa0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KlugaKrHnNhqd/0RrpPUXTSE2W0e4CHSiiNtiE2z3qoPUgFp+otGoIhbWHf4br/KPL3SZyNzoHF97Xn3VVVMSAA+LgEy58I8NLzcLRrO/qAGBH2SuO2GDXk2CScYzUS4+DND0au49VGEuOtLHj3Oq6ANNC+LN90Fi0VmVeOLDy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2JcFcmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28168C4CEF7;
	Mon, 28 Jul 2025 23:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746057;
	bh=qgPlBvsBseyDSfVNg+FNcpU3zUkou+VPtOHpmoMWFa0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W2JcFcmySXr2G1erGQDueuhMVSmMYlzNb+sCQ8A0k43cackLT0RimJ5icX/7SH0qA
	 FdJbJui8T9jA9z5HA3sllV/BXa9JXsZqb7p50QUp7OMvkSW70ymbAaz0ZmPC+2I6k9
	 zXZUfT+ePs/UcPKGESqqx3norr2a4vIMmWPRuGuhuoJYWXb7FdjZ9orBRfZ9Nc2ZDx
	 zE6wG3OXNT883qbdv/xzWJERrNeSofEI8UOHa8+UbvAvmnxASujcuaqEXB4I7yi1OZ
	 I+Qco3LVW944pLASljWTETpl7fhZAHgE6gUgLnW28UeFNqAyveeLxfcBY4HxKPP4Eg
	 6qPiQCnDLSW6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBD89383BF61;
	Mon, 28 Jul 2025 23:41:14 +0000 (UTC)
Subject: Re: [GIT PULL] hfs/hfsplus changes for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <a557f6d129ea4cb7ab1d1ed2232bfa811810abe2.camel@dubeyko.com>
References: <a557f6d129ea4cb7ab1d1ed2232bfa811810abe2.camel@dubeyko.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a557f6d129ea4cb7ab1d1ed2232bfa811810abe2.camel@dubeyko.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git tags/hfs-v6.17-tag1
X-PR-Tracked-Commit-Id: 736a0516a16268995f4898eded49bfef077af709
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb6bbff7e6fb263dd739514b3f5dfdcd8eaa9836
Message-Id: <175374607391.885311.14023767960983691774.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:41:13 +0000
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, johannes.thumshirn@wdc.com, penguin-kernel@I-love.SAKURA.ne.jp
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 11:43:32 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git tags/hfs-v6.17-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb6bbff7e6fb263dd739514b3f5dfdcd8eaa9836

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

