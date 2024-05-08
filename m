Return-Path: <linux-fsdevel+bounces-19120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E013A8C038B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 19:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E2D1F23829
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F362012E1C1;
	Wed,  8 May 2024 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmFyhkl7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5541D12B151;
	Wed,  8 May 2024 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190369; cv=none; b=idlGUlpFeL+uDLB0RDsjk1J6zrnGF/QrWKhxl7ob6yAi1jVW9ns8BSi/4yoeED4GbJSKmDWBxvYFYk+V5v+L3rApNLoi0e1Qj2rYuWcOXSFuWaif/6TKy0kK2hFGKgVREvGGTURtTpTQzGpLdTLxuTpRyVY5omItofAXfbu1jLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190369; c=relaxed/simple;
	bh=E1rX+uEyiyyBTm4O0UCMclDSNFz4ciEQN7629gUYxQ4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LZysYA89RFI4i4KChLNWcGsFyuig2PUEoJ0OmGCDVPeeEGK5dCV+7NseLBe0aH0PSlvlSBgiPot6KVluil8FKPud+u43VbZHpnE7kKOajMDSykf5EgAeES71H99ejXFUiTnZtxeYFCX1Ph5asJD2meJu/sT93cvCrl4ZQrpMB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmFyhkl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBD63C4AF0B;
	Wed,  8 May 2024 17:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715190369;
	bh=E1rX+uEyiyyBTm4O0UCMclDSNFz4ciEQN7629gUYxQ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EmFyhkl7UaW2hF+icTtPWUCj0adOdp9DML3nO7gben1FXPo9thNQjuz7xz+sQ6gIK
	 mC/7b9VZLPb6hw7KG5raeS6OCm4ooKTE62TFP6+PmmYxJ1pWUS85VqJvC50We7XV7N
	 t7rHGBA0CC7hOJeMYjyIl+mfZdzH3SmEJz7e3OxLnVDkpEGGjB39wcQ2/B9KrIfTbD
	 G80vf28yt3btG3yZH3zHZbieneQnMBHqBfMLYtzn4gVDYJUhCh+Q3f/faP3nRjhPIz
	 CO8WbxGvi2f6iLhaNKx3vkeinDAISCca0MJMb1GMFXdtJu5PjYgTY1ElVYI3+91Fd9
	 1KI8cedS2S6aA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DAF7AC43332;
	Wed,  8 May 2024 17:46:08 +0000 (UTC)
Subject: Re: [GIT PULL] fuse fixes for 6.9 final
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegvtjodd03R4KjaMg=V9gcCHK3Js3GP-s-8QRcpTJ_TMQA@mail.gmail.com>
References: <CAJfpegvtjodd03R4KjaMg=V9gcCHK3Js3GP-s-8QRcpTJ_TMQA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegvtjodd03R4KjaMg=V9gcCHK3Js3GP-s-8QRcpTJ_TMQA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.9-final
X-PR-Tracked-Commit-Id: 96d88f65adfbcaca153afd7d3e20d74ba379c599
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 065a057a31353c896af2f410ae431975687b29ed
Message-Id: <171519036889.20720.8940562846116581049.pr-tracker-bot@kernel.org>
Date: Wed, 08 May 2024 17:46:08 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 8 May 2024 15:30:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.9-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/065a057a31353c896af2f410ae431975687b29ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

