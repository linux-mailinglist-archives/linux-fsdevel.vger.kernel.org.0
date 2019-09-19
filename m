Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEF8B835A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 23:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404776AbfISVaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 17:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404772AbfISVaE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:30:04 -0400
Subject: Re: [git pull] more mount API conversions
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568928604;
        bh=45Lr8LBm98DdUKUxhU3x6irlERmIGCrtOWZQy/FY2oQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=St8+m3WOaB2mpB11vusN1NKehSJQoo0VH4rdqNN23dqXmzMKzV6aZNg2yDxjW++eD
         x2ZK+yUXNP1lg1wEzkZvEMgN+g/KarY86s7xbSxJ/WoZg8L8FeM8C823sgpddzq2fE
         9yYok1peTW1tRf6fIDU4tKFs9V2eugdWQcLacAbY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190919015701.GJ1131@ZenIV.linux.org.uk>
References: <20190919015701.GJ1131@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190919015701.GJ1131@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount2
X-PR-Tracked-Commit-Id: 74983ac20aeafc88d9ceed64a8bf2a9024c488d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc7d9aee3f3ce0c0633c20ea55b81efb3ca7984d
Message-Id: <156892860422.30913.594428232156892216.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Sep 2019 21:30:04 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 19 Sep 2019 02:57:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc7d9aee3f3ce0c0633c20ea55b81efb3ca7984d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
