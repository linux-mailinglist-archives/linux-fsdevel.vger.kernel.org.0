Return-Path: <linux-fsdevel+bounces-70389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F85DC99593
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 23:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BE53A259A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 22:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230D52FE572;
	Mon,  1 Dec 2025 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyDpK5Kl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0942FE04E;
	Mon,  1 Dec 2025 22:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764627086; cv=none; b=IQcbv2iZu2Mf/mkrOkpc+LdH+j7ET4YabjixJejLsxarNBF5NJKapsY1pHUTUwH7eVk7sao9Vqloa9Ql7tPHOhh5Ov1b5QO2DTKxHHCxulR2cUV03zstkfVAAMKw9XtLj/233TgEfte/8TEn+JefKtikmEZ1zZtjb87kFgus6p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764627086; c=relaxed/simple;
	bh=/XdT9+6InDwGR+HHtiacjHIE8oVUKSAprTbWfY5EU4I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i/pyEKfDt8XPMDPiZweFiERu3OkzDh3BV/tWm+r/Dpn3KEjdXTehIfKHo6j8yw3Vn+SCvB7N4l0IVVquD3zKnhn7nEtnNHZPO4xGV9N/t9XgxShP7Xfmc4V03RWioQktK0lE/TUdoOX9K/q7WyAtWDd/GzZQ+NElm5k//QqR1HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyDpK5Kl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F89EC4CEF1;
	Mon,  1 Dec 2025 22:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764627086;
	bh=/XdT9+6InDwGR+HHtiacjHIE8oVUKSAprTbWfY5EU4I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XyDpK5KlP+GYGa/TpRMrceBsrp3yCS4JzRnmXc8j5HcexiHwaazMBgTIUV47H0Ls9
	 KgcMU41nmI3zAyfXpHUqSL/qG9DmKv/UMeRD6CH6fsFg6IKVZ8oYyyOnDir2J3WypA
	 ajC7QVxjXQkJNY4QfYJbKrcwVAFdrACRW/MaEm9PBkoRHEOX9aMPtZzPTPViR5gjvM
	 saHMbQNJZ/vytKTrLftyo3NoP76fB8ikpeLqLvKH2oL8XM6hZ9n/QTdQDjBqaPJ3Jv
	 EhL6oPpWw9NuICuerzzaDle7HsG1X1lt+ByhMNDzXRvY5CH9P56mc8Dp4drcPKtu9J
	 OMDtWjDGwwAvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 787D4381196A;
	Mon,  1 Dec 2025 22:08:27 +0000 (UTC)
Subject: Re: [GIT PULL 04/17 for v6.19] vfs writeback
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128-vfs-writeback-v619-24e0f5ebe21f@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-vfs-writeback-v619-24e0f5ebe21f@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128-vfs-writeback-v619-24e0f5ebe21f@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.writeback
X-PR-Tracked-Commit-Id: 4952f35f0545f3b53dab8d5fd727c4827c2a2778
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ebaeabfa5ab711a9b69b686d58329e258fdae75f
Message-Id: <176462690607.2567508.12865632115034561563.pr-tracker-bot@kernel.org>
Date: Mon, 01 Dec 2025 22:08:26 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:48:15 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.writeback

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ebaeabfa5ab711a9b69b686d58329e258fdae75f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

