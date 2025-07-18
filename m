Return-Path: <linux-fsdevel+bounces-55466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686B5B0AA52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 20:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D8AAA21F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FD72E8DEE;
	Fri, 18 Jul 2025 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ra+EnYw3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D5F2E88B9;
	Fri, 18 Jul 2025 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864586; cv=none; b=McFmrufi+kqJ8qGExEmT7GG5m+Q7y36EtXox2CRLe0Aot3K1CASVt+pZhiJLsmc7o82SWz2v3nnyPS98t0fSKokOZm2uUTKX6eDfpQdiDcUf/wzpKTLckFH4xhL4ia3eb5TcyBfawwAqkRSMsIEvYwBEeFhPd4iFtWgNWIubHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864586; c=relaxed/simple;
	bh=m8tSVbNvKOU7d1l4TwWKK7VN0a/xlOEsMtvnVF2i6r0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Z+zZzg/LnRIsVLPAlwx3ywYdtOXWzmWZcIEh15V34c7MmOO2KZ6/UoHFpJ6xHErR88AIRGn+4FjN9V4eax4eF5Ws6TQeg3sAyoXQprOKphpPRI4uJCKIKu6bGzoUb4WQT3dSe+mt99O1E8b41tEMAeW6Y9dQSuAAB6/8Onww4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ra+EnYw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD86DC4CEED;
	Fri, 18 Jul 2025 18:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752864585;
	bh=m8tSVbNvKOU7d1l4TwWKK7VN0a/xlOEsMtvnVF2i6r0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ra+EnYw3Y339LDRDN8E0zmrsf2REA4ArIF1qDKIwnsOCWPrFx10MAvDakziYbqQSB
	 yiVNFFrYMZjCIJMviJiEG4SAnqg5pjq28V+aGozYR/Ni8ZbYR6RkOheSZP1NZoQK6D
	 7IehTEnJVbz+BVJoh8k/3Dsc+TdZksNrBodZHxHabiRgtCJypgSHj/vxMqX2VLbwBI
	 8JxE6OQ7fTup3eg+JIIxTOyPvcWLagrB8LpW/aQJ8dIM/DdeCB8iSUeluDDTRo+X8Q
	 lR7mS8TMKp8eMtsguOfZA3iM372hSGOrGwIBbVcFLGfhMXnRH0WEHyl7/vSqFMSzuO
	 FrShYMgEQOg/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE89383BA3C;
	Fri, 18 Jul 2025 18:50:06 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <bgaxbeebayrzhkawwhrxrrdgc6xtsk5h454ejv7py4g74hxjs2@yyvkmakatffx>
References: <bgaxbeebayrzhkawwhrxrrdgc6xtsk5h454ejv7py4g74hxjs2@yyvkmakatffx>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <bgaxbeebayrzhkawwhrxrrdgc6xtsk5h454ejv7py4g74hxjs2@yyvkmakatffx>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-07-17
X-PR-Tracked-Commit-Id: 89edfcf710875feedc4264a6c9c4e7fb55486422
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3d16f31d7b305df46080a95f2d254f78e04d588
Message-Id: <175286460549.2758519.2847484013897993426.pr-tracker-bot@kernel.org>
Date: Fri, 18 Jul 2025 18:50:05 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Jul 2025 20:03:29 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-07-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3d16f31d7b305df46080a95f2d254f78e04d588

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

