Return-Path: <linux-fsdevel+bounces-25476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8186794C61A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 22:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344971F27203
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 20:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD22015A85E;
	Thu,  8 Aug 2024 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rp6GtylC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347647E1;
	Thu,  8 Aug 2024 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150790; cv=none; b=nwOFPcQH3c8eVAti3ufGFVn3v6Fd2OwQSxjyNKWxIAjh/s6vF98DlWm+0tQR/l3wCVdOmbDg62lmLIRTVFWDlQNw0kUq0r8Dl4bYygd5Urwazup2ti/S0A2mnWx8WP2xrqOwADcSyJ1y3H/x4BmXTG2R2XkbZRaNENrSbhZAlQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150790; c=relaxed/simple;
	bh=m+dKZgOJFVr9OUKD39g1vWrK9YgpmIrS+z4RqGgEJ9g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OfxOaHJy3CI1I886CNoZAAlu82OCBcrIVMmjwd2uYH4LYM9eNXcuND+buO8iYwrJ5ANM1SXNdsITjLYipGraUOC3lLvCJ06nVP/N4IrRXwhWqkeJO+3dNXMHf7lrX/g1A7Iw0UTTMVvu7lmyJPj3hm0OGbiXXdlPeh4jULxDvKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rp6GtylC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E33C32782;
	Thu,  8 Aug 2024 20:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723150790;
	bh=m+dKZgOJFVr9OUKD39g1vWrK9YgpmIrS+z4RqGgEJ9g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rp6GtylCs1abTd9C1/vOA1MO2+36GCqARjkIiCdIUeMG6IrvV4VT9h2kXBRdoYfHp
	 kAwg8VFYDL+Q0PSjZNu4F3w8PZiWk6gr3lMYHGUMm06YuLzlvNcVu+C3vie4byqzxu
	 Y+HLFH3j8fRuY4rnvQ1EUxnff7K9mGh/mPCsOoq1XDbQKPztEBs9Wy/hU9t3T9FOzX
	 QYU53nQ3S5Ei5nzHWs0ror9zAMPG9L/YcSJ7iygazpVmsXGV/G46Cdz/8dT0u7jnqR
	 bCEzMRfrnLR4VYjL+wIfjttWwJzrZfKcAnNrDipmkqWvODJamVRd9/OOjVlh3rKD9r
	 gFxgQ0n0DvxXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DFD3810938;
	Thu,  8 Aug 2024 20:59:50 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <6dvutmoo566vc3vr5ezzz6rjhqjjsqhwnrfu2v5tkoieh23mwp@qo2cc2bpin3n>
References: <6dvutmoo566vc3vr5ezzz6rjhqjjsqhwnrfu2v5tkoieh23mwp@qo2cc2bpin3n>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6dvutmoo566vc3vr5ezzz6rjhqjjsqhwnrfu2v5tkoieh23mwp@qo2cc2bpin3n>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-08-08
X-PR-Tracked-Commit-Id: 73dc1656f41a42849e43b945fe44d4e3d55eb6c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3f5620f76f9a6da024bd243a73fa8e2df520c5a
Message-Id: <172315078867.3297575.444982281145141417.pr-tracker-bot@kernel.org>
Date: Thu, 08 Aug 2024 20:59:48 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 8 Aug 2024 11:32:58 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-08-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3f5620f76f9a6da024bd243a73fa8e2df520c5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

