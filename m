Return-Path: <linux-fsdevel+bounces-45114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C16CAA7297F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 05:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFEF3AC53D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 04:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A441B040B;
	Thu, 27 Mar 2025 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttyoOeyf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC21AB6D8;
	Thu, 27 Mar 2025 04:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743050009; cv=none; b=JAELObLW8WkRlLZfnAMpJwj+AxTx+3XMiXyutZbdQvckEBj1/qYcsGyDgqf0XogrKdIZAq3LdhpoaMMeb6hmbLF+GgtL2qJW1RYSenqTEIFU2U1razquystStf8vjTjZXWwCEZQHLX9xOHc0IjIkX9yKUOamX75DM3izI9xtB48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743050009; c=relaxed/simple;
	bh=mTTbUsjA5Kr2K19ofd4bp8BZn7iUKQscyqZDqtTyVIM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FkcQLJHKnS7oKq+VO9Q/HuA057/dVmTfSBDawkkjtMTm6CaJYkV+SRrtAzTks0AfSUQEoL4zxCof/FfK07B1kp+VyKMddAVCx17UN6Xxk+cJVdQL3ryKikseu4Ngx8leeneRYeXeKRvau3r0AdRAD3cw+d7uwYteC3uUyT7scAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttyoOeyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CB6C4CEDD;
	Thu, 27 Mar 2025 04:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743050009;
	bh=mTTbUsjA5Kr2K19ofd4bp8BZn7iUKQscyqZDqtTyVIM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ttyoOeyfy7tHErBJrChX0EzW6Eb83b0/5/O1F0tH+XIrj6ZTaGhxzhRwj/+Ufd/uC
	 0szTPH4j0vnHSJRCeyXC2DC4ROlsAFN0NH6eVh6iMhSc2WJSVCCl5nX8PvBO0IIjne
	 lQzY+EiMCwDxegN9zJlw2pTsHzC9TjEqBb3x9wI1+wjYpFOyZWMEee76ioGKxNLtwQ
	 DteVWb9m/QSMV+EVVVr/NmPSsyediCSOeZcpEBHV18IlS1dMIMbKhA1mE+fd9POrpF
	 vrMcIjJreAyFqwTf5J5YmcYkmjL6QdL+/gI/acR+XSl994wC0ics5TULEWL4Q3dyOK
	 1Ta9Zey7SvNag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 719E9380AAFD;
	Thu, 27 Mar 2025 04:34:06 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <mmb5fqe6a3a7bdoeyeccfn4wafhzgbpsnowjhhj6jtnbdwv24r@73wpky2szbg6>
References: <mmb5fqe6a3a7bdoeyeccfn4wafhzgbpsnowjhhj6jtnbdwv24r@73wpky2szbg6>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mmb5fqe6a3a7bdoeyeccfn4wafhzgbpsnowjhhj6jtnbdwv24r@73wpky2szbg6>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-6.15-rc1
X-PR-Tracked-Commit-Id: 29fa7d7934216e0a93102a930ef28e2a6ae852b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 592329e5e94e26080f4815c6cc6cd0f487a91064
Message-Id: <174305004505.1573369.12369452172947990322.pr-tracker-bot@kernel.org>
Date: Thu, 27 Mar 2025 04:34:05 +0000
To: Joel Granados <joel.granados@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Anna Schumaker <anna.schumaker@oracle.com>, Bharadwaj Raju <bharadwaj.raju777@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, Joel Granados <joel.granados@kernel.org>, Kaixiong Yu <yukaixiong@huawei.com>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Mar 2025 18:21:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/592329e5e94e26080f4815c6cc6cd0f487a91064

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

