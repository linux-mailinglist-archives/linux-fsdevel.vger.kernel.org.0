Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F33ED14D15E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 20:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgA2TuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 14:50:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgA2TuC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:50:02 -0500
Subject: Re: [git pull] vfs.git openat2 series
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580327402;
        bh=bivy4n/ijun9pS+hWJwggr0hK4fk6xxaGxyKDV9SEuI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Mgz5u25OENOHi/J1ZPDKE4vRRIvOpzkjLH1Q79wtgrJZSffnZkKDM3aADNuMYVJJx
         +6kRk75AJYV53F+9vlOQZ8SgugVTnmITVfRPOf9y4bkJP7v5X7ZhF45r+QsN2QAWkQ
         6UvJWe3EI7QF8v39u5Qzu5+FJToKLcbUTm1Plyng=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129142709.GX23230@ZenIV.linux.org.uk>
References: <20200129142709.GX23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129142709.GX23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.openat2
X-PR-Tracked-Commit-Id: b55eef872a96738ea9cb35774db5ce9a7d3a648f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6aee4badd8126f3a2b6d31c5e2db2439d316374f
Message-Id: <158032740211.31127.14966607782443439395.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 19:50:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 14:27:09 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.openat2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6aee4badd8126f3a2b6d31c5e2db2439d316374f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
