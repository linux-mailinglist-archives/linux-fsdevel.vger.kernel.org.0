Return-Path: <linux-fsdevel+bounces-53971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C81AF99C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 19:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB9C1CC09F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 17:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A652DEA73;
	Fri,  4 Jul 2025 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grmqCRRN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6396A2DEA61;
	Fri,  4 Jul 2025 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751650575; cv=none; b=Hp0dF9VOyoGr42xjANtu3ALJbjYUieooOuh3gI0yx7FK1+ToIyaDg1oe1j0ze2maqmHahg51kOrRJDwhxTM4gQn7rl2h4kRwePMH/zdL3X2Dbk15P0OHZyIgvH0w3owZ7a0lO4v0FbHlYVqzJS2rP2pXcwdOMhNwomrrHkVk8ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751650575; c=relaxed/simple;
	bh=KkTmraAJzSDQJXZhmFCSDdWoS8nm7mjVTMUq+SZfoXo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LrcHNaXchr5GmCv4FIOVhdd/8/icWh9ITvfudFsOcF2OTsGHtabivzPb+lAGEBKJ715creFFXWuIQ8ez8YRJUmmWz6PC1kW+1Fqkp35pIjgNExIyOn83GmGtOFAzpm7rYfs+b+4DGLdsoktJESuamCMIKCV7gBZbPdIrjLzEvKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grmqCRRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47284C4CEED;
	Fri,  4 Jul 2025 17:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751650575;
	bh=KkTmraAJzSDQJXZhmFCSDdWoS8nm7mjVTMUq+SZfoXo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=grmqCRRNcLwWpdzubgINxpnsUIB6VJIOgPAjhOfURRTYcc5c8c2TujmhWlV69tXJz
	 bDaZHFnDYQty6oBaqtJA6DG+5xWhfDEryAofn4FYGt1LmlJ9f6fpHnH66b2nTnZ/+n
	 MHE+DNv9CBwvb0kevBV0rfViUkciGZWZXH/eDJSMQBn9i7v71lcHCzksjrpJLDU1wa
	 FNPSDAGTJrBD4zcIrSvdJFoAzkJqccBz+cyN4zznJ4BmgXvXjWb8+AfwUpEgXHk5qT
	 sZ241V/q3vDsxjwto6A0nznOZOLeiAK9YOUltaTdjUdsWFwBFhXbYKM4txpFBd4YCq
	 NxTEuKzQs5oYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CFA383BA01;
	Fri,  4 Jul 2025 17:36:40 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <b3o4rbii2ni4h67fbahnriodyhodomrd6qxdquxkpm2k5sdjmn@hr74xtmqtoeo>
References: <b3o4rbii2ni4h67fbahnriodyhodomrd6qxdquxkpm2k5sdjmn@hr74xtmqtoeo>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b3o4rbii2ni4h67fbahnriodyhodomrd6qxdquxkpm2k5sdjmn@hr74xtmqtoeo>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-07-03
X-PR-Tracked-Commit-Id: 94426e4201fbb1c5ea4a697eb62a8b7cd7dfccbf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 482deed9dfa065cf3f68372dadac857541c7d504
Message-Id: <175165059926.2287194.11885239279323530155.pr-tracker-bot@kernel.org>
Date: Fri, 04 Jul 2025 17:36:39 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 3 Jul 2025 20:33:28 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-07-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/482deed9dfa065cf3f68372dadac857541c7d504

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

