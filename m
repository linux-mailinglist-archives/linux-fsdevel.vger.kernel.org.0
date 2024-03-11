Return-Path: <linux-fsdevel+bounces-14154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C8C878760
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 19:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E604B2150C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 18:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5E85579F;
	Mon, 11 Mar 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgOyTNGi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF085465B;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182028; cv=none; b=On5pv0Y/UhotJSdJokAGZAcfiLVElGlvBkkg3A30Zi80mO5hmq/TqGqgYWtzfogDRHkLemS+dK5xKirUYeIepGef+HrChDCi0xc10QivV7R6fSpArgElNs6Bu5aVeaG2T+WqZDblsLzBlQyufJIutJMHnEixI02T+mipRuLmGTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182028; c=relaxed/simple;
	bh=/s1qAImWYn++MPKRs4qpLdXK2U7iRSWNz6E4Woy1MRI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cFBNnTDp/0xBzl3HcUOd2xSSO8XZslrj548zqnUkDbLOCaUOKtPFL/Jm+TmlLnS7jK+HbOOB23Do6GxIjBX5Bqggy66Vs5K80uEn+ZFzkCjKYiFHSBBcR7aZVDpnhtJ6n9ol+UL+MsIV/T7/jOHC3GuWqNMpMj3M5cp+U0KAecA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgOyTNGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DDC3C43601;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182028;
	bh=/s1qAImWYn++MPKRs4qpLdXK2U7iRSWNz6E4Woy1MRI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UgOyTNGiYCGu7xpkki6PCpJg4DY1jdw1sY821RILOGKRb3O4PuGSJTxD0TE6Scxsr
	 UR/KCbTASH6hJ2rbsLye1lFe3NrPlo6fHWK+vS/nMLf5j7ILZKQumh/vDeM2Fmrr71
	 3VDnqpa3r6pGJzwSFbQwfAXLpCUpmMo8nxQ5356BzdeglZ/6qDALGtYws9r9rX1LPF
	 N2UmGaDR8YyHf1DPWRr/gpK/D3M80j5Tc9hvvFDWhI313MHAOF/dhLqTLk4w00gImA
	 tXPsPR/JFXz/2L17VpQa2KaJvA/ks2KIU0nKtbPX9xPhfv6dChaN6dTvmIgNcYFFUV
	 j+xYiIJLHEM7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D5A6D95055;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Subject: Re: [GIT PULL] vfs iomap
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240308-vfs-iomap-96ff9703338d@brauner>
References: <20240308-vfs-iomap-96ff9703338d@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240308-vfs-iomap-96ff9703338d@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.iomap
X-PR-Tracked-Commit-Id: 86835c39e08e6d92a9d66d51277b2676bc659743
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54126fafea5249480f9962863cfd5ca2e7ba3150
Message-Id: <171018202831.4685.11100741394115016894.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 18:33:48 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  8 Mar 2024 11:12:11 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.iomap

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54126fafea5249480f9962863cfd5ca2e7ba3150

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

