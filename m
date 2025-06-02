Return-Path: <linux-fsdevel+bounces-50393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 848CAACBD90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 00:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA12166C8E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 22:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94114253951;
	Mon,  2 Jun 2025 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZOnUsFe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21AB253934;
	Mon,  2 Jun 2025 22:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748905069; cv=none; b=Urkts1d4sAmy5mkEUPWO1lMV4pAfwUBd7m8wmNfF3cpKJi9RAgQt7JemCN7m8DAMEMRMEyORjLBVMV2mtddzTTNLWjWr/YzEs2RzFVfLgEAjCD9JctAlTyt3k2YpB4Mh75DfS4K8EKLI7cono1TSAb5aUlyxm2ly3CdbEDxWzg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748905069; c=relaxed/simple;
	bh=Y5nWg0cnFfXBjvSB/uedJBjK9FlDC+ZE46Ur6EHSTsY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=R5Iup5tLQHf6tqzQZaGIM+YP6X2VhBksJG57zQeXVjTQ75duDG+ITC/l2kTeMngLrKP8pInzrK2mXZP3WTlc8BZNMqYVyQCrvZWDQu7YQ3NcIE5nIStkrxyjHPlNLK2vGVQZzN0WIoIO8SLg9SNLWbZM9XI+EHrX73+cZG5pjAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZOnUsFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D58C4CEEB;
	Mon,  2 Jun 2025 22:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748905068;
	bh=Y5nWg0cnFfXBjvSB/uedJBjK9FlDC+ZE46Ur6EHSTsY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IZOnUsFe6O6soHFUTT6u/3DuEwwcqJ1rHsu3Fpw1dQ/CEPo0iUe0HFGcbllWc8sVG
	 JqxBcupwh+ZjJEVnkiY5N1mjjoJ3WHKpJ/XYDAG8RhXUpeaS1eGR90nqACi1qUB9n8
	 5a2+n4D3Ai4babrKGlAOntXxH3SDqwQcrChHALTxYTmhO+4ApedhkU5ndSK1y+CSXY
	 +uhM5FrSaEnVFmqHLgDtrO06lrzfmdieepWpJexYdvWhtyZjTLJHNt6hrGtv5caT1N
	 629mjlE8hdPRgqdqu0DfVMXaU4jB1znNoqotOU1lNGhlgn3CeZlEH8A0oWGftH/CFH
	 JEsWT/3gtlozQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDBE380AAD0;
	Mon,  2 Jun 2025 22:58:22 +0000 (UTC)
Subject: Re: [GIT PULL] vfs netfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250602-vfs-netfs-bf063d178ff0@brauner>
References: <20250602-vfs-netfs-bf063d178ff0@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250602-vfs-netfs-bf063d178ff0@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.netfs
X-PR-Tracked-Commit-Id: db26d62d79e4068934ad0dccdb92715df36352b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0fb34422b5c2237e0de41980628b023252912108
Message-Id: <174890510129.939710.9895869045259458745.pr-tracker-bot@kernel.org>
Date: Mon, 02 Jun 2025 22:58:21 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  2 Jun 2025 12:11:31 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.netfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0fb34422b5c2237e0de41980628b023252912108

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

