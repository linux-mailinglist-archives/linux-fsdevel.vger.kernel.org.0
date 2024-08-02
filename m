Return-Path: <linux-fsdevel+bounces-24894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B20F94621D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 18:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5971C212B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 16:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185AB1537D4;
	Fri,  2 Aug 2024 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7BNEyAB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5891537A1
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Aug 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617604; cv=none; b=mlW+AWuxctfZ7Jcp5jV+C1pZB085jI53bRn0FvWmqSOGplj61cCQMBetypCMhwKXQH13l/DIhw1WlSyFnLvZ3OxFxZc3wV+BvVITXpXZJBrrZk5d5HbPGLghdd/OsanxohRjD494mFIMpqrOi3fvrp7NdyrNxg4t718Nugj0KYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617604; c=relaxed/simple;
	bh=KZ5hD9HW+ZdGLNeIjCAgkhQ0VZO1nxhlKYBbED1GMrg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZJa5spqSUH9UG3p/v3+Iikp1ycsxU06cx01wdOJDbGQqwLoxsGf3w7JQCleOnhYup4Fe9+TiRLCUZxiRD8X+XZhQ4pw5HnluZb7jEjCsaSGMVGJDQOnU/m396LviSxrb5gEACn9HYP8fmZCwvoJcZAsKrWaPOUfWeJ/ff5Qtb3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7BNEyAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E970C32782;
	Fri,  2 Aug 2024 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722617604;
	bh=KZ5hD9HW+ZdGLNeIjCAgkhQ0VZO1nxhlKYBbED1GMrg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f7BNEyABI7woIf3WlaGhXjcPM4C8YDJKOtV3B5h/akO47HR1QVhiy/dCdJFCh9IK+
	 orXRyHzcS9HZQPv2j69EyrNp7vIm08owno9adKurSh/eha17nYni4FLX0HCedBQ9Mv
	 xxqbNH8RYWTrpA10HPOreR09RbcDWPQ1hisOqjA6PHbAEDzZ2PPBIwfx5QKIS+j/vX
	 1zgFy/2xYUEtHOdoZNp8L7tYEprQpDkcrGoAZ2xzBg+ykR8pvYcgtYMhoSFzeH3SpC
	 51z1hmZizHTiuOs4WvYW5d2plIYLrxkHI3nMKUeZLO+qaj5tJzS8FxnrdRqBN+LcaG
	 qJ+CNbqWRknJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57485D0C60A;
	Fri,  2 Aug 2024 16:53:24 +0000 (UTC)
Subject: Re: [git pull] vfs.git fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240801195525.GT5334@ZenIV>
References: <20240801195525.GT5334@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240801195525.GT5334@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 8aa37bde1a7b645816cda8b80df4753ecf172bf1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbea34e693f4cc62d594efc7ef7629900d97b9a8
Message-Id: <172261760435.28369.4907847121417389148.pr-tracker-bot@kernel.org>
Date: Fri, 02 Aug 2024 16:53:24 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 1 Aug 2024 20:55:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbea34e693f4cc62d594efc7ef7629900d97b9a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

