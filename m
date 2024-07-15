Return-Path: <linux-fsdevel+bounces-23719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD48B931BF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 22:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC481F22FE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 20:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEC813D881;
	Mon, 15 Jul 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4WhR/7l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091F113B5B6;
	Mon, 15 Jul 2024 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075684; cv=none; b=ppyJCgpdSI88QRenXaDJhrCh39SYCe91wU/8iF2OWvzHUqQ2K3otO/u5oQf3sCXdEWeKDzo+wzq7gliRKs4DSO/RBTY9eJRMWcVpmpeutz0KwFZvlRTXdsUwchmvfo1I5ng2dzPBJrCbeIDGlMuF98gKgkS4TIsBBxseMiordo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075684; c=relaxed/simple;
	bh=0iHX5uBfW9+tf3Sh1bzB7g6NtKT24fLBA/C0SyFvxgI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q4wqqmTq4WYCOwu0K6ub4r0Wldx8DUf+mLSKtAPc4RI/zYuksEHOYFIVNFj0WS1EuJHf+LjiJO0zkVcr0wO3gz5T8i5/rmfbqG+bxtBi2cjGasFLZHdZwDZeUQb9fnwn7teRPy9xX4N5k7UraV+NAugEkOlHvkBrGj3RrwcknYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4WhR/7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E5A7C4AF0F;
	Mon, 15 Jul 2024 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721075683;
	bh=0iHX5uBfW9+tf3Sh1bzB7g6NtKT24fLBA/C0SyFvxgI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=d4WhR/7l0cRm4JPENeQSZVibr5p7Sn9PQWWuOmZ4XO+ijknX5ksq8s2kq4CuxdNaa
	 FBjMY16jKZgFyFwVfCoSEr4vbSkkgzX3zxQtXvoBCeeNlG5qXT2b2AqOBpuKBuJ2Mp
	 jPCqexxuQLxK6qfqK+d44/Ko4qftZUHxIlDySesG/i9PDbHDQQvuQ+059sxh4Zxnkc
	 KyS6xt3m6bhH4FkeD1rU3GTAvehJSrh+jo5XXj6/F8s7Cq+78mgbchbvxbS3xIucw0
	 fZGNFBu+GQvIppfBPVhdq/p4ox7SmjIDNcKKF6/3yf2dF1omxu7bzC6k9bB7SfX+zN
	 ReoSRCbV9Pflg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 820BFC433E9;
	Mon, 15 Jul 2024 20:34:43 +0000 (UTC)
Subject: Re: [GIT PULL for v6.11] vfs pg_error
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240712-vfs-pgerror-ced219c8c800@brauner>
References: <20240712-vfs-pgerror-ced219c8c800@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240712-vfs-pgerror-ced219c8c800@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.pg_error
X-PR-Tracked-Commit-Id: 7ad635ea82704a64c40aba67a7d04293d4780f0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aff31330e037f75de7820bc7deb494eeaeaadd35
Message-Id: <172107568352.4128.84461479791244273.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 20:34:43 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 15:54:57 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.pg_error

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aff31330e037f75de7820bc7deb494eeaeaadd35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

