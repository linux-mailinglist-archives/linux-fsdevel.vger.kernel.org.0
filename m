Return-Path: <linux-fsdevel+bounces-35124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4029D1936
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84259B22FB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 19:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCD31E7C11;
	Mon, 18 Nov 2024 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqkjsVSj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9651E767B;
	Mon, 18 Nov 2024 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959335; cv=none; b=kvQrZhhWBcNu7vbp0bxXr3lOaVt/S4euSCw6DqYOZjVnEHALpqzj1mTrvJmC1/+nkljGPXKhEdPb/DKdRZqWxcMo6JogFUMjjVibQBPr/pMzDZauT6M4wMU3yN/nXBl3EDreZNwUFC2q9T6LBIuedsf+yhUmTNiDp5TJsCqs95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959335; c=relaxed/simple;
	bh=bdtqlrNO3LO3QyuOUZk9EYRUQ+rGUJBBEK2ghvIDA+0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aabvH+QlLKrR5qkK24RaYSZk/GsrEymbgmmruzEL8Ha6Sia65iiiMSLrL7ajaVZInR97Id2fmXtuy2JCcXNhQdbTED8Jm+VNuDidXgAYsLr0R7mRxMthgjkVkGPgs8SolJr6IE1K91ZCWwzyH8r76HE7+iyAfJtuj4Q73MBKbeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqkjsVSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8FCC4CEDC;
	Mon, 18 Nov 2024 19:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731959334;
	bh=bdtqlrNO3LO3QyuOUZk9EYRUQ+rGUJBBEK2ghvIDA+0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tqkjsVSjxSarza2lhHAZ5a14TUbF9C/2V07L2oFLWiEVgkP028UzWl/+GEKTouU0e
	 RgsDuCas4cmYTGJTyq7a9XohIVkZLulwicGjsWVWZTA23y0XN3eG79bQFa1p6VxiR4
	 m50FC/OR7AdbJXzkbLRG4m2+7sn/3YbmUkkNf7T2fv8xZ3aWIrNuN515cXHgSeGzjz
	 qmZnyNeJFLMjTaMm2vaXnfd3ocDHclf4/9QQav/6oQxUywk820tpK958XLHSILnBga
	 QYjGLAl4T0KBVUpwbqL+5vFUvK328lX0qbbSumpMMgudMMpYmSPxNVnUjAgxBawQmi
	 hc7S0ffTKbGMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 621EA3809A80;
	Mon, 18 Nov 2024 19:49:07 +0000 (UTC)
Subject: Re: [GIT PULL] vfs misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115-vfs-misc-aa344b85076a@brauner>
References: <20241115-vfs-misc-aa344b85076a@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115-vfs-misc-aa344b85076a@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.misc
X-PR-Tracked-Commit-Id: aefff51e1c2986e16f2780ca8e4c97b784800ab5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70e7730c2a78313e3ccc932410c939816e3ba1bc
Message-Id: <173195934608.4157972.14455014744874809068.pr-tracker-bot@kernel.org>
Date: Mon, 18 Nov 2024 19:49:06 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 14:56:11 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70e7730c2a78313e3ccc932410c939816e3ba1bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

