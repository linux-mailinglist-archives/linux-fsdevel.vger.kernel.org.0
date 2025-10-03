Return-Path: <linux-fsdevel+bounces-63404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6CDBB8311
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 23:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B453C6B93
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 21:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDD52701B4;
	Fri,  3 Oct 2025 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIpNLQ3i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6126E711;
	Fri,  3 Oct 2025 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527073; cv=none; b=rc8hJYQNgDRuc9KjOIZ0uYw/2U8aMoxMOA6ztJiZJfNs59Vw6GsWipy4TCxIgUpApVcQUqAoAy7i+9AP9naqWYtjBwrDoKZNNuS1cjmgcz8VAgOFDGAqVjytBDGMmffSU0NIKOWR/7g5JCQheS+WFGw/793YeuX01/+YX2xLkgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527073; c=relaxed/simple;
	bh=mC5dt0shW8bljQgpdXITV6Mf5cn7k0nL8NomoYMixkM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AGiLa0pQSwZgfP2oqnu4InmDhpt4p1a0MxzPnwwRJ0Os10HlYYiNDsmF45qHvtKvtChomsNf4qk8HZssNMAO+idsklNru7LBwxu623q9h/Rjc4I3z6eWty4nN36eWLTyBuuKW4wDOQLOapetCZ+vSLSB5fC1ZSXtbSVwOcjiilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIpNLQ3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A40AC4CEF5;
	Fri,  3 Oct 2025 21:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759527073;
	bh=mC5dt0shW8bljQgpdXITV6Mf5cn7k0nL8NomoYMixkM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VIpNLQ3im0Mv7pk49laBmm48kT1/KYvY91LQ5km7iV0TOzRWzYQ34Y0cvCZB2ROtF
	 wJqYzJkWFP5B18+4FNDOYXC4kZmUMmVb3DWDMIxCz1UIayO62h/ICNNMI4aQ7JWQeH
	 VYmhrPxYSCfhyNpjQzJWR2sS4T/o0IxN9ng6RISMnOuOuYZut9Xv2v1l4riv8kyqwu
	 pwCaiaYKQJrIIBITs0lbOOFRs/0IDRbMxGyjLzGs2BGqqzMOHCX3Xd2Z+iDC4Nu0SI
	 Ijuj3byQQ3ehfmz4816C8+fOi1IkF7TNTtupGNTRGBkfgMgzVsNgCEEA9afCmLWGfu
	 n34Sf5xS/WB5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D29DD39D0CA0;
	Fri,  3 Oct 2025 21:31:05 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs updates for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250930075738.731439-1-amir73il@gmail.com>
References: <20250930075738.731439-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250930075738.731439-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.18
X-PR-Tracked-Commit-Id: ad1423922781e6552f18d055a5742b1cff018cdc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf06d791f840be97f726ecaaea872a876ff62436
Message-Id: <175952706455.82231.10831103221819770245.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 21:31:04 +0000
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>, Gabriel Krisman Bertazi <gabriel@krisman.be>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 30 Sep 2025 09:57:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf06d791f840be97f726ecaaea872a876ff62436

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

