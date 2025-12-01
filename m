Return-Path: <linux-fsdevel+bounces-70409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1DCC99957
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 00:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B543A3A22
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 23:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8AB29B8E6;
	Mon,  1 Dec 2025 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoHwqx67"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13971296BBB;
	Mon,  1 Dec 2025 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764631552; cv=none; b=i+KtHjN/7haQ9/Qwmwzn17Kl+eRKoSnwC/rySA3l5xH4NPeZY2hHPPF0ADTzkr3wiDFzVeqidaTSzKScjQ/yoJKVrWCCQ5cl7f9HIwSJJ5DpUQpawYyO6A4CVDRXxBDTW0/U5r5egz+6aRM/brUvu9n7VBVPl44Hu/fcnfA7AFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764631552; c=relaxed/simple;
	bh=UQOl19Ll3BDXL5He9plwgdJf3I7muOyWvZAk7NBq3m4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cab/9qsM1JFdsERH2twuv/xu9WHeuMklXbEHkmSeiET94DKq6vk5+zHrEvc75thXSKz14ERx0wMRYyS75UhZjDSYHbiCuzCfPGWwRsHYEMn236ev3W8+NP4aFe6pq8trwRP6DljRjoo8HPjfCtN1Y2RfyjxymCKbEuTC0Oiu7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoHwqx67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955D6C4CEF1;
	Mon,  1 Dec 2025 23:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764631551;
	bh=UQOl19Ll3BDXL5He9plwgdJf3I7muOyWvZAk7NBq3m4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZoHwqx67FHrXTpZfamvLGWNKVCvMwDPNLZaJvYBW4l6h0kWG5jp79U2nhdup8Kr1T
	 HP88wSljk2kv91afkNk50WJbQ73OGRaPauRuKaxL0c4fhtANdFVTcMd6sJ2ggxPsqx
	 forRr6sQB9sSrO1Su73bbkuiL1s0rY2MudL5TqrdJSPDRuIrNC/rbhSe+wgAOkvSXe
	 xBgrtzRBm/xoD75SgT+QzwkkErr2caOd5WNp8MJvK4J7VL28gkqj7QS7UOn1TM90vL
	 Tf7FHioh4VrKRNvPROW1W6BJehXz4Xcv9QyYjXOiH2x0CMHXGaQud6FzRNELm9dHCW
	 h2qvC0QfseFug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B57DF381196B;
	Mon,  1 Dec 2025 23:22:52 +0000 (UTC)
Subject: Re: [GIT PULL 10/17 for v6.19] vfs super guards
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128-vfs-super-guards-v619-45069c20bd0d@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-vfs-super-guards-v619-45069c20bd0d@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128-vfs-super-guards-v619-45069c20bd0d@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.guards
X-PR-Tracked-Commit-Id: 73fd0dba0beb1d2d1695ee5452eac8dfabce3f9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 978d337c2ed6e5313ee426871a410eddc796ccfd
Message-Id: <176463137134.2594946.5551029995673927962.pr-tracker-bot@kernel.org>
Date: Mon, 01 Dec 2025 23:22:51 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:48:21 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.guards

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/978d337c2ed6e5313ee426871a410eddc796ccfd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

