Return-Path: <linux-fsdevel+bounces-63391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E5BBB7E64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 20:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7133A4EEBC6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 18:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657D82DF124;
	Fri,  3 Oct 2025 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa7PEf9V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D941F8BA6
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759516914; cv=none; b=iMopy+SD+VQ3/M6e+y4DJ5WAFWHJYgmnK0n0CXJFPniIplJkPHZsNItUeppuHDOMmoatXBvyXcZDMkNNImYPgZnlR5fbwKkFe6t6Ddv9gnVOOImHpMmzl5HBxaKm2L4PasnjWE4VmkCSderSTHHvj0S9aMREnb7U6VQT99oDj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759516914; c=relaxed/simple;
	bh=rJhb3oBIhGtRrUhBeN0e6JxAJ1ka++etXIP3nnnPRWA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hoctgrLTI2jZhhwyiUL+nzxckZYN7BTsqYK4yhtwf+ppwsw+53jEKplnVidvSdv8r4hfDgPWBhmFtqqb+oo2rGMG7zcCwNBmwbXbF43g334nO6HTumhSbbfcbHcZN37e2xkb2kthrBd007RE9Nlz5BL3En7Z+C+VVi4VKxqPCxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa7PEf9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6553FC4CEF9;
	Fri,  3 Oct 2025 18:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759516913;
	bh=rJhb3oBIhGtRrUhBeN0e6JxAJ1ka++etXIP3nnnPRWA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Oa7PEf9V6ZgNj+Erb6SPfCEsv+yFXEuEfnkB8bMXl7dbv6it1oLwTStJ/v8hkHOXL
	 XU2W5pUDjCkt4+7aqqIOTEUNAsD7P4kehQJbXMAJJUc+2etmcIlY58mcgKabXe6IOf
	 YEtZAMnI3fDFfht5x6PHqJ8el8RNZ5ajJTPVYwHPLhMYkAeG72sdIrrpKu3iQDGZEn
	 YSF4GUkHwg2yb6L5gL3AQlbNV1v+A6Y2J9yvk2Wey4vP14P/tT+x7X+pGvIYFjc7Im
	 jaHO4OGeNZcmFz7Uvng7tR4c0QLBbeIqa3akZBdERe165Y2Q6a/NQ83x5SCpkE3scb
	 Y1SenhZ3JZ9Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF1539D0C1A;
	Fri,  3 Oct 2025 18:41:45 +0000 (UTC)
Subject: Re: [git pull] pile 2: fs_context
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251002055714.GH39973@ZenIV>
References: <20251002055714.GH39973@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251002055714.GH39973@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fs_context
X-PR-Tracked-Commit-Id: 57e62089f8e9d0baaba40103b167003ed7170db5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51e9889ab120c21de8a3ae447672e69aa4266103
Message-Id: <175951690453.32703.13462487627217307390.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 18:41:44 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 2 Oct 2025 06:57:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fs_context

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51e9889ab120c21de8a3ae447672e69aa4266103

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

