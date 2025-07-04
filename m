Return-Path: <linux-fsdevel+bounces-53972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF17AF99C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 19:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B17C54484B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 17:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365C22E5B32;
	Fri,  4 Jul 2025 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtQrQmCp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1DB2E093D;
	Fri,  4 Jul 2025 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751650578; cv=none; b=A/cwCDo+d7xs0Wls41+j5PyXSZGEJgRmjmI+pyglFS3Eh1jUQSgz2u7v1b8v1VvynxTDYxxSX6XWW0V/lXgWqXYrbPDulN76I4I8aQrEBAkmkxOHo1KXNO/yiN2np7Ary79z+26E3itBViSd01S67Xm8q0wNbIgKfGRo6xt7ypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751650578; c=relaxed/simple;
	bh=P8Q/hylea7qyRY6tAEIKvRB5w/FGn6Oy3G2/ooSgWv8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aWmORD96+9LntDQyfQYHcAmfWncl9ib1xZ/F7Q7jcT1b6Qe/lr5GgY2WTFHGIHOsizXm86EoJ6pY4KR+726fxOw/O8sjMayqIaTCyadL6LmwoAuABrVmyJSNzB7NrOZ2Yr0apatBpAWfYTU7WyJFwe70z9LOKDnrSU/ds/jnMGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtQrQmCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73000C4CEE3;
	Fri,  4 Jul 2025 17:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751650578;
	bh=P8Q/hylea7qyRY6tAEIKvRB5w/FGn6Oy3G2/ooSgWv8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FtQrQmCpba/kfwEmdEmBgXI7nkKRXieFuB49/FgDsLqtUtH9KEp1aIoQf4CVb04Pu
	 +g1eTkG87XohsZTrYhjqw2CJpnGizHpeFy4sr/3msrXMREhBQGqIBgXOEzLKEVzRYG
	 FAiTsrIOsW6md41O6q144uC0vEvS8OTtZ3mcN4zAcEmlZ+FgPJr1MK2RiRmJzvEj45
	 k5N7K0uYMWdt+5Jfzkh2HqWcBU2FnZIZeWG2SL0kkkINOo+Wwcjgs7t3QgDmklbD8B
	 C0rzhgrlDPFtSOaMzOCLjgCUm0gM1NBaXAedM6YjbeV8PNdXbsazCcmX8hPufJwKd7
	 7XfQaEKuL54Lw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD5B383BA01;
	Fri,  4 Jul 2025 17:36:43 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250704-vfs-fixes-fa31f5ff8c05@brauner>
References: <20250704-vfs-fixes-fa31f5ff8c05@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250704-vfs-fixes-fa31f5ff8c05@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc5.fixes
X-PR-Tracked-Commit-Id: 1e7ab6f67824343ee3e96f100f0937c393749a8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2eb7f03acf4ac5db937974e99e75dac4c2c5a83d
Message-Id: <175165060220.2287194.9579881940381632085.pr-tracker-bot@kernel.org>
Date: Fri, 04 Jul 2025 17:36:42 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  4 Jul 2025 10:36:54 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc5.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2eb7f03acf4ac5db937974e99e75dac4c2c5a83d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

