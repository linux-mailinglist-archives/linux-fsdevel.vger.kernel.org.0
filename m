Return-Path: <linux-fsdevel+bounces-42741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33E3A4731F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 03:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4341F1689B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 02:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6191185B67;
	Thu, 27 Feb 2025 02:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeAuOiFJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074694D8CE;
	Thu, 27 Feb 2025 02:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740623888; cv=none; b=TNg5cX1OFdz89R19JWwKe49Xg8pV79ZLLLTSWmwVkF/G4+Aotmf0Okql9acmagO5o/WFQh4/74U7SGejpqOzDtmdCPFSuTZgR+X04Db1OZREhfFZGc1F5mJwehwGlnRRVwna1/mxW/e8oto7mKBujZ9N7QApv3v7eZgENOjjq7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740623888; c=relaxed/simple;
	bh=wLYa2pg2xgpSQLEhqd7PfX3Zk0jSNxTC86w8kFP+0/I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XxFQ+Eq0+i20CfdBKSJkCr3MjpDAZRkYsbYi3keRxpH/Mg5iQJ9z6C0S6BhQHpoTamIyIbEhpr6OODX2j2+zDjjb5g+WX1Z+zDh+vMqbF/fmGjVGvz+l2zsVVq9v4FdoI/aDAqEjo6unANdFbNYeFEohkaWF27Oj519hsku+sfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeAuOiFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808DBC4CEE2;
	Thu, 27 Feb 2025 02:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740623887;
	bh=wLYa2pg2xgpSQLEhqd7PfX3Zk0jSNxTC86w8kFP+0/I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IeAuOiFJNnHTvc9JnpSm8c4CU2r0KPQ1K2xgWuF+i4mou1Lh7/4u57nVl3RsX7liy
	 N00Uyci8e/Azf5LMLYRDmR9ADjQ+siZZcTNU7LuxVil2qijZdYcyg2ISfVraRbi70P
	 ymH+lF6xRVCP9+GhwNSOjhm6eVvhC1DiB6lvmz3fTLOb6bYBkHFR0fKenEbTQD4KzD
	 kwJl3SInYOIDMUh8u4mrGvRVBOzHABPidnXSFT9N8mL5npsCKrlA/wb6ItzgEXEL3q
	 8ntEdFb2WmodSezsuMeE87IwjTifPc0Dr9OLCQZ0eWmuBBlqD6F3HHTO+s+PxI0piz
	 m8GycKtfKlb3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDD0380CFF3;
	Thu, 27 Feb 2025 02:38:40 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.14-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <6xhke7esvj47xpl6ylxtcz5b2ol2ckwup2q3yunjo6zudthrtm@emmsdk3bpusy>
References: <6xhke7esvj47xpl6ylxtcz5b2ol2ckwup2q3yunjo6zudthrtm@emmsdk3bpusy>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6xhke7esvj47xpl6ylxtcz5b2ol2ckwup2q3yunjo6zudthrtm@emmsdk3bpusy>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-02-26
X-PR-Tracked-Commit-Id: eb54d2695b57426638fed0ec066ae17a18c4426c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd83757f6e686a2188997cb58b5975f744bb7786
Message-Id: <174062391933.945292.16255864063787403914.pr-tracker-bot@kernel.org>
Date: Thu, 27 Feb 2025 02:38:39 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Feb 2025 19:37:26 -0500:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-02-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd83757f6e686a2188997cb58b5975f744bb7786

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

