Return-Path: <linux-fsdevel+bounces-49539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88215ABE281
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 20:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3293A7075
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 18:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67AA21FF3D;
	Tue, 20 May 2025 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESvUvkKx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31316280004
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765211; cv=none; b=hL+ynwZmDgqyIU+KqltW4CW/vW+Res8zBAXRaZybekFqeujZNqVDY4rRM3WP3zJB9dvqA+Ukt6HMIrPuZHxwjVpyEgi/9UnhbK9F80fVEk3veY+GKPplLXFuW7TYf5MxpdSVrs3sgCw5U1mwSmRXrt+5fOS96+Rw2ElB8zO5+Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765211; c=relaxed/simple;
	bh=Rhu3+hQfdxjtoPomX5UqD851pJJL4CgSO87P2e5qmzA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ivkHbsNYZojYLx5Ch3RX2u0LruJPywkGZ/4CPzb1BYmbVTmQbLm9D8nO49VpPjiMfoAzCSCioPIp6aEADFPXLaHJG33eQlmoX+q0GvuAYJXes6VEtbjiUWwMGVarb2QwJiRTjzZyqViGcyBUpW5jOqGKjJmmlT/HBY/97gJnh5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESvUvkKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E39C4CEE9;
	Tue, 20 May 2025 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747765209;
	bh=Rhu3+hQfdxjtoPomX5UqD851pJJL4CgSO87P2e5qmzA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ESvUvkKxCwPiH4yyWqC755cwzcEzY+Yw2M6jj/6IVKl636C7gwCYDBG1yuAyRzfGG
	 ousxzzDWRKZpWDvpWb/A+sqPYq9nQd/9J4kAhVoFverevhkS22yhUQ95NR2GtvEDOS
	 nCbZa9WInJwhSJ+yrPh12Cqr4DqahosE83N9CYPNsW+OhoZxdr8XNaWv+2wwOwuFEe
	 j3t12trDKb21KNETU+lGrSkSwy5w8wLK8fxJiUexyHeyBPBn4807qfdNciAml4leXc
	 FroJEo/GeI5aCQhdT9+o+u/X+bR1wAcT98RxJDKpWF3+sq4pn3CnkZ8kWffz4i0zAf
	 qh8wwp7PIx6GA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE103380AA70;
	Tue, 20 May 2025 18:20:46 +0000 (UTC)
Subject: Re: [GIT PULL] fix for orangefs counting code
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSTe1vJLaw=ftzB7LsSEVqWj-5HEznERtWUh=CuBN7yKMg@mail.gmail.com>
References: <CAOg9mSTe1vJLaw=ftzB7LsSEVqWj-5HEznERtWUh=CuBN7yKMg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSTe1vJLaw=ftzB7LsSEVqWj-5HEznERtWUh=CuBN7yKMg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-6.15-ofs2
X-PR-Tracked-Commit-Id: 219bf6edd7efcea9eca53c44c8dc3d1c6437f8b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b36ddb9210e6812eb1c86ad46b66cc46aa193487
Message-Id: <174776524528.1417935.16608630170386598692.pr-tracker-bot@kernel.org>
Date: Tue, 20 May 2025 18:20:45 +0000
To: Mike Marshall <hubcap@omnibond.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>, devel@lists.orangefs.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 20 May 2025 11:52:55 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-6.15-ofs2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b36ddb9210e6812eb1c86ad46b66cc46aa193487

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

