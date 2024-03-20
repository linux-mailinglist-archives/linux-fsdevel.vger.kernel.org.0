Return-Path: <linux-fsdevel+bounces-14850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B652088088A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 01:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513741F23D25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 00:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABD1187F;
	Wed, 20 Mar 2024 00:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt3TthtJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28211366;
	Wed, 20 Mar 2024 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894729; cv=none; b=habRAkM2m0myKFcCSXUY+hYtDdLTySVVQ16PEk/Un0vbpIpJ04NgA/V36idvdPCakbVoeYQ5frjptuV86512SPgO5nQhwZV6jqqsTXGeDfj/WQ4v7VZntchFflmJhm7HZru2zUCM1EQUN2xd/ownhvJcbWsD0Qxf8ApdfNCxQ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894729; c=relaxed/simple;
	bh=OJ+DFUbaDU6D6Jdy3Jzi3cIZ7vDGjVP9P9Zwh0GdCHE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YV/24RXPs+9LtvsfU3jykasX4w0k+RDU+E2bWAu5HWY/xmAWbmsBoGP/azvlThWq0LHwRCUezp2rYbj6Ah7c+stRTdD3dgjnjNNNIVJ4AjV6WaFJYuaiYzGrAS2hlq1mhRAjrUqUE9ryWUIApCir0PrSfHgm/wM+clJX2aPvseg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt3TthtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4118C433C7;
	Wed, 20 Mar 2024 00:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710894729;
	bh=OJ+DFUbaDU6D6Jdy3Jzi3cIZ7vDGjVP9P9Zwh0GdCHE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bt3TthtJlY0uGATnr2gJJR9G8MY4DleAZiDIdIRCqqdfGnjLUpCz4X/voEZm26Nwj
	 LsV3rz4w2LwHfBEeZKqv4t6b3qv1kLYBK8ffefrRrIXF1tJ4HXSKA2/bDUu/DJcLh0
	 n5V75xemvlD728iFTLhbDyzgAQ1VaZwJzvmZL/TugpYuSajKVHYql66gJ27GerJJdE
	 xk02PObriLx3sKdCUl/D1Vf06Mhd01TliXOj34GB73vm3na+gItzEr8EAFrfF/3Usz
	 IB1ht174s3NMVTMQDGQbq9BLku/JHBbz7pG7+MhaiTXMzgdC/jtuMB9tQEPaK/q4fZ
	 qa5JAoUeTA/rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BB69D84BB3;
	Wed, 20 Mar 2024 00:32:09 +0000 (UTC)
Subject: Re: [GIT PULL] bachefs fixes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <qhecenhgh5bnkjllimyvmqc6cv5bv4vposvh5hqtjjm7hx3q4u@r4gwjp6wl2k2>
References: <qhecenhgh5bnkjllimyvmqc6cv5bv4vposvh5hqtjjm7hx3q4u@r4gwjp6wl2k2>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <qhecenhgh5bnkjllimyvmqc6cv5bv4vposvh5hqtjjm7hx3q4u@r4gwjp6wl2k2>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-03-19
X-PR-Tracked-Commit-Id: 2e92d26b25432ec3399cb517beb0a79a745ec60f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4145ce1e7bc247fd6f2846e8699473448717b37
Message-Id: <171089472962.650.4843210170856467637.pr-tracker-bot@kernel.org>
Date: Wed, 20 Mar 2024 00:32:09 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Mar 2024 18:11:15 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-03-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4145ce1e7bc247fd6f2846e8699473448717b37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

