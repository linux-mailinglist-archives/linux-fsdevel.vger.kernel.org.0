Return-Path: <linux-fsdevel+bounces-63390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A94BB7E67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 20:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E404A62FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 18:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843072DECD2;
	Fri,  3 Oct 2025 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U83J0hEw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCB52DE715
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759516913; cv=none; b=aT4wzBvC4MaRcTslqQUZybM9DmiPTmw8To3/Tu6+wjzh8qOQqZR/LJUxydzLJjkZPrqh7zu5nXhtbcDkKWxWXLNy2GiNXrEhoyYb/ZZdyzvAUMn5m+DveHq2lwainawyFxJ0WmCRlijD77GH+ECNiMz5gLJt+SP3YnpVfd3colg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759516913; c=relaxed/simple;
	bh=Iw0R/eH8sdRjvsDw0LwrdqzHaiFlIvrQSvHpCI5+Hy4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hTaSWTyJESzRWmrjKbN/2AmtsS3E1VB9QNM5N5Rqq3NKbfHrXX0A916OCrmMwZqudeT/kSAp5knTpIzCyrCxehnU+UZOocnVcqzB9YfBN5ZEo9Rjkaxa/fzv3457O4C9oDcrip3c1UUnJW4O/EY4jcWsXfds16aC+tdQPcd7nrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U83J0hEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67936C4CEF5;
	Fri,  3 Oct 2025 18:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759516911;
	bh=Iw0R/eH8sdRjvsDw0LwrdqzHaiFlIvrQSvHpCI5+Hy4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U83J0hEwOHhMbU3iTk6bDDSqRoqvPucn/wrpblN1LSEkvqfhbCHeTJH13RLsHzU+X
	 xKWNcwk5lQTFZS+5HCSL796H5eglzNPppEgyEb1sqDWgDl983YwskeQBwK4Ooagj1p
	 qQ2csmykFOhiNa2CLk/45wKFzLfX91bbSnjOWGECpdAuMmvvqdyhmentETJRLYHDp2
	 EF7+Ra3PF0yoZ6SSoWc6vmxoiiOEOQHzZyu3qq5RoG6+PTU/eHfA/CYc+v5oxr4Tx6
	 zPN8bijLLcZzRbG47fnONNq6fJH7dbghetEgTIRiYobYYI6ZYUVOMY+uZHqK/B0bXt
	 7uLlEbNRzpc+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE2339D0C1A;
	Fri,  3 Oct 2025 18:41:43 +0000 (UTC)
Subject: Re: [git pull] pile 1: mount stuff
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251002055437.GG39973@ZenIV>
References: <20251002055437.GG39973@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251002055437.GG39973@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-mount
X-PR-Tracked-Commit-Id: a79765248649de77771c24f7be08ff4c96f16f7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e64aeecbbb0962601bd2ac502a2f9c0d9be97502
Message-Id: <175951690251.32703.17611607890897146326.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 18:41:42 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 2 Oct 2025 06:54:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-mount

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e64aeecbbb0962601bd2ac502a2f9c0d9be97502

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

