Return-Path: <linux-fsdevel+bounces-9214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B1783EEFB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 18:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B30DB229E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 17:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A812DF92;
	Sat, 27 Jan 2024 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flr4FFud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386AF2CCDF;
	Sat, 27 Jan 2024 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706376071; cv=none; b=NsBYA+PPYxOpGIsAT6u5USmvARJ6naynQ2QTV2k2dbY8mcS5nOxlOxZpWLaO9Xly+DtdMhKu9cSIbuU+WY/HB/qB7Pub4l8LYuwrIaabcukGWreID+ZybTPaXTtRreqtgFDGl2F++v3qq6SAwGHGXwqZssnO82t65GiqECnmMUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706376071; c=relaxed/simple;
	bh=Ib6cDt/QY2hfLPFQ0RlqkHhCCFi99tb8UEBT7z5BOvg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r3xB2TVpEZMOV+9ytclhZsj+TlEZBmFYnYtqR0TagoRCfz2q2Uf5qOpcdZQElstgm+EjvAMhUiD52uU99b+rwVI6w6cVQJZwMVRUVCrI1cK8nw3VrEakeIX7un6ucTtQiE5ZbUhLxXyLNedHAgwmcoU/DQeboHynbpNYzBcGiu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flr4FFud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10268C433F1;
	Sat, 27 Jan 2024 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706376071;
	bh=Ib6cDt/QY2hfLPFQ0RlqkHhCCFi99tb8UEBT7z5BOvg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=flr4FFudIYYXvO0+Fv+qCtTyr9erl69zF//ZqplZhxFORecQiVOY7YdME+hKSvHr3
	 rK/ncXQn/f3rvQdWHdcvwagUWNp/B2Tba/8qIYkTq9fN3hrcp+9E3kOtPLtd5Rha0a
	 9fFM6vdtqAqObl8oOnp4cAtVS19QrKn9MVbDCla+zun//ojZQ0q97eaJRcdv1g4siV
	 TDgz9aUl9G0LBVP1Rxfh54rF6xoZArxZb9d/CeKIUD7YfgdtW5TxfEHU1mPj9egoKa
	 r5s2tUbSd3+LpEDhY3pLpy1d2EojziAlEFNpc3a4rVdUPFCzxaS2mHhMnMbL9l4wg4
	 c2IeeCZWlRSkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECD6EDFF762;
	Sat, 27 Jan 2024 17:21:10 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <5refsn7ruuo654gyiou74x2xdisjuulkqpnaj34xnncwyq2wos@etq73tlxpcyq>
References: <5refsn7ruuo654gyiou74x2xdisjuulkqpnaj34xnncwyq2wos@etq73tlxpcyq>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5refsn7ruuo654gyiou74x2xdisjuulkqpnaj34xnncwyq2wos@etq73tlxpcyq>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-01-26
X-PR-Tracked-Commit-Id: d2fda304bb739b97c1a3e46e39700eb49f07a62c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 064a4a5bfac8bb24af08ec8a4c2664ff61a06f16
Message-Id: <170637607096.5716.7333678336004974371.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jan 2024 17:21:10 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jan 2024 18:23:57 -0500:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-01-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/064a4a5bfac8bb24af08ec8a4c2664ff61a06f16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

