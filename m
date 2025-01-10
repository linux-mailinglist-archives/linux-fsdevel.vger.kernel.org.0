Return-Path: <linux-fsdevel+bounces-38901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D363DA0991C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 19:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 911807A4733
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 18:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF1421420F;
	Fri, 10 Jan 2025 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0sCe9X5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436242066E0;
	Fri, 10 Jan 2025 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736532715; cv=none; b=uicldVQrGNChv8eddzbDg3NDaTkulPZvDVm4ATNIARa526K0ciGRWmw7lVUFf9Qq+grvSIaF0tkCpYSvoidKoblAOffOOGBBSBlkl2TOBz1yddksPtIcVLSdsgPNqrGeBBSl+VWgPF8OCmxEqOqoNSdiNhs6euHIg9S9BgsDklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736532715; c=relaxed/simple;
	bh=f8wuZSd+7wTpIk7tiWfXkN80+Ma0po/Fb5tY4+txGXY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=H09TdN1AQ2TrEnWHAKLZ2UkQ+6d4/7M2Fh4NuikCDkciihbla/wgEmv0L4+YZPKipAWQOAQpho+h1DJ30pIA2UaMWUAIJVVCyQCq56xM1y/whZGz7vhhr3odmJmjwzq9L74ZGNbUQ5iZg9kuLRyAQ3NAdRF0qMriZGtaSCb8rgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0sCe9X5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD222C4CED6;
	Fri, 10 Jan 2025 18:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736532714;
	bh=f8wuZSd+7wTpIk7tiWfXkN80+Ma0po/Fb5tY4+txGXY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=T0sCe9X5R1jaObnZh529vEyoiv94ZHiB8raPL85PtN5s9aPYaTj2+kWP3E1IaSL9+
	 AAEUf/Zu8Le8sMtq3Z9ApcG22TtP5O2XjBtaFZjJ7FVOq1ygIHFHspHtx+fUtaZ5g9
	 EBoEKlDhMhn8adcqMOBe1pw5kto3QpD91itkhuRbAmc1RGupn0JCOADFj1AR1vn6QM
	 Q9+0DVcxC0Rx9QO34xHTKL3Dv5p5DJlYLHAYTi3aJBWquX+LgL99dD3foMaoFxUpM4
	 1+1np0qRFgyyvOKrVIEsdcYME1JWlZRMudqdxWdmAD61kOfhhvTwa7ffzmjeDe0cek
	 mFd08dtTDdrTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB512380AA54;
	Fri, 10 Jan 2025 18:12:17 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250110-vfs-fixes-f2d851a32684@brauner>
References: <20250110-vfs-fixes-f2d851a32684@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250110-vfs-fixes-f2d851a32684@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13-rc7.fixes.2
X-PR-Tracked-Commit-Id: 1623bc27a85a93e82194c8d077eccc464efa67db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7110f24f9e33979fd704f7a4a595a9d3e9bdacb7
Message-Id: <173653273658.2158138.12793172894507409247.pr-tracker-bot@kernel.org>
Date: Fri, 10 Jan 2025 18:12:16 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Jan 2025 16:16:12 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13-rc7.fixes.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7110f24f9e33979fd704f7a4a595a9d3e9bdacb7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

