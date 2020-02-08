Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91DBC1567E6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 22:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgBHVzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Feb 2020 16:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbgBHVzD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Feb 2020 16:55:03 -0500
Subject: Re: [git pull] vfs.git misc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581198902;
        bh=e4y7tvZRgosGe4kq/Lr+7SZXR6IOPqtfJ8C56zPMXko=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oh8G7bB63EU5v09h2QslT3ZSzkgga5085ewKuKELVeurA7XZaUyUBz6sv46T15b6y
         X1X1DmrC3VCGCtpqcas7mDUwZWCaBROiWBdpCt+32TCMqGNJ9/Y6DfbLRTbfNUPP5C
         IOfW5eIO6N02/b0FTRk+tlVcrsVAR9ve79gVRETM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200208190329.GG23230@ZenIV.linux.org.uk>
References: <20200208190329.GG23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200208190329.GG23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc
X-PR-Tracked-Commit-Id: 12efec5602744c5a185049eb4fcfd9aebe01bd6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 236f45329460f76d058111de1a1cea12f5a8b734
Message-Id: <158119890268.25917.17255133852584899424.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Feb 2020 21:55:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 8 Feb 2020 19:03:29 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/236f45329460f76d058111de1a1cea12f5a8b734

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
