Return-Path: <linux-fsdevel+bounces-45407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C1EA7727C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 04:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC83188E2E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 02:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9C21A2390;
	Tue,  1 Apr 2025 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxiYTC/o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C370820;
	Tue,  1 Apr 2025 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743472947; cv=none; b=jYNth1bECfq+maMtJ9suWLOtNOD9XtozC1jZxShHXnOzjxDyXLP2pzhbR+vbTV6WBfsBRtv+AwwB0f3pzEFOgmyLyHeumCBAXtoVJlBpl7IsiwXooCpsTGsx1M8iwIWo/ffrbx/Ob2F32sWr4wf9NiweDkktUVXUNdk0xq0CdZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743472947; c=relaxed/simple;
	bh=XvB+rIczBz1qnhneaNdXbK5G4seFOPUBpyhIcsterL4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j1luJr41G/S3YymSOUb9t05FhGRoP3wZrmzFMC8haVe8NMoznVgHYZxDz5txmPFINNvZ2x029En/mKRud2kkvEaDb7oJgIsdrvQxZTbe0lB1lqN+EO0AOBTrSWxGN68SBgaTJF3ehVHJweU6KC+duKcQAb6C3BPLeg4SbSTBHzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxiYTC/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95C7C4CEE3;
	Tue,  1 Apr 2025 02:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743472946;
	bh=XvB+rIczBz1qnhneaNdXbK5G4seFOPUBpyhIcsterL4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uxiYTC/oFLph49CzH5Pyd5FSEC6boOX8ek0EUExNpjDiGSkNjT/n/y54fTbbFOsbf
	 ZTd+ab5QGMlljEfp/wTJd0ow7gTchwCYrG/o9YbiFGFBKk7prUNPCe9MRjzvfb/fyj
	 lqWqrGhFnqn/wg0aalFXwzgLVaqosfFaHzBSDX2jwwdn2iphIJx1r+LcswGYVoROXv
	 P/d8Ygd39pk2la64B3DfUhjQpNDJbv+r5fpP3McOHnm66LAJFVQEMsty8KkFMNNMX7
	 y1IWx06blgSAimPfYwSBQ+Wj/SCbPDDCAm4DCJ5gTCcGPMjMrAMhTijWD0TitnjVfd
	 7urRTtfH40SLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE257380AA7A;
	Tue,  1 Apr 2025 02:03:04 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs updates for 6.15 part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <insmfmxhkgbdvnnqaxkxfllhrea25hojvjaetxgdu3jr6txyjv@i44r2xo2virt>
References: <insmfmxhkgbdvnnqaxkxfllhrea25hojvjaetxgdu3jr6txyjv@i44r2xo2virt>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <insmfmxhkgbdvnnqaxkxfllhrea25hojvjaetxgdu3jr6txyjv@i44r2xo2virt>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-03-31
X-PR-Tracked-Commit-Id: 650f5353dcc9b6e690a1c763754fa1e98d217bfc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98fb679d19a17aec624d53b016953a3fcd272e8d
Message-Id: <174347298319.206397.12984710188338604785.pr-tracker-bot@kernel.org>
Date: Tue, 01 Apr 2025 02:03:03 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 31 Mar 2025 13:07:35 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-03-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98fb679d19a17aec624d53b016953a3fcd272e8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

