Return-Path: <linux-fsdevel+bounces-47404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F201A9D019
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 20:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B01467D17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACCC2153C8;
	Fri, 25 Apr 2025 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9oZHC/f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E22F4437C;
	Fri, 25 Apr 2025 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604060; cv=none; b=O8I76OOBydZbV90OVd8sjLWOUs3uS7iIuSqDAzsvhiexvsg//8HezK1iLd0kHhwYLfYLn0puA20NR64tccJxExqKtxGqoqy1edgUikYaFPE66LAipjEihmqz/TG5Er0caoFYYK2EVNxqdHIu3AFlIvKDssmm6yhaOxaNJKKDe3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604060; c=relaxed/simple;
	bh=vcI8WNUoad1hd0OM0OQ67ho5I37txZfaD4ZXeXCfvgc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Qsbvv35zRmvotfsojacXJyVWAngNISrO75uWzjVx6i3NTmpApBjqPyCiJiVft3XuE1V+v85BHMS2mopY9qaxbagmvgRDr7PMrWgo1wL1z/mSPv5pJf6jNGcrq5lvx7XUUeD+EpATaExpqGF0eGXr02k+h/pjFTtpX8VgucpP6M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9oZHC/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E595C4CEE9;
	Fri, 25 Apr 2025 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745604060;
	bh=vcI8WNUoad1hd0OM0OQ67ho5I37txZfaD4ZXeXCfvgc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V9oZHC/f1sALYonUBSvQA+qlBABpnhGF57d9D2Kmi4E1TglDBFAtO0C6arx54kiIk
	 kXZ5pzCZxQ3pItkuPUQyXw78CZ23i7GR5BaabqAytIeXM51LQnA0RTvJlW0ToCNQLn
	 4aZyKLjU0ETgC+ozak825z6Y+f1oqi2/4E1WiKDbBXdK6e3lBDV9psZpw5+Yc2UJig
	 JzFUgETzLnsqKKnudwtSxa+mZS/U/kjin9JmjclvaUiUQOZJRemziVbijC3LFUA3Hs
	 bUtpsiqzmsGSDmf6cQLmmndoKG8Bw0+f0cLCfc8ZcrsiDFF6cGnThBK2SnPvEIhVRs
	 kOpFkVb4pqLhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714AB380CFD7;
	Fri, 25 Apr 2025 18:01:40 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-04-24
X-PR-Tracked-Commit-Id: d1b0f9aa73fe50ee5276708e33d77c4e7054e555
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eef0dc0bd432885b2bd4fc7f410ed039bf028e37
Message-Id: <174560409892.3790119.15347620053687223498.pr-tracker-bot@kernel.org>
Date: Fri, 25 Apr 2025 18:01:38 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Apr 2025 22:46:40 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-04-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eef0dc0bd432885b2bd4fc7f410ed039bf028e37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

