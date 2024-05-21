Return-Path: <linux-fsdevel+bounces-19939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 515B88CB4AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 22:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059ED1F22B42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 20:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850AC1494DB;
	Tue, 21 May 2024 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiGebJ2j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373F763F1
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716323171; cv=none; b=Xa4ttrmkUNMjKI3rv+EjU/eeakfAnv0ZDMI9OZ9DG/4CkGkXWVUL4Zl80JV2DvaZiaRyij3ShFsst9dxIbaPHz4Gl5cXyS+D0bOrNxEiOZyHxapFTAqaNqwm5RD+0nwVI2vECDyLW7vpPOeyecHUV1N2yrKX/IaBlX5z3vGpsPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716323171; c=relaxed/simple;
	bh=ueG9kxoAQhx4FnWsJkJfh1xAqScN3Yo4xXNzkziBJ1g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oSv7y35vctaiRdL0u8CS9uk2nFht5MyQV6V4LRdlvLgVr0Eo5GVzYVxsQjNinqokHSKlt9sKIpWnc3cp2gADhm/s8ipoxf/xeo73+GRbV4wYkao/JaqZR41Phoj7vfBA5yP921Eb24KH4DfFNGs4Tsk+9tKfuVkpUGLgtNGbcC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiGebJ2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9083CC32782;
	Tue, 21 May 2024 20:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716323170;
	bh=ueG9kxoAQhx4FnWsJkJfh1xAqScN3Yo4xXNzkziBJ1g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AiGebJ2jBGF/b5ut/nu2pkkCbuCzXWnZnS9stwCur4LCZF5x/yn6nw42x66qeLP+j
	 Eunf9QTR2cg89g/NVae4mEihFcd30ciP32xLPJkmgFOEjHlRfgwHRZzAhzFT1C7nt0
	 pSamy78Y37JhjOk0/JMIXOlwZguI67/Jx0XI0oYHWWUdR+zaq5ysCbBqKZZbl1uCpi
	 435DiXb4k8RbI9TBMfjjonrhlPhVDd6WJy+yUVKpRnmYkzOOS1kX1aNWr20nlysU16
	 c0oMsOhfAJj+Rq6iWteIhofXgCaJT3gmAWTZcfSHjuqvvDBTFVJ+PjbJPNbaUwlutC
	 4kOJLHRnCscFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88DAEC54BB1;
	Tue, 21 May 2024 20:26:10 +0000 (UTC)
Subject: Re: [git pull] vfs.git misc stuff
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240521184359.GR2118490@ZenIV>
References: <20240521184359.GR2118490@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240521184359.GR2118490@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc
X-PR-Tracked-Commit-Id: 7c98f7cb8fda964fbc60b9307ad35e94735fa35f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6394d6f715919c053c1450ef0d7c5e517b53764
Message-Id: <171632317055.11031.1302329004516183875.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 20:26:10 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 May 2024 19:43:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6394d6f715919c053c1450ef0d7c5e517b53764

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

