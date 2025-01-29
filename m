Return-Path: <linux-fsdevel+bounces-40334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E408A224DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 21:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787A13A5181
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 20:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F8F1E47C4;
	Wed, 29 Jan 2025 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEFylvEv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7711E3DEF;
	Wed, 29 Jan 2025 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738180816; cv=none; b=Nrk+2pywcXJuWOp2ws0r/kXEvMD93peP7QwHRMMmQib+UcIUe+LEUoTAau0TRxQRG9FjKmZ7HhxKMaq+l/gxVGrS1wkO8j3VwD+jOEKhZNOEpfxgB75g2q4RwZ7N1vlKAHIjJk9Wp3Exyk+f1sFt/NoYw8JMh4SPm8e6nNXZswA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738180816; c=relaxed/simple;
	bh=xnZ4fKS0/0L2RsSPDfJ1vXCbXjO5hggsmL8UyjCS2qA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j7Ys2NZt4XliJi1HZ4fQmipJqea09bykiz18Erflh3rHoDKUo2NCuFVPMA8l2TdD/fXlS6WTW0GvyvfV1aC1WO2Bx/9LDQ/kkb0RRR3M3gsyPZFrgK8XyYUh9mmbKbTZ2H8G8DBHnkVa/d2U3G/BPYO3FIKCaZ2ViqWKfjVPAHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEFylvEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2873C4CEE2;
	Wed, 29 Jan 2025 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738180815;
	bh=xnZ4fKS0/0L2RsSPDfJ1vXCbXjO5hggsmL8UyjCS2qA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MEFylvEvUySgKzSRQ0kJTNeH6hUteM+Bxga6UPbC5vpzUorDi8RBa0IF86C+Htajv
	 4r0uE3XJ0dFJ8LPi8EaPmVQGAsygwNZdL5wmY91ii8XjoGXQgPbZnMHXAOODFcagzv
	 ELmnLQ5QswKMLg5Y6QeUC8VS5Ob/GK8r//vbvrS0Qvwuw/B9tugQD/6h8xu1V6F6rG
	 zMGtT0N0dfMMCxxfN9J6JOqpFlVNq3r26c4ixsdX/u1tzHe6si7whyYSzFAja7mr0+
	 95rgS5+vniNbKekc6OV11W9lwIFPGvPGKd/lJ+JoDeZWqX1q1gsKm5pVawHDBDj/lM
	 G/tsWvFRnIRWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 423FE380AA67;
	Wed, 29 Jan 2025 20:00:43 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegvZoxFLWkFzHPw71FsVxoGMwg+P_iz9eeyU54+D4KG4ow@mail.gmail.com>
References: <CAJfpegvZoxFLWkFzHPw71FsVxoGMwg+P_iz9eeyU54+D4KG4ow@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegvZoxFLWkFzHPw71FsVxoGMwg+P_iz9eeyU54+D4KG4ow@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.14
X-PR-Tracked-Commit-Id: 2d4fde59fd502a65c1698b61ad4d0f10a9ab665a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92cc9acff7194b1b9db078901f2a83182bb73202
Message-Id: <173818084211.411204.7985638993481223315.pr-tracker-bot@kernel.org>
Date: Wed, 29 Jan 2025 20:00:42 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Bernd Schubert <bernd.schubert@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 29 Jan 2025 16:33:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92cc9acff7194b1b9db078901f2a83182bb73202

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

