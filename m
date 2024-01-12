Return-Path: <linux-fsdevel+bounces-7852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC82082BAA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 06:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A95A2854F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 05:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EA05C907;
	Fri, 12 Jan 2024 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHXGuGes"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D0B5C8F5
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 05:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12BE6C433A6;
	Fri, 12 Jan 2024 05:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705036068;
	bh=DKM91/hbuHjxBlquDutUj+/Tm0u7vqgBDJSDS9wffRs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SHXGuGesCe1MAY/6E0KCspu8VH3lDVtDgSeGHAH8V+YSWrw9nyTO6+u61I0xR/MB5
	 UfWc6UV9NnqXBpd4W37q4S5iDcckawSzPmNbbs8kS2NlprZPOSu9U1kZBYGtYEdr4t
	 8Zvf4+/Mc4Cyi1AZbBUXM2GagNIvnpAoItbEihr5JWaXYro2tjrwhH6khDSy0NDueL
	 pN66oAys1LuRnXYjKu9fi7iRbLmmVwnxR7/YBdS/aR1+ws4/ryYakNG84LIb7lPmHQ
	 eWCyrhFJ5RTIIPr+qiFdNe+gpVDl0WE+UtSR8vmmYO4KzEo4YFn7bR4HaipgF6ufyU
	 NxD44QJXVb5tA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02A83DFC697;
	Fri, 12 Jan 2024 05:07:48 +0000 (UTC)
Subject: Re: [git pull] vfs.git misc pile
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240111102141.GY1674809@ZenIV>
References: <20240111102141.GY1674809@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240111102141.GY1674809@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc
X-PR-Tracked-Commit-Id: c5f3fd21789cff8fa1120e802dd1390d34e3eec0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 488926926a1653adfda3f662355907c896524487
Message-Id: <170503606800.7299.9609543730742298289.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 05:07:48 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jan 2024 10:21:41 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/488926926a1653adfda3f662355907c896524487

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

