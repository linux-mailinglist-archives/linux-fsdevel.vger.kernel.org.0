Return-Path: <linux-fsdevel+bounces-38902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0D0A0991E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 19:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD3B57A435C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 18:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F24213E98;
	Fri, 10 Jan 2025 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bsxvu80G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E742066E0;
	Fri, 10 Jan 2025 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736532729; cv=none; b=Qta0wYm4QJRiKuQ8Pya1rdhuJM7oYGrS7UVt9yBkCeKxl8w1zZH3MjDRqtfkYuHWCjNxtbUDitdCM3xOrs9iuWi//Za+vFFsrm3ybWtrdfX3USz8OVeAiafFYkb4P/GeqWtn/RTPCtIwrMl839xTQuBfMV/CJSAwcUzgOosHWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736532729; c=relaxed/simple;
	bh=NX2zmTv/CufC+ONBx3D14ngOMZBQHYTRwkEYIT0QawY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lLl7whDnDzCEon3LLCtBsGUI1jp4LOaV/bpVj6tU/bmj0u6UbC3DWZY1OWo4lh3NP/P3IcS4Uq1xFNVu6J9N0SHLXIGRvOFkCz8/vF2Vihgnkbz5xF5wn4xApVcPHGFwp/zkJ6xfpCocmhzUGZXa6dZUTRv52hrc61YQ9TR6voc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bsxvu80G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48223C4CED6;
	Fri, 10 Jan 2025 18:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736532729;
	bh=NX2zmTv/CufC+ONBx3D14ngOMZBQHYTRwkEYIT0QawY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Bsxvu80GSbatwbN7TmyB3xquLlJeKCiJtCB8+IAWTvlsYXU6gV2SRAR1oMoOqA0ZU
	 RazRsGi/c7vPBmUazBaSNLWfRjk4/LFSrlTASRm2espbI0tIH5AMuiK5eZxguuMt+3
	 +sHcUfR4eLJyo9XqFLMsUra0P2ybhn+/iLWGWuJhmlNRPkKk4GjFl/elCSyGb23wMJ
	 xiPyrecxdDjiGN/YtDBzH61fP0Vtc3fwI+/6BmuuE8ip+uZrypr/GXH9fGOjokVfOI
	 aFqX5rQtxu9ccha/AazN/D4r8E1yUsJ8kB98ynLKGjquLS+hYNcjD5o3+N8bwuPJw3
	 CqySceXkIBjDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7122D380AA54;
	Fri, 10 Jan 2025 18:12:32 +0000 (UTC)
Subject: Re: [GIT PULL] XFS fixes for 6.13-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <fsn2arw4xjoozcqqrf7l56fmxn5r54ytkcv3rqjrwr74arrm7e@2a67uibjsdm4>
References: <fsn2arw4xjoozcqqrf7l56fmxn5r54ytkcv3rqjrwr74arrm7e@2a67uibjsdm4>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <fsn2arw4xjoozcqqrf7l56fmxn5r54ytkcv3rqjrwr74arrm7e@2a67uibjsdm4>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-fixes-6.13-rc7
X-PR-Tracked-Commit-Id: 111d36d6278756128b7d7fab787fdcbf8221cd98
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36eb21945a19d82c5b4bb1e995ca798104cb85ec
Message-Id: <173653275098.2158138.11261946214905004416.pr-tracker-bot@kernel.org>
Date: Fri, 10 Jan 2025 18:12:30 +0000
To: Carlos Maiolino <cem@kernel.org>
Cc: torvalds@linux-foundation.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Jan 2025 10:51:27 +0100:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-fixes-6.13-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36eb21945a19d82c5b4bb1e995ca798104cb85ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

