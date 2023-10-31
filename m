Return-Path: <linux-fsdevel+bounces-1616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 337427DC605
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 06:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53EBE1C20BFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 05:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855D7D506;
	Tue, 31 Oct 2023 05:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nETkD7Hv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C266BD29A
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 05:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1119CC4AF7F;
	Tue, 31 Oct 2023 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698730954;
	bh=QPp+eUo+XBCu9a74ikQmR8iWsCREEDf33Cgp++RtAkU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nETkD7HvKKpKhhTwimQsFOY76N85b2p43ZsBV4FgVmklvAYwOQrQ4OJ93gk/Yrqh0
	 wxIicFyUbpPJ1IBT2Kiw6VRzCPMGadDlNvqxVhxgho0lNlbq59vd8orKvvzNtEB5l3
	 PnozgjKyK3z3L3ViZaJ7ATuiFWYzMm7rdj6TbXVS63YPP+HiDtnlFIcfFF+wTaUKJX
	 tNtXAqZTUmBZlbgiuvVX5SePnQRY5Ijxe6nRUu94Z/v3ivIqWznLQIsnapZzRONMl6
	 5oGqJuWuL7gxCv7lGKW3pjtfH/wJfck0ALhUGS1vhPV/D6mezZihj4e6fNTgnsyT7S
	 zNRnl2+9KrKyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2B16C4316B;
	Tue, 31 Oct 2023 05:42:33 +0000 (UTC)
Subject: Re: [GIT PULL] execve updates for v6.7-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202310301009.2464A71@keescook>
References: <202310301009.2464A71@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202310301009.2464A71@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.7-rc1
X-PR-Tracked-Commit-Id: 21ca59b365c091d583f36ac753eaa8baf947be6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d82c0a37d431ada0d1dae9a2665fcfe17b0f9e14
Message-Id: <169873095398.17204.13583309584177998822.pr-tracker-bot@kernel.org>
Date: Tue, 31 Oct 2023 05:42:33 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Alejandro Colomar <alx@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrei Vagin <avagin@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, Christian Brauner <christian.brauner@ubuntu.com>, Dave Jones <davej@redhat.com>, David Howells <dhowells@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Greg Ungerer <gerg@kernel.org>, Henning Schild <henning.schild@siemens.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, Laurent Vivier <laurent@vivier.eu>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Pedro Falcato <pedro.falcato@gmail.com>, Rolf Eike Beer <eb@emlix.com>, Sargun Dhillon <sargun@sargun.me>, Sebastian Ott <sebott@redhat.com>, Serge Hallyn <serge@hallyn.com>, Thomas Gleixner <tglx@linutronix.de>, Thom
 as =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 30 Oct 2023 10:22:39 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d82c0a37d431ada0d1dae9a2665fcfe17b0f9e14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

