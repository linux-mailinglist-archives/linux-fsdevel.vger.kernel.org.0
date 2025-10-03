Return-Path: <linux-fsdevel+bounces-63409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DFEBB8332
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 23:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 95B6D34391E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 21:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961BA285050;
	Fri,  3 Oct 2025 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTaeZyKQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DC4285CB6
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527083; cv=none; b=FVHZSq8YL6SdgTN3I4pd74RXcweXfGPR0pfylw59ZgQfnCUuSB6DBfTsZl4gk95t0I6kOXkPLDEYEtqXSIGTxhnYCxz6NmQroz51NwApiDDbHkwPmW/kcqGm107mmKUHa03sdl8Igvzkm4QOgLBevUIwL5sUyBuUuRE88QcMBtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527083; c=relaxed/simple;
	bh=bSzbxxcxSdMGfXERxnjTsh3rIC4Cjs5fudkOUorS4UA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CKDq7OoFuvJIOCDpizgeNDN80Ept5BIeKuXevlJ421EoebtjSkXYBQ4eU+E47k43UNvW+Lt146tE1ZW9QC/nLz2yYPb4H3FJXTHQTZ71bB/zEruf8RrFArTFLcHQRovhhvJt1hzlJ1YyVSa46c3VHfYKe3ewFX/IikRh1+RfQFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTaeZyKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D858BC4CEF5;
	Fri,  3 Oct 2025 21:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759527082;
	bh=bSzbxxcxSdMGfXERxnjTsh3rIC4Cjs5fudkOUorS4UA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kTaeZyKQTZ/noj9QmE4H1HdMWESOfEi2aNAOBuOs1/w+U/FXiuz6712IxBMTptRfq
	 DRxwn9Yd6H4eCpUKiiWhgpjOEjr/29bHa+b164LhoVS5fzH+KTOqueqG0ZeduudDGG
	 2A1IHiazn4UpfXfNhspHG6qiJ6se8j+TuGhykbrwZqcpLbm/mpG9BQ1SMCcFhRUTTr
	 +AXXkeJK2SexjfvXKgZy7tod7dYtXi0m4kPFQ8hKhWcS2fPzyofBNTiZw8vTK6u6ib
	 bbe2Ot01HDBswEl5jfZu5cbEwzelUGs/u30e+pezAtic7xZhyHbbozEny2dftbF2vE
	 Ew1hezRrX9ZFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6BD6939D0CA0;
	Fri,  3 Oct 2025 21:31:15 +0000 (UTC)
Subject: Re: [GIT PULL] orangefs pull request for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSRFjtB4fSwU1Cv+V1vYJSppd4=5UcnO7M95yXnULMoZzg@mail.gmail.com>
References: <CAOg9mSRFjtB4fSwU1Cv+V1vYJSppd4=5UcnO7M95yXnULMoZzg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSRFjtB4fSwU1Cv+V1vYJSppd4=5UcnO7M95yXnULMoZzg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-6.18-ofs1
X-PR-Tracked-Commit-Id: 11f6bce77e27e82015a0d044e6c1eec8b139831a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2327dc8513d0928a64b75656a6efe12b5c7c00a
Message-Id: <175952707404.82231.4588822073398772273.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 21:31:14 +0000
To: Mike Marshall <hubcap@omnibond.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>, devel@lists.orangefs.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 Oct 2025 10:56:20 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-6.18-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2327dc8513d0928a64b75656a6efe12b5c7c00a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

