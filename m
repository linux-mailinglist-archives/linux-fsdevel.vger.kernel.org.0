Return-Path: <linux-fsdevel+bounces-49874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD06AC44BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 23:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AC33BD349
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 21:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088B0246765;
	Mon, 26 May 2025 21:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUifzptY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F852241131;
	Mon, 26 May 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748294393; cv=none; b=kFbLCQ3lz5CTCoACU+JqsDEhd3SKOxTAn5hks55JDFwdaDrKa3ahcLMtDk5Y1plfcAc0IrVpYw4egeddNJWvPgOhf3hnI7HzQcyEMvunh0VRui3LopQNO1WNYWp1aXSllz4AvgifqH/6usX5DhqxpN0pZ/sK0N3mdTLhDjCE3bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748294393; c=relaxed/simple;
	bh=xJtipRcnGuIKlGEyRWDYuPoBm6GbGc+LLoSwkLv65Dg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sVIlm0+gjNEOPHMpMg82A0+his/S+MDq5Lbmt0mfKy4VyBJhCu6WVR4naONa6uhG2C+LRIBrkqV4eoNwx0N+Povk+2wX4Fx+F7aHzzpKtlPkXOXcoErU0Dc8cWclmVm3RiZZbVhY0TipWZdpYpBiQHjYXfRn09ODgVHCxPmS5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUifzptY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44066C4CEEE;
	Mon, 26 May 2025 21:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748294393;
	bh=xJtipRcnGuIKlGEyRWDYuPoBm6GbGc+LLoSwkLv65Dg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FUifzptYE4yo1Rs1ujqePyBl/+8Ic0zYEooZW3z77X/4K5d4Yi7QeAVNO77pdC8Fd
	 W1gy4UnZVfPQAWTXzvkjz8gjG+5zltST1wGMHCXVkXztnfIDllnFleJ0qfWuRhaNya
	 o7LKKa/om14tWL1mHtzzi1PGKkfbj+Tp5dKNRcfQho9wgWwXrcV3kYfutuw3sv283S
	 eQZirupXEMWswIk5RKvBw1BGNLKFiJqrDI9tYaO1cLwK9Ou44eiyCSC4KHhLFRBqLi
	 c++A0Z9SHtDqv5P7VcgD9Z4dQxOkX8vuc6UCdDHT3ied0r/1+p1sKWfzSmKbv+omnz
	 +kkTU3tZxS1sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 055E1380AAE2;
	Mon, 26 May 2025 21:20:29 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs changes for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <oxkibsokaa3jw2flrbbzb5brx5ere724f3b2nyr2t5nsqfjw4u@23q3ardus43h>
References: <oxkibsokaa3jw2flrbbzb5brx5ere724f3b2nyr2t5nsqfjw4u@23q3ardus43h>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <oxkibsokaa3jw2flrbbzb5brx5ere724f3b2nyr2t5nsqfjw4u@23q3ardus43h>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-05-24
X-PR-Tracked-Commit-Id: 9caea9208fc3fbdbd4a41a2de8c6a0c969b030f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 522544fc71c27b4b432386c7919f71ecc79a3bfb
Message-Id: <174829442786.1051981.12286991485013695418.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 21:20:27 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 24 May 2025 20:47:56 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-05-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/522544fc71c27b4b432386c7919f71ecc79a3bfb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

