Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0650E1BCF12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 23:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgD1VpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 17:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgD1VpD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:45:03 -0400
Subject: Re: [git pull] vfs.git fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588110303;
        bh=Gw608eUfMB9sxFqlDSjhvls7OCZQY2mHd3rra4RTmlk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TsJ5eTb6NQv5v8kJ9+c+oBKcgY/kis5WJpfbLCY3r8vutKsUP0Vf3FRpqqqF3WQV/
         52pn0WPKgzaSdwVInJwQXRyoEmPF+pEMBBpTebzy/tXA54Qno5xOmWOFXOBYIfBMMK
         VPH30evZzhzSArXh3VH0GZD784QDguvVDQVxZ5no=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200428211855.GZ23230@ZenIV.linux.org.uk>
References: <20200428211855.GZ23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200428211855.GZ23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: b0d3869ce9eeacbb1bbd541909beeef4126426d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96c9a7802af7d500a582d89a8b864584fe878c1b
Message-Id: <158811030351.16166.2400535673270943914.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Apr 2020 21:45:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 28 Apr 2020 22:18:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96c9a7802af7d500a582d89a8b864584fe878c1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
