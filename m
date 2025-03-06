Return-Path: <linux-fsdevel+bounces-43387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814A2A55B42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 00:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7E33B4444
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 23:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEC3280A45;
	Thu,  6 Mar 2025 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLqE2exo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9AD280A28;
	Thu,  6 Mar 2025 23:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741305527; cv=none; b=qupNmLOfw0JGGC48BMgSowsqJ1nZzCFVODUJESyyiN/PkLg5OVaNm2Hil3XTDUgL2D1JARxwuj+NlBpbjW/DdBLxMJBuuJg9ICelBftOXVwHUEoQzHCgEkhax+mxcBnISLhPYDm/KMWp89MMZzQGFCui237hhIAf9ZjA3SaRUm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741305527; c=relaxed/simple;
	bh=moVc7pOtCwnKINiMtA5zpBx/8SyTaAtBgLkPgetKskg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LXJ2W7lhhB4JAJNijfKo6TscXB9u7JquyGIOOZ8XJQZt743jtiuS2liHnWE8L7KldI8kPoL0nRAa/WUfOzH3jyC9rPN0eNXi8yNdXBu/5eWrVL1PYX/AA+Jv9wEFlsJy20qN/hqcH1+qso1ClIuIiE4xMFD+fQV74GFiHkuLBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLqE2exo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB5BC4CEE9;
	Thu,  6 Mar 2025 23:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741305526;
	bh=moVc7pOtCwnKINiMtA5zpBx/8SyTaAtBgLkPgetKskg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GLqE2exowz+k/gMCk8N7WoEaAkfr0mATl3HdoyAVkkVMQ7Ro3ubl/0kuO1PN4Tsdb
	 BmwESwMX+lWlRMuSXmIvX3CgOOD5H0452oGPuCsJaHJpnvlbQqK1vTZuHtCKVKBfsc
	 YaB61OPN9wGinNjp/e9wClhfBC15Pxn5zXx0xfFOGw5ATyccrfqlOfTxmgMqP+tslO
	 VoPjtod19TI2Z54Uh+a5QN4JlxeSB5J+XpjQv/Svb88qgAgRDtOUH7v0aCFPgrWINv
	 8yXjmN3NxGBwnjxh7xdFzS9lExQHwyjUIzRErPBeURCCYLYen8lPbRthRQyH/EOikl
	 2wknMpmBphZfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F7F380CFF6;
	Thu,  6 Mar 2025 23:59:21 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.14-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ww7iqi2mto3fvyhrgpyxcdzcndcr527evvzktb5xp56o32lwg4@zlvkrwuiki6i>
References: <ww7iqi2mto3fvyhrgpyxcdzcndcr527evvzktb5xp56o32lwg4@zlvkrwuiki6i>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ww7iqi2mto3fvyhrgpyxcdzcndcr527evvzktb5xp56o32lwg4@zlvkrwuiki6i>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-03-06
X-PR-Tracked-Commit-Id: 8ba73f53dc5b7545776e09e6982115dcbcbabec4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f52fd4f67c67f7f2ea3063c627e466255f027fd
Message-Id: <174130556008.1823246.13013665258720328821.pr-tracker-bot@kernel.org>
Date: Thu, 06 Mar 2025 23:59:20 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 6 Mar 2025 18:25:30 -0500:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-03-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f52fd4f67c67f7f2ea3063c627e466255f027fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

