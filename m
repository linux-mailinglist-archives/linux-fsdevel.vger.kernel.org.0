Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300EE22D13F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 23:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGXVkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 17:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgGXVkB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:40:01 -0400
Subject: Re: [GIT PULL] zonefs fixes for X.Y-rcZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595626801;
        bh=0t9F/Wnb4mEskXWmu6AAaZcbpgu4Q4Ye8kWTKGWsVmQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uVR7hvSS0mhjzdXxcbQ4RX88bVG25h9TdkwbdmL3PkwCCtvJiAIdHBkbGTnawEMdr
         G9stSQqXSSCN2r+wy1xAlTFas3lelD2XKl+fn350vpIkuNR4fQFzgC8dWZzlU6o2lQ
         2xBbo0O6K2XJ1JnOggpMAC6XQZTZmS11inlgr01s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200724073626.333882-1-damien.lemoal@wdc.com>
References: <20200724073626.333882-1-damien.lemoal@wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200724073626.333882-1-damien.lemoal@wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/
 tags/zonefs-5.8-rc7
X-PR-Tracked-Commit-Id: 89ee72376be23a1029a0c65eff8838c262b01d65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a343656d30229a424458f8111e55df336375382
Message-Id: <159562680155.3064.4010983355398850296.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jul 2020 21:40:01 +0000
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 24 Jul 2020 16:36:26 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a343656d30229a424458f8111e55df336375382

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
