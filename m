Return-Path: <linux-fsdevel+bounces-23790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E69219333C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 23:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8B8B24B65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 21:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A867144315;
	Tue, 16 Jul 2024 21:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmEQRTa6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D2913A896;
	Tue, 16 Jul 2024 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721166221; cv=none; b=AgpnaIc5A4aN5S8xqIuMjQwTAr17NE1W+DiQT+BlrEIbB/hzl2OzNUhvDlm8CWDTQT4j5/kSIbKoSUzUUVe0Yl8FIHHlj3kW0ttyrzvxT8JXivqSEXrX6TBr4+Gbu7E9G0LQ2S0RM6niVss+c6v51+2JIVyod227Idj2TNO3PyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721166221; c=relaxed/simple;
	bh=IPANWXWAqRkDkf0UBvOpkG83WTbWEPXWjH+h2t43ZkU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c27lsZNbkcmDsamTWC5mKI8trQi6cjOJ8v8RA/5By/CXM2UU40IFIDrC2M6PeHLxtO7aLIh3G2duwbeK+Mq15EYN9DUwkKkzH9TtUCAUWLW9gX16Y/HXatdsvCoHybHCqeqdcOEl90VyaJ86ef3mbOsnykqqeHaI+QErpQvNqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmEQRTa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BB11C4AF0D;
	Tue, 16 Jul 2024 21:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721166221;
	bh=IPANWXWAqRkDkf0UBvOpkG83WTbWEPXWjH+h2t43ZkU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fmEQRTa6N7Va259JGZHfyDqNOiYZ/9Gv6JhDBD3B93NoVBuZ1ixKN1HQR71NjuR2U
	 WSU+veUGZDWl6RacxfvrP939kmi/JUxKip0PlZJIIXJFNhBd4kV0yg9OTTxquu+kIF
	 AGYaA6ya4UvbvUjuAJaC8uWBgq0ImShjOSIljYNVWw8GV37GmBQGoz0OD07npqrRbx
	 P3EbU/N8I6TRx9lqt95HEyPv5ghi4hbQmBfhaq7+ZnRpFtgbpnz9DVU5HjbjTiYDg+
	 JifCNM6H7SZvwknCmjGIhLOYTuqo/rzlyIf1zt3FaJRTeKYVDu/UARcpLeCkCds9iJ
	 BRDgMTEDzrV3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D516C43445;
	Tue, 16 Jul 2024 21:43:41 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240716141656.pvlrrnxziok2jwxt@joelS2.panther.com>
References: <CGME20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6@eucas1p2.samsung.com> <20240716141656.pvlrrnxziok2jwxt@joelS2.panther.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240716141656.pvlrrnxziok2jwxt@joelS2.panther.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-6.11-rc1
X-PR-Tracked-Commit-Id: acc154691fc75e1a178fc36624bdeee1420585a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8a8b94d0698ccc56c44478169c91ca774540d9f
Message-Id: <172116622137.23491.17450537644562275897.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 21:43:41 +0000
To: Joel Granados <j.granados@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, Joel Granados <j.granados@samsung.com>, Kees Cook <keescook@chromium.org>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Wen Yang <wen.yang@linux.dev>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 16:16:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8a8b94d0698ccc56c44478169c91ca774540d9f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

