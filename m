Return-Path: <linux-fsdevel+bounces-24280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E1893C9A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 22:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECA41F2426A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 20:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5568113D531;
	Thu, 25 Jul 2024 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDfnaRaD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BAA4C7B;
	Thu, 25 Jul 2024 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939822; cv=none; b=pnZ8kzqdxUTbrjgi/0m2FpPFTIR/MSfG0xLMKm+TZKYXFouIHTKcc0abIYFm1J/kR3u+NOvoVPLQlnrpbhfrUBjlz5R2ctniMQcOa/jxVi0kTFXO8VjR4RryQROP8oFSHcAR6ODWVNAX8J+9dRgLRSlvwTKeplq1YN2ChNzDxms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939822; c=relaxed/simple;
	bh=1R5Crw+ZwZOXSfA6dztHaSXevEbv/z06Mpcq8ujXfGo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=seedFjRO/lxz1zidWnPB8HT3Sa2wRLMvIHZ6pB0ESuhPeJ7WqppSLxb3G92hjn7CEgPhrKCb57Rn3efmFPw/U7IfZjUSa0G6OVdsulF0VUYN94C6eDmcl9tBCMVCOJjgr0lgecqE8qFHV7eEuBePuoVNc5GQV3YMH0d9B/NU27w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDfnaRaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CAA4C116B1;
	Thu, 25 Jul 2024 20:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721939822;
	bh=1R5Crw+ZwZOXSfA6dztHaSXevEbv/z06Mpcq8ujXfGo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WDfnaRaDNE+J6fLuQmaWOq0eu4xt8vrjpGpgzKf8awCk2ncc3CtJgaCG0Hqj7mkzH
	 UoFpaBz93eVtipyG7XwIyy+aPOZYvlKkx1jddyRJ33g8V5sFd8c9Q3jnneNP0+8L+E
	 NwzfV4Rx4Ab66C8XgUABs2FgDwBVgWRoEApitYsOBdYg7Tnv1u5ABobfseBFKMtQOK
	 ySj1sRI+LhTGkJXU5EpVQVAoDpnvqbzNBYZssQddaZNq//Vz+4W7SbGbuq+4pNQLH+
	 8GL0GHV5QZqFASUwymJc8KCwqU5es4tPtX5yD7rDzhKENPx1+lVxXt/x771BGahmYW
	 0G8q9ZQ+NQoLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DA87C43445;
	Thu, 25 Jul 2024 20:37:02 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl constification changes for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
References: <CGME20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61@eucas1p2.samsung.com> <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/constfy-sysctl-6.11-rc1
X-PR-Tracked-Commit-Id: 78eb4ea25cd5fdbdae7eb9fdf87b99195ff67508
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b485625078cab3b824a84ce185b6e73733704b5b
Message-Id: <172193982217.17931.952471986314376816.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jul 2024 20:37:02 +0000
To: Joel Granados <j.granados@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Joel Granados <j.granados@samsung.com>,
	Thomas =?utf-8?B?V2Vp77+9c2NodWg=?= <linux@weissschuh.net>,
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Dave Chinner <david@fromorbit.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	bpf@vger.kernel.org, kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev,
	mptcp@lists.linux.dev, lvs-devel@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-sctp@vger.kernel.org, linux-nfs@vger.kernel.org,
	apparmor@lists.ub, untu.com@web.codeaurora.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Jul 2024 23:00:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/constfy-sysctl-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b485625078cab3b824a84ce185b6e73733704b5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

