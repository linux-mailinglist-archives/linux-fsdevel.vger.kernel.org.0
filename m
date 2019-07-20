Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2E16F057
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2019 20:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfGTSkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jul 2019 14:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728968AbfGTSkE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jul 2019 14:40:04 -0400
Subject: Re: [git pull] vfs.git - dcache and mountpoint stuff
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563648003;
        bh=hDVDu3/yyXF6w2H9HFBHKWdoh8U/c0IY4QXxKw0So3c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VNtHMm+z/TdPTQY5jVZisvWJt1ymX3g/x/xJLk930lrGAFtDbcZzCpJ0HA4HPTBCt
         3kD+6JMh/P3TAVmk0sjmil+Z4uSv6GgJCyi8Ru3ZMps5tKHQfkL/q7La1zX4zVyUBA
         yG7eQfXHIa9gORqqKSaGlxSDaMsFDrXca+gorLoU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190720030217.GC17978@ZenIV.linux.org.uk>
References: <20190720030217.GC17978@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190720030217.GC17978@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache2
X-PR-Tracked-Commit-Id: 56cbb429d911991170fe867b4bba14f0efed5829
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18253e034d2aeee140f82fc9fe89c4bce5c81799
Message-Id: <156364800369.20023.1746757645356503990.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jul 2019 18:40:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 20 Jul 2019 04:02:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18253e034d2aeee140f82fc9fe89c4bce5c81799

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
