Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C270BBFA77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 22:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfIZUKH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 16:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbfIZUKG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 16:10:06 -0400
Subject: Re: [git pull] jffs2 regression fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569528605;
        bh=Ibueww09vtUfKrDaUVLSn5WCKqxf81hvkoezdAcn68s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vD4u37yEU6741/h+54qh+YdHe40hhKwRoG5WCaTPM8NxPQaOh9SzxHY1pk31NCtOQ
         0PsJkhMlX8m6MXRhIJ7C/jHLOHRQNt/WVkX9yj7Vi1Cwkja7RX31P9tygWF0ychFNM
         x7muaG1DLWCvj11y6rVebPSGVQ6pbBw3HC+tDvbE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190926143004.GV26530@ZenIV.linux.org.uk>
References: <20190926143004.GV26530@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190926143004.GV26530@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount3
X-PR-Tracked-Commit-Id: a3bc18a48e2e678efe62f1f9989902f9cd19e0ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dadedd85630af28b21c826265f7a651f040f6f13
Message-Id: <156952860574.24871.17988219399293198456.pr-tracker-bot@kernel.org>
Date:   Thu, 26 Sep 2019 20:10:05 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 26 Sep 2019 15:30:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dadedd85630af28b21c826265f7a651f040f6f13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
