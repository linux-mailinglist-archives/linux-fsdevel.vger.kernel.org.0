Return-Path: <linux-fsdevel+bounces-14780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EB787F340
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 23:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179F41C20FFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3586D5B1F1;
	Mon, 18 Mar 2024 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjYCusVd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC605A786;
	Mon, 18 Mar 2024 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802042; cv=none; b=Xtq1Ej1ueU+2MlhSuFF1WcYIanTdej9/hPM/yDjOSUcSpD/+x+Tuji0bE/8YoybdLN/GgkPahcUwZ3nn9IoIL2frxTi2r3+i6r0v8RenknfOjBSaKQOWA9a0HGI2VtbEd4N4T2zHHXw5kyoNDl0R9/uBxL3GoF7d+IZpVXkO29Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802042; c=relaxed/simple;
	bh=+oeCCZuGnI9DcVme6NWVIVJJgNcEbP+7SYrOodPau6A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=blIOTuT+vWffjlTxBmrx32SlRg1nmYnhfPBLjjuZ2imEf9llX21w6d35mWyPfopXkmlNaZPZqtT1Z2JobHAv43RXb0UWEqV/2IeN1nok0pTu+maf4DN3dHPddgB/7ZMYy/InPBKY5EW6tOYvhGtYn8yrQ/60K0Yi6Glp7TwJowA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjYCusVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 492C7C433C7;
	Mon, 18 Mar 2024 22:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710802042;
	bh=+oeCCZuGnI9DcVme6NWVIVJJgNcEbP+7SYrOodPau6A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CjYCusVdCPlzf/MFrgzsqGKMRiMHAwB4X177B374Du+vkQDFsA3JlW75xnMQwnhAF
	 02mp6qVs6nc0Gj5FcfBfUNGcntzXtcIHKomJIGFJjYgFPzdisuKrdHJ2QP59LYVGrW
	 2ATBuwPWAcUL5giL2zJzFe0l//CltiMNmq21TqsRTFrdFNzE5VKh54mcKUGShS2KMw
	 U1NPiCHpNfaKRHT7EV251EuxLfH/vD7MjEzWuKf+j7kr1bnNSzBLfYDBdprQGpfL8M
	 AGh0DhaoLq15JLaZBN9EFJpks0oHbT6IyyvdzXEMgGaqmZpZJ2KzJxIBXJHGuKPgeq
	 2Oz90rynqtqKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CA75D84BB3;
	Mon, 18 Mar 2024 22:47:22 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240318122559.jedemqmrgms2wmgq@joelS2.panther.com>
References: <CGME20240318122602eucas1p1d7761ac44909f55a8bb369982d2e0adb@eucas1p1.samsung.com> <20240318122559.jedemqmrgms2wmgq@joelS2.panther.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240318122559.jedemqmrgms2wmgq@joelS2.panther.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-6.9-rc1
X-PR-Tracked-Commit-Id: 4f1136a55dc8e2c27d51e934d0675e12331c7291
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cb5c8683981ebd5033e3cc91f7dd75794f16e61
Message-Id: <171080204223.23091.18349900387276389619.pr-tracker-bot@kernel.org>
Date: Mon, 18 Mar 2024 22:47:22 +0000
To: Joel Granados <j.granados@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, Thomas =?utf-8?B?V2Vp77+9c2NodWg=?= <linux@weissschuh.net>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Joel Granados <j.granados@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Mar 2024 13:25:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cb5c8683981ebd5033e3cc91f7dd75794f16e61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

