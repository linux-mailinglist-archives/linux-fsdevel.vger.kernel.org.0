Return-Path: <linux-fsdevel+bounces-18174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D778B61B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2BD1F22065
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEB413AD30;
	Mon, 29 Apr 2024 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNJGK/xH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFF13A3E5;
	Mon, 29 Apr 2024 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417804; cv=none; b=oNQ+SZwH+j+mOhTsL2vNWerMjPaXcR9Vd4LWNH2MGUSmFX3FnHBLgBpd3u9zrRO3hdZLRAppgHI374Ti/aaLo3Fl9EcwOhXeJ4Tmt+ut6es0kM6I9w6TYkN9XhNd1Rzbbaj8KtsgMzAtXTdTp6zI5m/Tk3K3vIm3+WEEsXn0c8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417804; c=relaxed/simple;
	bh=OgcptYGgNzxbSsJS+7Njk552s70vhPBsWmfphnd3lnA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QQGFcI92+yTeTuGFSzSIiWGPNK/JQCBojVYYbUbFdXy1cCUA8j132ApwdYUmVTjYuZ19CS0p3YhkzhMSGHQf64pBxkwtkLRFpmK0KxqnbLQFHWl5aCxvPT1MOD1kzG+XzZS6lt2RaYj54jurWLgcqy4FoOoT2ks6j5gntnoH42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNJGK/xH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82DA4C113CD;
	Mon, 29 Apr 2024 19:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714417803;
	bh=OgcptYGgNzxbSsJS+7Njk552s70vhPBsWmfphnd3lnA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gNJGK/xHDLpamKoCNuKMLJxweEvrehJbe+D9xqTUoTk0iB2CFsJJq8gF0ueV2DICC
	 /86M4JjIfc+qRBrWnHhEz2FFcRLPoUPBA6nlX9O5pXaK2Ro0IKhYHCgt9lEoLN16Qf
	 8wmUjpqp7GnBIOKMuXxLgtQzsYp8gWqbIf154m3cKba/vStq6LXE3NWFqaP8+lTaRI
	 mEUbKkTRT36fVsOMPdH2NniSwAqYpVmmMbdk6IBWJqEpgjVWjJqvtKkGcF+Iygg/Rx
	 8IV8zv7p7PsCdImEFaCh/rTxNRzJ+wc+d3l9ZraA1pPsfWNO5TvOkAJ5fUoP+kt9Yw
	 VSgU3cn1BEvZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CBAAC54BAD;
	Mon, 29 Apr 2024 19:10:03 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.9-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <grwoeqxbwxgunh4cvdp4jy2qctv2yplrjv2hr4wwqyproe6xor@nuehswrkwqaw>
References: <grwoeqxbwxgunh4cvdp4jy2qctv2yplrjv2hr4wwqyproe6xor@nuehswrkwqaw>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <grwoeqxbwxgunh4cvdp4jy2qctv2yplrjv2hr4wwqyproe6xor@nuehswrkwqaw>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-04-29
X-PR-Tracked-Commit-Id: c258c08add1cc8fa7719f112c5db36c08c507f1e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a2e230514c5f1b09630bab94e457e930ced4cf0
Message-Id: <171441780343.14808.14014986886216923256.pr-tracker-bot@kernel.org>
Date: Mon, 29 Apr 2024 19:10:03 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Apr 2024 12:24:13 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-04-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a2e230514c5f1b09630bab94e457e930ced4cf0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

