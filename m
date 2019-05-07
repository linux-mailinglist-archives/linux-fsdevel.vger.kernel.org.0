Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7876B16BCB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 21:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEGTzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 15:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfEGTzD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 15:55:03 -0400
Subject: Re: [git pull] vfs.git pile 1: ->free_inode() series
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557258903;
        bh=5TXhF4k5b5z7dxjp1s+15lqAdf51WBaUwCKIMI2Lj+A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uPlCyZdj7gF6UHMCvVecQTWBxwaB2XrPmvX7S5DOyIHA/K14d5GVv+LrGpo+ssujX
         TG3UAjADZjfyXTQk3y+iYnPqI0QVZPpA9SJTpUCdCCNmdjfzGKQ/dC6qKTYBJDWF+W
         xXiPAHQnJjAOCIHTZVfDgTNWUgVnbJWhhOsXZAZE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507005037.GF23075@ZenIV.linux.org.uk>
References: <20190507005037.GF23075@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507005037.GF23075@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.icache
X-PR-Tracked-Commit-Id: f276ae0dd6d0b5bfbcb51178a63f06dc035f4cc4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 168e153d5ebbdd6a3fa85db1cc4879ed4b7030e0
Message-Id: <155725890311.4809.6872888900903293489.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 19:55:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 01:50:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.icache

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/168e153d5ebbdd6a3fa85db1cc4879ed4b7030e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
