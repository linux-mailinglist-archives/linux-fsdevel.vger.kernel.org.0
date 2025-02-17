Return-Path: <linux-fsdevel+bounces-41878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC5A38B6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34ED83AFD04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ED2236454;
	Mon, 17 Feb 2025 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOfJATzX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46A423642E;
	Mon, 17 Feb 2025 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739817847; cv=none; b=mHW7sczNzzJ4C25gjU2oel1+MwyHy6Zseqeyt30LKn4+2v48EIPbj+0DQyprh46U82jhBEw+o9yIyIZAqJ4ymkI4vuFdnuccC/lAPpxgXQ5ls61pFARcSrdnt4jvlaUR/LC/LI6+aP5L1/65a7bns4FcgY5bxuZ4BPzE1Uzt5tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739817847; c=relaxed/simple;
	bh=mSmccuNHR8C/aScaAzhI+hf63lrUsdu9RS5dEptGo4g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=blytwHJ/far2FaeTC3c5jLAXB6hfmU/eEIhJfwn68koILsoz5Tlh0oiepUj8pS8BNFjbqwW+Gp++F8ddYVNAxycMwZyG9LlpsvCxKHdhXD3E5I/9rrGSu5GQDT+0VHxPD0dyyYd0mzBRlH9WhpXZzkc8+jlHdGMADNO9nBKD6NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOfJATzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93099C4CEE4;
	Mon, 17 Feb 2025 18:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739817847;
	bh=mSmccuNHR8C/aScaAzhI+hf63lrUsdu9RS5dEptGo4g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mOfJATzX1zbrYPlKboXWGV028UHsz2MsmEBrAPOQuibmXQRZ/VzKkPWUdW7kRvlOp
	 TigSIUW2Gbrl5kAWLGaUeyF6813AOKEzqDqnBDk1mWb9/3xPDas6IuWazCDYsRjNeo
	 LkXq+eCs/JtLfJbeEnhcTDrhRNp7JCOFtINSjNBmY1V3JglfYFcFDSB2X0UikzBW43
	 FjHb6weA/X+1zTWOloAm3a/UTc6UtCFBn3AlHG75+0MqP+ED9Jk8osauO2RCEUohzx
	 OaqJ7yAmUWGg7otaRUzvLISyjsDYfWH3Udnx9zA9+lfH/Kuezp+AEFn9STEmAoir5N
	 LUbbWcSizW82A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFC0380AAD5;
	Mon, 17 Feb 2025 18:44:38 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250217-vfs-fixes-f47d095c551e@brauner>
References: <20250217-vfs-fixes-f47d095c551e@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250217-vfs-fixes-f47d095c551e@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc4.fixes
X-PR-Tracked-Commit-Id: a33f72554adf4552e53af3784cebfc4f2886c396
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2408a807bfc3f738850ef5ad5e3fd59d66168996
Message-Id: <173981787741.3511401.16818036777628983307.pr-tracker-bot@kernel.org>
Date: Mon, 17 Feb 2025 18:44:37 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Feb 2025 11:37:00 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc4.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2408a807bfc3f738850ef5ad5e3fd59d66168996

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

