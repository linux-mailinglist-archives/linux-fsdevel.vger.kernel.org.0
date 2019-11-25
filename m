Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 874DD1085F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 01:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKYAfC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 19:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbfKYAfC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 19:35:02 -0500
Subject: Re: [git pull] vfs.git fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574642102;
        bh=Hkrc0yo7dEA/JPqcSDYhv9k5U1qztj+v5Q4RbQAcvQ4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=T0JK811EL10zkX5r9eFg6iCW4r8xUH1y3R+c68c+hlkL1aXX3pst8vNi86uebNpaM
         8ncg6gUI/8mJZNAo8lk4flYLgs0Z1heDDfiNbbYKjPFDjNJN94BgV79Ae5r9gJ9oVd
         +bwLSmDa8PN6MEDWKopE28/bazJbim60MPc6kCPE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191124200553.GC4203@ZenIV.linux.org.uk>
References: <20191124200553.GC4203@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191124200553.GC4203@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 3e5aeec0e267d4422a4e740ce723549a3098a4d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8387f6f34952c09fe9a9f6e4be027f8b16cfd18
Message-Id: <157464210199.8932.2451584505088350915.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Nov 2019 00:35:01 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 24 Nov 2019 20:05:53 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8387f6f34952c09fe9a9f6e4be027f8b16cfd18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
