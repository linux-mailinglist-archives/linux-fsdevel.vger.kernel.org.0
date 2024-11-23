Return-Path: <linux-fsdevel+bounces-35629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C3E9D67C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 06:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81EA1B20E29
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 05:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1789D1632C5;
	Sat, 23 Nov 2024 05:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhuaWR7c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE2B15FD01
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732341553; cv=none; b=t/kzrx0HeDOg6+eQvofYQ4aaLM/6r9c1dsSWe0zWs+Qt5QQ3sSIQG0AhW6cD1RfqoQvDGr0aIyudmZqNq68Nb7Lgp3I4Nn66GqbILTZrVcqE7n63F8nyIbpwVvZKndNQTVH+fLtjNHZE3gstRPhyXwH7L/jQ6dDMUpdcJLvelnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732341553; c=relaxed/simple;
	bh=RSwSqaYFtboh9MIz2gdsJcolwX4VTP1xJiL6HI5v94I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=h8gYthWHOIz6ewU3OU6G5AJ8LfDx0d6+Ta1QOgK2aXpGQNVw3ZRp8XTHqIu9KGr4scpdVPPab7oCZmU3AcW0I2+qS2PqlLzVuhMmWqM0iBKm9f0jQDyAQiy5Q/l/VxQv9A2YQY5mn9tgppw7q3OmQg6UHNFxPk2llGQpdmGvCE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhuaWR7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02159C4CECD;
	Sat, 23 Nov 2024 05:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732341553;
	bh=RSwSqaYFtboh9MIz2gdsJcolwX4VTP1xJiL6HI5v94I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZhuaWR7cYJZ84kyqPUsI7MuJnpJqgTiwEl48TAIgs+At58sseeUuCH1z2fvg0jUPZ
	 kalMBeafFL/vgzogt3OrFSZVI8CWAN4diBy5dTNfg8PXhPxFHzNmVRdMHS9WXeuRHq
	 GHcTc250/QXD80htzYYLsLx8Q27Sg2Ls8n5zXdLbOR7sNbjqCiSW4B6ulc0iSKGa1u
	 dGFbGn7bVcIQr8XXqImHLN7y57wtPiKx6x9AMgPSnC7+pA4OGP9Bn5r10jYaI/T2Re
	 RVcpcWTzDuTafJ5xHA9NNRlCgLucVSR6cToF4g+lR80v9HO31H/CctXMstU9dp1UlW
	 I5uTBvKTigBRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D163809A01;
	Sat, 23 Nov 2024 05:59:26 +0000 (UTC)
Subject: Re: [GIT PULL] unicode updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <87jzcvkkxh.fsf@mailhost.krisman.be>
References: <87jzcvkkxh.fsf@mailhost.krisman.be>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87jzcvkkxh.fsf@mailhost.krisman.be>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-next-6.13
X-PR-Tracked-Commit-Id: 6b56a63d286f6f57066c4b5648d8fbec9510beae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 060fc106b6854d3289d838ac3c98eb17afb261d7
Message-Id: <173234156494.2919735.16573684037360327888.pr-tracker-bot@kernel.org>
Date: Sat, 23 Nov 2024 05:59:24 +0000
To: 
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Nov 2024 16:39:22 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-next-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/060fc106b6854d3289d838ac3c98eb17afb261d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

