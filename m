Return-Path: <linux-fsdevel+bounces-16738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B74608A1F31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 21:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46BBC288222
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 19:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2D9224F2;
	Thu, 11 Apr 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbVyUwzX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08601863C;
	Thu, 11 Apr 2024 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862563; cv=none; b=BfbfrSuKJvIdfTK1SNfsLEAhFvDP5A7xfy8+kTUF2vOI7ZMHrgke9GRbQsJMbI4BdOq4hHF1AGJso/ovALn3yfHNpPHerOPtL5hW6nZMVZtzRClkA+IF+nLGUAmHW0GszX/FcdmTClDg0bYXgIB4mfxJ14Pm5MKABKAILd5eO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862563; c=relaxed/simple;
	bh=W8FgOcWxkM15ZcMp7FGGpwxJMzY0bc1/TiqOakuXieQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Tm4fD+ckUpw/PQWaVX5aWRIjAzZPT28oPKWZGlcvKkYNRia0hdE+UpO4R0HH19EMwDqRERyMpC/gxY2uOwNRX9771DAjYAFhuKVlAfCjyWA74lk3WBmxsErNNSKVRPgIxu73Xw10m7qGT3yba3jrFdxs3XX4V4LNG5cxyMfRd00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbVyUwzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B36FBC113CE;
	Thu, 11 Apr 2024 19:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712862563;
	bh=W8FgOcWxkM15ZcMp7FGGpwxJMzY0bc1/TiqOakuXieQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NbVyUwzXDcdnCF7z0lwe9eYXyxagx5jEyz1POlIhDVfilFLXDFau1M+1OiKC5Qo8y
	 qpmn72Ur0+CxPnSm6hsfflrsTnthmRw/KAdeLGAPkTYyrJqdDzhLmegmFX6O6mc429
	 J25cGXeeusPVQiQ0LUT0XrcWIiKGEbFCeTb1Qg5rl6Yhc5fFJkGUOentUWPSQlX0ID
	 t0AZfy0QjGu4P5R5rvRY1M3mO2V57udJeFO2zWCsDilzxvOEK/GoFKdxl+grZk42Pc
	 +WLEKy2fSupZVuqa/uvZIcDZEkthansM0rRiIFo8WvDXsZZx27c1CB+1HnPCruLSlQ
	 ThGa9ydHEMRmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A91CDC433F2;
	Thu, 11 Apr 2024 19:09:23 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <woux55cy6ms6exoa43hg745ftfo6msc3bsnjge3te2c4pvdzmf@57wrbdc5pp7s>
References: <woux55cy6ms6exoa43hg745ftfo6msc3bsnjge3te2c4pvdzmf@57wrbdc5pp7s>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <woux55cy6ms6exoa43hg745ftfo6msc3bsnjge3te2c4pvdzmf@57wrbdc5pp7s>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-04-10
X-PR-Tracked-Commit-Id: 1189bdda6c991cbf9342d84410042dd5f3a792e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1dc191dbf3f35cf07790b52110267bef55515a2
Message-Id: <171286256368.2172.14990565631104148859.pr-tracker-bot@kernel.org>
Date: Thu, 11 Apr 2024 19:09:23 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Apr 2024 22:54:27 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-04-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1dc191dbf3f35cf07790b52110267bef55515a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

