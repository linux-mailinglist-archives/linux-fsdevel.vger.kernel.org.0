Return-Path: <linux-fsdevel+bounces-24209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 698B393B5C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 19:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138CA1F24BE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 17:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2565515F400;
	Wed, 24 Jul 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlqCvjZf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8499E18E10;
	Wed, 24 Jul 2024 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721841566; cv=none; b=W2+APXKMVSKu37xUXonUOXcuwF6DUjvZcas9iq42uqwtYuhClmOGpw7K7Q/8pPo5vpzWZwWSQV/1+5RZgoN5/A1vS3pDtd7Wx1zpAYPry+hEvl+Zw/7V+PgKUGwfafc0wF68ZQITvum9hBkhl8XLSJF+kd8HD53LJl7xM5Fbp1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721841566; c=relaxed/simple;
	bh=hvXzDbi4djiMSNDcdyPravSaEUpMuN9KsgXZwbRvpsw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dZmIJIziQnRquENsq4ErmZPOyhSpaqyBemJcPceA/MkcpgFnxxbTbuhhk9z5xS0NfCVv09Vxn09RlzyDC7M3mCq3gHZwdINt4bCB5vsReFIAAPo2xgfI3+qJTmZm+9rgVzhn9QyLxcRm5ICjvMMu7haJXI14l9VqbxtK3hS6ADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlqCvjZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62691C32781;
	Wed, 24 Jul 2024 17:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721841566;
	bh=hvXzDbi4djiMSNDcdyPravSaEUpMuN9KsgXZwbRvpsw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nlqCvjZfqaaKYM9GJ61Xwh6Kph/6PJTwwuljS86zCiSbMUZgHE+tWmxj4wmbfHAaC
	 iM8Wl7f6njnAeNTVSV9/dORobTsmWORBq5KqBC4OlS0oscvx1SCvFp3/DjzvfIfb4g
	 Vxr2RiMgn1VI5UoqOH2YSsHXJe3G2+nKwcGO2FdkVuF7DvhNgKdbbs1KwzY70DnW0r
	 95+UAdwN1T34K+hZJmegIxW0K+Hgv2G47HYTQuMaCkoJPpM85Iu4KzcAwUVPL++eKv
	 F9O73vSvDm3FM0u/uYTvkQ/vPd4hUtcBQ1wZeFBCitPz3607IH/hhTDkhqCx2S3JpV
	 l0i2WD6304hJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F801C43443;
	Wed, 24 Jul 2024 17:19:26 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240724-vfs-fixes-620fa9859ef0@brauner>
References: <20240724-vfs-fixes-620fa9859ef0@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240724-vfs-fixes-620fa9859ef0@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc1.fixes.2
X-PR-Tracked-Commit-Id: f5e5e97c719d289025afce07050effcf1f7373ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1e9a63dcd7248385bbbccf1650d69e4af914f05
Message-Id: <172184156631.26103.11635011134758122120.pr-tracker-bot@kernel.org>
Date: Wed, 24 Jul 2024 17:19:26 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Jul 2024 11:19:49 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc1.fixes.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1e9a63dcd7248385bbbccf1650d69e4af914f05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

