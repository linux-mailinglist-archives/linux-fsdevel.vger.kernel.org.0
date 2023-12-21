Return-Path: <linux-fsdevel+bounces-6758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E685C81BE0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 19:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7621AB2466B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94A563517;
	Thu, 21 Dec 2023 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0EPCZ+Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D41B63509;
	Thu, 21 Dec 2023 18:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 164E3C433C7;
	Thu, 21 Dec 2023 18:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703182798;
	bh=ZXD+d5cyg3Dm4YFQ4qt/xzy3Gm2+xDoUPKBNs44q2tU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s0EPCZ+ZR+aiKlf0+CrDZyyEfupqE+mJjjEBWi8EcGAmC6mXqdElvaYAUYY84Xu+9
	 qIT5sOvcplROUlN/a0ocgU7v4CQJ9sSN8FCaqxdhcmYM2eTyNH7APg51lFyFCmPJa9
	 4jmh0RtN8BA3gdQibqGR0HSjKV6nD0QaNpCC5+S2JP3dH6BGiUOjuPIPjyvo+nnbiF
	 U/1W09XayVk1MEP2l7z3jTH6lu2Y2gx44WgGBSHPR44mLYUrMl6neso9/rOaCgm8WM
	 QkKx/FfrB1y6u8Go4hfVsAROmg6Lw8UPLjFS4A+da8GYDKIN4WFxvCpLG1YJUgGoog
	 br4MdtIoWaSgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01C8FD8C98B;
	Thu, 21 Dec 2023 18:19:58 +0000 (UTC)
Subject: Re: [GIT PULL] afs, dns: Fix dynamic root interaction with negative DNS
From: pr-tracker-bot@kernel.org
In-Reply-To: <1843374.1703172614@warthog.procyon.org.uk>
References: <1843374.1703172614@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <1843374.1703172614@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20231221
X-PR-Tracked-Commit-Id: 39299bdd2546688d92ed9db4948f6219ca1b9542
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 937fd403380023d065fd0509caa7eff639b144a0
Message-Id: <170318279799.26746.9843487040778102112.pr-tracker-bot@kernel.org>
Date: Thu, 21 Dec 2023 18:19:57 +0000
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, dhowells@redhat.com, Markus Suvanto <markus.suvanto@gmail.com>, Marc Dionne <marc.dionne@auristor.com>, Wang Lei <wang840925@gmail.com>, Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>, Jarkko Sakkinen <jarkko@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org, keyrings@vger.kernel.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Dec 2023 15:30:14 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20231221

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/937fd403380023d065fd0509caa7eff639b144a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

