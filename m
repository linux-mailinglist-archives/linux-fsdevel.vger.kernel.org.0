Return-Path: <linux-fsdevel+bounces-20126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 048098CE8DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 18:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21CA2831FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AF81304AF;
	Fri, 24 May 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGwcRzyE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4586712FB38;
	Fri, 24 May 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716569127; cv=none; b=F5Swjm3TprmNHE/2hyGBMmn59Kjdok7RdtmZj+U87ptlYLjCDacyNO9HEw0tuh55CCgt71WXtSUZEkZlGjlCnojg/ae/Yi8zZ7BlIrw7OFM8GfjQG4gcEOeeQb/np7h2seqQUGtCUA3NNwopScc83A09J2zVei2EZ1qPos0u4Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716569127; c=relaxed/simple;
	bh=bUw8BS8/xhlmX2EUf0rH0EijEEuNZE5I8+apsmK9gpg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SeWek1VgbVEF5Hu3yxanqaNwc9/1MClhJ+m3h/gZ+LxV9RoWaKHu8lwuHYKenqiuMa0MAuacgjeqbBQRGeiP8uCaGCi4nu1+McDkjep9TLnW9bFjEHW/6f48p5HOGmVpoIgpqjtH5y5Csjqt3vJ2zfhEjdh3oRf8P1lCdO00iq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGwcRzyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27394C4AF0D;
	Fri, 24 May 2024 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716569127;
	bh=bUw8BS8/xhlmX2EUf0rH0EijEEuNZE5I8+apsmK9gpg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fGwcRzyEB6nXFwwm+F5cWs5D5WZgarza2TTHhOFovKj4I7ZyhfhME7868yooy65K2
	 btrPeMavsfYgRvQCxa+GBobRLn6RGMHxO1yaw5nronNQYs3hbf091c3LeHZTPLSrNb
	 hgL5/RWGuT9TgAOSqAcm1NzL+cHiKc9lOUwxnO/qoT7+9XNjLPGP47mGSsd4AaDZNr
	 jebOirbKGHRHs7NJ2Dny74fVntWtkJIbxG8RjEf7PMU7tu5Dh9De/7Mo852MkUD69i
	 tCfkHrMeLTqRKU8pAf9hqLRP6esZeNIuJtUPraed34VQe7pe2mgtTBkbHolH8lorSo
	 IfJoh1NGxI3hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1AB8FC32766;
	Fri, 24 May 2024 16:45:27 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <34o5tkmaecep7kccwzgwe4yzbkayhb5wkqukthj5may75yvqgn@43rljzrmlmmn>
References: <34o5tkmaecep7kccwzgwe4yzbkayhb5wkqukthj5may75yvqgn@43rljzrmlmmn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <34o5tkmaecep7kccwzgwe4yzbkayhb5wkqukthj5may75yvqgn@43rljzrmlmmn>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-05-24
X-PR-Tracked-Commit-Id: d93ff5fa40b9db5f505d508336bc171f54db862e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c40b1994b9ffb45e19e6d83b7655d7b9db0174c3
Message-Id: <171656912710.29701.14407442674141724774.pr-tracker-bot@kernel.org>
Date: Fri, 24 May 2024 16:45:27 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 May 2024 09:23:41 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-05-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c40b1994b9ffb45e19e6d83b7655d7b9db0174c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

