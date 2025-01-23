Return-Path: <linux-fsdevel+bounces-40013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D98DA1AD15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 00:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D34177A25A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 23:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B454E1D5AB2;
	Thu, 23 Jan 2025 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKXs/HeR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB0A139CEF
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737673338; cv=none; b=uRmy6tUPyCMRFtkzdBv94oMJ1ohajEZaT+mHWGCVI9rApeNeftZjRrg6C9Tx5hRc0TrzoxA1fE+DzYbbdo5bBhpLyqHb2gtiQcCMvaZ8/E28snA9ibgIS1YG0fe1NZNYYQZ8ho5Yin4/3Ao1WPgUcIA9pTHCkBslVRpau+FS7yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737673338; c=relaxed/simple;
	bh=3nzo59RvClaeuTPyHSrl3s5LAPpgbdMv67nZ/XPOeXs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=upmIurOiJmBgyzdUaDlPouKKjAQN7QSGzA1Vet/Kon1NWu5xXRGoCc1+hcCm0aCuxQjfkLdm2JtdS6U0XMcmC5wBnmI/8iwfdrX1ErTDZWfqGr52kqbRsrdLT+rLDueSoebvCM42GGjYX0+rjDNFSsmWtBNTWom/gwDkBvxhtRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKXs/HeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F325DC4CED3;
	Thu, 23 Jan 2025 23:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737673338;
	bh=3nzo59RvClaeuTPyHSrl3s5LAPpgbdMv67nZ/XPOeXs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iKXs/HeR+lGqT2ceSOQsKHSvT2k6eE9hCHc+s6z19RHmy70/PMxIQmHAM/xOoYu7/
	 pjDkkkCawfYEpkuQ8abmB4qaw2QS+ZLfjtoA3wqxMjdYaksVIhl4elt0f+/kaMsTur
	 n+YO1W3SY1C173qcPsVxavlR/6+M4SMSjzhSAEwP7DssTFE6VxuF0WxZ9qx8wFH8TR
	 Cm5c+W2O0WETlOyoqy/F9W3pmAdhcW4wWlGz64Fe987wv1RYn/5ASniFP4RPjsRxyI
	 4cJt/+4fW2TH4Z4dE6SZ1LxDtCRkc2jcmmTKPmnwBYLjxRTbLJHWOMHKyOCdzUnPSM
	 FDIFihQ50W30A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1BD380AA79;
	Thu, 23 Jan 2025 23:02:43 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify cleanup for 6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <iriegksewmptjm4skpp2qdzkvfwlszxnqsl5potoscmzhhm6io@qgj5gxixbip6>
References: <iriegksewmptjm4skpp2qdzkvfwlszxnqsl5potoscmzhhm6io@qgj5gxixbip6>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <iriegksewmptjm4skpp2qdzkvfwlszxnqsl5potoscmzhhm6io@qgj5gxixbip6>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.14-rc1
X-PR-Tracked-Commit-Id: b8f2688258f886f0bc0c0cb3ebe51efaa12191ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 113385c5cc81fd9d08563f1138029f718f593eb8
Message-Id: <173767336246.1527693.13711251019382979309.pr-tracker-bot@kernel.org>
Date: Thu, 23 Jan 2025 23:02:42 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 Jan 2025 15:44:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/113385c5cc81fd9d08563f1138029f718f593eb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

