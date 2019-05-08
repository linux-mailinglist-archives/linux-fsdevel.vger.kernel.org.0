Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55B861702D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 06:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfEHEzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 00:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfEHEzH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 00:55:07 -0400
Subject: Re: [git pull] vfs.git misc pieces
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557291306;
        bh=RZZv8Z+8vzTN7CSY+CWRG1gv0zs/6ZX3a9s5gCH17sQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HGai9Qd88VCATtse6fR02KKjEaE4KaAgbP9vKTrCpiOoEZh605JUE1/U2jtPeyDAk
         SEjswEPR7UbMC1CfH2+6rX/XHxjnAuzho/1+PicptYjJlpVF42zpxTB42Cs+qh9yn5
         554/gIUyOc8rXr14l1lH+BkToV/djiKGm/wRp5IQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507205319.GN23075@ZenIV.linux.org.uk>
References: <20190507205319.GN23075@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507205319.GN23075@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc
X-PR-Tracked-Commit-Id: 6ee9706aa22e026f438caabb2982e5f78de2c82c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 149e703cb8bfcbdae46140b108bb6f7d2407df8f
Message-Id: <155729130686.10324.57160869690641491.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 04:55:06 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 21:53:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/149e703cb8bfcbdae46140b108bb6f7d2407df8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
