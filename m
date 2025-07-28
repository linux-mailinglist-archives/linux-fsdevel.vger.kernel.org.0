Return-Path: <linux-fsdevel+bounces-56210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD80B144EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB371891123
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD91288C2C;
	Mon, 28 Jul 2025 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYEAACTe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A04288C20
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746046; cv=none; b=nFip0d01OkQgGqIRusnorZM4f2AKAZAgaBm3SOJwSPTj2wg1krOC3ZWIt2Ejo5dMD61ZFXuMI+qvS8QW25G6Jdt8d2V+7fnXdrGC4+xOwlCub8aMLiPOsM/pU9DYyEtNBJfCY8HBAG2yZYlEpeEKB/Y46F3Pp9YaztRZP+UnZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746046; c=relaxed/simple;
	bh=k6cTM0DlRF4WbrdRhF1D+Y1Od9oCj9Utbzlmg535YDk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KViMDybQA5XPboLCvvVNuBSZpiX2cf23FP8wp5eWvLTE2DjkNuJM7P03Q8Iwff7hH7MoTe7Ib3BjNWEoGdg0nHFliN7fqsjKPO2jj3a44F7aj/2ONBdkHPTnuGsoX7qKmehMSGDBmCIzylLJEKA/OTs23Phwxs3LS6cV8L+RpN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYEAACTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67ECDC4CEE7;
	Mon, 28 Jul 2025 23:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746046;
	bh=k6cTM0DlRF4WbrdRhF1D+Y1Od9oCj9Utbzlmg535YDk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LYEAACTeesV/mL8Kl6i0/ybCYokQwFImHDaZ9FPiS3JC3NsWYjinO1EWw35i0C3ZO
	 dXWSs/TnNITmlb2zHfYraVSl4+mjPx1YrV4YSNSIUGzW565TfKFlFq3cKoYo6kUULC
	 SOPRK6pV1nasdfUE3LX6/JKruHMIFr4iHVTVgtVuTwdr53aWDuildu5RY/Mf0fl529
	 9ctqe9POEnNcpSYQ2DLhlgEXvRghF19NMzvj/TDfkSsOAhWALi81EYW5gATAtybJUj
	 fiaQZsw6PGuJulenxLPlUy0Zavun2VVH4YIISI8fTOhmV36HcLSxce1yQac+MmFkIs
	 B9SilxdnMmqdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C97383BF60;
	Mon, 28 Jul 2025 23:41:04 +0000 (UTC)
Subject: Re: [git pull][6.17] vfs.git 2/9: simple_recursive_removal
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250726080224.GA1456602@ZenIV>
References: <20250726080119.GA222315@ZenIV> <20250726080224.GA1456602@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250726080224.GA1456602@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-simple_recursive_removal
X-PR-Tracked-Commit-Id: bad356bb50e64170f8af14a00797a04313846aeb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1959e18cc0b842c53836265548e99be8694a11a7
Message-Id: <175374606313.885311.8948600462574710303.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:41:03 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 09:02:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-simple_recursive_removal

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1959e18cc0b842c53836265548e99be8694a11a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

