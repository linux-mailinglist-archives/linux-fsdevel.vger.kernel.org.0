Return-Path: <linux-fsdevel+bounces-35628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5C19D67C3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 06:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BCB16137C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 05:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650331632DE;
	Sat, 23 Nov 2024 05:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oghSuYJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5EBF4FA;
	Sat, 23 Nov 2024 05:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732341519; cv=none; b=VU12ECxL9sIH7bxKhovtTIqZthpn/aEzQBGjj06kFYMUJtT7has+PYOu3GFupCz/xRC9oBsdu7D/jeTqgaVjGD3jkiavfndVFRHxryrWyqhcTj72CuARUvzFfXBGJTm8EJzmaSxwPteUk/t3DZONu4TMqHFCfAsT2vRcOuJKZIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732341519; c=relaxed/simple;
	bh=4cSYrz0aFFv7hokXgtfGKQeNxhdMyJSmNVxeKsG5mNo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WyS2D68XuvoMnrBjOR1AKCs7Dm1cgrmZB6aFeoGCLA6PCnMoIi0TUGiAxfovuFqa7OUnxBiNu4x8kyzvKYoT5/lx7mBCphh96Tn1vIG/ObkPP9jndfwVSVqwoTIT0OCId9EIz91Gc6KF8IKpIaS9NGgAOnip8bktz6tc5pCnAo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oghSuYJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A23C4CECD;
	Sat, 23 Nov 2024 05:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732341519;
	bh=4cSYrz0aFFv7hokXgtfGKQeNxhdMyJSmNVxeKsG5mNo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oghSuYJO3G9z0bwjtOdM/iWgapb8MDanyRZVcjbU9PTp0r0qc00/eeyvV7f8pSUp2
	 08pXNPZB9UQJubNApvdDzja95ZRT+Xy6wwuZna4TwByeXb6aKdNhI5reTNUruk+ydG
	 Pv3UPZudtIJKnpdDnUX1m40Z6KXbIxqMGSIqXf7k2u4CUz2yaWKdkM59jdm3tVZzs5
	 AY3hdgwU3hgdT5+PN2Ew2YRXHRzBOrVOA+0cjcBFiMGYHUODYls+J2Qf3q3//yUHKb
	 +Bm6Wc3h6bj1dRpdVvNejcdqtnF9RigTiLhPSGabLyFWlAY/ISGn88wO062ib89zfT
	 RpCi31YVLomqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1403809A01;
	Sat, 23 Nov 2024 05:58:52 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <67lhgpay5opmjkgnhm7nnkhfhbzmlgp3bkwxap6nexzfb62mj5@fsr5p2aggmxt>
References: <67lhgpay5opmjkgnhm7nnkhfhbzmlgp3bkwxap6nexzfb62mj5@fsr5p2aggmxt>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <67lhgpay5opmjkgnhm7nnkhfhbzmlgp3bkwxap6nexzfb62mj5@fsr5p2aggmxt>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-6.13-rc1
X-PR-Tracked-Commit-Id: 9c738dae9534fbdf77c250132cba04e0822983b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 980f8f8fd4228839f3d811521a27d4f9c2ead123
Message-Id: <173234153143.2919735.13832130290069409968.pr-tracker-bot@kernel.org>
Date: Sat, 23 Nov 2024 05:58:51 +0000
To: Joel Granados <joel.granados@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thomas =?utf-8?B?V2Vp77+9c2NodWg=?= <linux@weissschuh.net>, Luis Chamberlain <mcgrof@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>, Markus Elfring <elfring@users.sourceforge.net>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Nov 2024 11:50:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/980f8f8fd4228839f3d811521a27d4f9c2ead123

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

