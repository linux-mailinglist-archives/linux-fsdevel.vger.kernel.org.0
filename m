Return-Path: <linux-fsdevel+bounces-48673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7099BAB24B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 18:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F15D57A49E3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 16:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF08F24E4C3;
	Sat, 10 May 2025 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQ086Edf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF8624C68B
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 May 2025 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746894506; cv=none; b=IQom1gZx+bC4hzPVYS5ij+y4Kjr6pN89VKw4Ecy9cDUHExG4okLaHY9YLiQY0MlG4pSOChOLFShWSVY8mbTBECXYmaHUuJ6lc505H+MfXOJyijyhGNDChpFTR+J4pSBnPFNbRhHmC39fBU1xKN5//j+W62waHBzM3CH8QCfF/dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746894506; c=relaxed/simple;
	bh=Hg0ZMOaed9nw/aNPkHz+WQeAK+ztG4H8f4bPQWfUqR8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZfoPiQUWUdOFsr5roSFUOJupaIp6mKx9I/h0KND89XTZfW12KSC0esAKhhlYYlsBTAUtQWUVS4L9kb3nd0IQP26pj88LHtgfKc3NA2pfZi8TeYN1RLjVX5snuYNdrXrf0HWU/TzPV22SWnt63eQ4Y40aDlUVavDqqIaO5Pnjw50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQ086Edf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0617DC4CEEB;
	Sat, 10 May 2025 16:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746894506;
	bh=Hg0ZMOaed9nw/aNPkHz+WQeAK+ztG4H8f4bPQWfUqR8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CQ086Edfg3UqM5jJpcjOcpT3NdWTzaF5N5O0YH+f6/V+RhCJTjeDw2hKqR5vssIXh
	 aAaVT4buY0yicqepikEqTztWt6yMJonnzYyq3sOMa6+Zqbn0ljj101qEVuy+HAzZ2L
	 9QfVcLIK+vM67M6mCpteyuLbLHkXHbZBHCKFN2Y/B8phb6peX/7ny1F2uECx0FbXAq
	 jQ/YdjGSAm4ISO9We1Like5e3dcehlZn2ftixuogF6T185YCMqv0hglz0bFbXsQN/4
	 Gxp+urxfsz+LirfA5VfXiS1Bmtyg7E4PrOwhCb5b30bYqjkkjaJhBeVSa0SO7Dv2fP
	 Yn4svtK+1EHeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AF83822D42;
	Sat, 10 May 2025 16:29:05 +0000 (UTC)
Subject: Re: [git pull] several mount fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250510060248.GX2023217@ZenIV>
References: <20250510060248.GX2023217@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250510060248.GX2023217@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: d1ddc6f1d9f0cf887834eb54a5a68bbfeec1bb77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: acbf235235e2b33a0b73802c14c2a1a28a3a3f04
Message-Id: <174689454402.4001425.3662278383701740593.pr-tracker-bot@kernel.org>
Date: Sat, 10 May 2025 16:29:04 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 10 May 2025 07:02:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/acbf235235e2b33a0b73802c14c2a1a28a3a3f04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

