Return-Path: <linux-fsdevel+bounces-30924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5982598FB7B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 02:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADE41C221BB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 00:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83E31D5AB6;
	Fri,  4 Oct 2024 00:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDY3AlUh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5555ADDA1
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 00:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728001355; cv=none; b=ZYxfmbZO+xBmZ+GnWMHg1vTvt5P+xj7YdLE61BvLgSM7gd4nsDQj0uiZ3vvKnFtAiy2OWi7X6ae97mbo2K4TT1pWkgRdGdlR4EQ9uNVOHvSzDd66MJTg60o5M4/ektJGB2BSi4BG37RrNuS/lTm7ZhSxtZ8Mz9vm1rihn4yIqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728001355; c=relaxed/simple;
	bh=BVEx2A8sSmkQcqZGU5ltmLMtJRDhjap6aQTiDE75E3s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WcVZvMZx/pPXf1erYWJT33kzyqpoVx1bceMtg3lbykVN1nNT75K9LP2ToAcKTmDTn6vn4wG5iMKnXEEvwfwgiClW0FR2po5HX0+Aje2q4Eq0aiX734K//+XuWUK1Y9zRs4ypPp/ri4ONQtd5oZbXQF/FLP7qVFSqZdh8yBmhOZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDY3AlUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355EBC4CEC5;
	Fri,  4 Oct 2024 00:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728001355;
	bh=BVEx2A8sSmkQcqZGU5ltmLMtJRDhjap6aQTiDE75E3s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UDY3AlUhAHiSSJhFJSMV8eriFcRe95WtU6pAP/2FVrVl9dCf5OEP5WX5PJTNfeP5i
	 wMqbKZ3hGqR4l4UJtjiRKp5kidA4oHMCj+U374IIz9kpek12772RAbFRLycsHggmVU
	 KYUawhDqYYZcTz9AJM9DALtlSYSFIn0KdwFx10A1CbAEa8PZMASCjgXlU6p8ZY5S7n
	 pkyTSbB4O2arkNfuSeVM7ToDjVVRqH3XIXDygKRP9aC6JwgCrljcDaKlA+Z2K22qH5
	 6D5dXzMg8svg/aexM2mRAS2I8yPhXkRq7AyjYWF/SLbpU2h3sIGAKQlIplSdWxfarf
	 l9v4C411LHE2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DCE8C3803263;
	Fri,  4 Oct 2024 00:22:39 +0000 (UTC)
Subject: Re: [git pull] ufs regression fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241003235912.GN4017910@ZenIV>
References: <20241003235912.GN4017910@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241003235912.GN4017910@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes.ufs
X-PR-Tracked-Commit-Id: 0d0b8646a66de7f3bf345106f2034a2268799d67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 263a25de5b6002da3b27bc33a36c51ecfc086b35
Message-Id: <172800135861.2042091.15538726837539756273.pr-tracker-bot@kernel.org>
Date: Fri, 04 Oct 2024 00:22:38 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 4 Oct 2024 00:59:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes.ufs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/263a25de5b6002da3b27bc33a36c51ecfc086b35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

