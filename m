Return-Path: <linux-fsdevel+bounces-22165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2C9912F37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 23:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3714E286692
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 21:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3686817C203;
	Fri, 21 Jun 2024 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6SAsJ24"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0A816D4F5;
	Fri, 21 Jun 2024 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004145; cv=none; b=AmGdQ2/V2uydsTr0gaHl+RRcUsppUwmkQkTxrj6BOFx/ndmJmnh2XPDqENZtlQigH8aDXWwyuXx9P+99VldBZisQhJfJERhZcZP33TafJQ1ljJ8M0KN2OzPW45tEYyH2sVWDxSz44IlSziOAFkiJ9FDfKoZ7ktaTHL0kLrRsshQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004145; c=relaxed/simple;
	bh=+LIbyvjPcMeXkeMa2lo8e5prHheBCLudLjRyC8TIAEY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AJUuJOLTXvXRzTw+8Eg4sgzsVk/8qGi6JAhakoy93x9SrPTNWkqJYmlkGPfeA2NyUQ2aJqESK5EnlgtSo+HjWz/kXiTV7W5SnNyA1yIMxl/sYT3m1g9z+Fq7zgMAYJJo/CWSZVMCTtW1GR8ed8g69IyWUGy1t5BwzlQrFFdV1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6SAsJ24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FAC9C4AF07;
	Fri, 21 Jun 2024 21:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719004145;
	bh=+LIbyvjPcMeXkeMa2lo8e5prHheBCLudLjRyC8TIAEY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=i6SAsJ24LZai2hLmeNahcLCi77UFlYzp9mYx7uKa6C3eeT0zrwMRp7HHq2fm5rBZU
	 nwBkkAeIwMY4Wy3fN6dAoS0JbGwQSe3pnOkD41/38gg4M67IDhIjX3tZmxdMnCcxs1
	 9uiO4As99m/wcvQr42GlY3QmAmuxeQ+zc5+Nb1xYKwIT0cf0F+61vdDknkMB3b3ePU
	 1PdjKMA0Twg/5xk2MeC4j3oAFNUS12+FuN4Rr+oLpsLmEWsPnIHi+xyNYNfoM+l7Zb
	 251Q6ZJFRMYPt8SUWIiBroaDBF8Y8JaAWc6OO0YkzYGyiom+FxybLc6nZEvh5xvitG
	 w3/tE/nC3aCSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6291ACF3B94;
	Fri, 21 Jun 2024 21:09:05 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs fixes for 6.10-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegvm9M9Kzmtd=X66YijMOoJpKX62vuL4maD+7xBJ0-n5Zw@mail.gmail.com>
References: <CAJfpegvm9M9Kzmtd=X66YijMOoJpKX62vuL4maD+7xBJ0-n5Zw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegvm9M9Kzmtd=X66YijMOoJpKX62vuL4maD+7xBJ0-n5Zw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git tags/ovl-fixes-6.10-rc5
X-PR-Tracked-Commit-Id: 004b8d1491b4bcbb7da1a3206d1e7e66822d47c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 264efe488fd82cf3145a3dc625f394c61db99934
Message-Id: <171900414539.4758.3763719464003191294.pr-tracker-bot@kernel.org>
Date: Fri, 21 Jun 2024 21:09:05 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, overlayfs <linux-unionfs@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Jun 2024 21:54:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git tags/ovl-fixes-6.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/264efe488fd82cf3145a3dc625f394c61db99934

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

