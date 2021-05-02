Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77F1370E7C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 May 2021 20:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhEBSdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 May 2021 14:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhEBSdq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 May 2021 14:33:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7B09B61353;
        Sun,  2 May 2021 18:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619980374;
        bh=0P0RyWrCv71rR32uaRQMAvsFgD8ZSfDL9tI7eNq2etg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FwSA6fq9TQg81pUpeJY/fUKXe9aUYvJOV3gL0Bt7AZ7Ve8PMLBs1xaM9XTDhBvhJ0
         JmBrlbNDQpVvirFty79EBJtmRRpN0MpkVeFAUNTVPDJVKzQC4oKg730lRN9KuW+Jk6
         jcvyX0kn1Ve0mXF6+YRgZUmLqopx9uP23RNkmkBTAt8knpWlMvRyc5sQG6fJCfiGXv
         oTj5OLg+MtFL3lgMgg/2ae2kz6YIFcsKBrGdsLaj/rXrXUq0ano95rl9Lx6SIsDgSe
         AfooNozq+2fk7Oy8qQJ6qHrATphqc3sT2aEOjI3WanLzi9CpH2wLC+nc0Iqr6kl5rK
         gF1DXruVixZhA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6780760A21;
        Sun,  2 May 2021 18:32:54 +0000 (UTC)
Subject: Re: [git pull] ecryptfs series
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YI3+6jfW+mEMgx3x@zeniv-ca.linux.org.uk>
References: <YI3+6jfW+mEMgx3x@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YI3+6jfW+mEMgx3x@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.ecryptfs
X-PR-Tracked-Commit-Id: 9d786beb6fe5cf8fcc1ce5336a89401eaa444fb6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b28866f4bb77095c262dfd5783197b691c624fa6
Message-Id: <161998037435.19587.14394782923269771454.pr-tracker-bot@kernel.org>
Date:   Sun, 02 May 2021 18:32:54 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tyler Hicks <code@tyhicks.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 2 May 2021 01:22:50 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.ecryptfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b28866f4bb77095c262dfd5783197b691c624fa6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
