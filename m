Return-Path: <linux-fsdevel+bounces-23717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A74931BEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 22:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEE21F22F52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 20:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687F013CFAD;
	Mon, 15 Jul 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFncPMR8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE13D13AD05;
	Mon, 15 Jul 2024 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075683; cv=none; b=VB0hdjixg//w+E7gtR5V1bv0z3D+n6jyyjGgJ8kWmmLzQbEKZynwCV372ErlXOPLwO12nItpRHXwRc15RqNJrmLbaBnnXTuNev7rqTdcQlZNPzw/6zjmm2/LuCSSzCxVsw/oiPjac1wNDRE5xxE5FmbkSdVTEEGtseQKesMP/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075683; c=relaxed/simple;
	bh=1kwfR2XRBuvU883yTv2SDDvMwxzp+2VzhV4efjNN9iY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oK4ainUBXS8l1dSmBUixVshU83XYWUwQ7u7oCXnXYNgCJ8ihdsphsmgpAJCAO1P9mCdRpohrANJkvplgIE4Nb9Q4lUz4zbJJUTObPmAD2QClrdfh5vHJdEKL+mgxL2hGlopIQBumIKBGoSMtuBwdGi04VUYPAeyENkn0xEyNzxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFncPMR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FC92C32782;
	Mon, 15 Jul 2024 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721075683;
	bh=1kwfR2XRBuvU883yTv2SDDvMwxzp+2VzhV4efjNN9iY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YFncPMR8rgwnd3VL0drDZRJG1+ZvNBv8kkjBJEprlc0zbPOrwAmCEG3r0txbtgn27
	 dMQKg+anvB2ikLTyreftUhefNIQENbEXIV51hdYTsbr0lIMYkmapAkgpBwh1rahITH
	 CITHWUhqhQCA4CljOdLlXUTI1YJRXgaduhLKKFmXOdBILamM1/ll0Z2GfiQ+DHgcC8
	 VpjPST/REaD9W/Hs8+1qNiIxlkzz5/3c2qtL6GZ26ti7l2pElQEiqWILGpfh5Bh7zP
	 kc5bOlSTNP0v3IXfqHeevbkYa63UUTPl9eIJrpi9Xy3Ha83S3ro3NU10UqqpeH3DpC
	 bj+2bXwbhiU1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46EFDC433E9;
	Mon, 15 Jul 2024 20:34:43 +0000 (UTC)
Subject: Re: [GIT PULL for v6.11] vfs misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240712-vfs-misc-c1dbbc5eaf82@brauner>
References: <20240712-vfs-misc-c1dbbc5eaf82@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240712-vfs-misc-c1dbbc5eaf82@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.misc
X-PR-Tracked-Commit-Id: b80cc4df1124702c600fd43b784e423a30919204
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b051320d6ab8cfdd77a48ef4e563584cd7681d2d
Message-Id: <172107568327.4128.4279320775515079617.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 20:34:43 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 15:50:34 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b051320d6ab8cfdd77a48ef4e563584cd7681d2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

