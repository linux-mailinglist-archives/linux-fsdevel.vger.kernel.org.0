Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F648495F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 01:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfFQXfC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 19:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727419AbfFQXfC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 19:35:02 -0400
Subject: Re: [git pull] a couple of fixes for mount stuff
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560814501;
        bh=g6x22Dc7Avdw/aiMz6q+kak3RdsYnZZQKnvTpXGeEOg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=W+7BD2sLNxJl2XwS2xi1QiHq1fJrEqWHt/wPEB9Cwr0XIDMKIBcfiUal9+h7z7Zl5
         hbXpJbbeAYjiEoJ0F0GCCWP0rEjcBZvJBLYNBOPvtWUs2mVMdTJdr2jA669jQg4qDu
         Um6RGrpNZxj+vq/EE5fuzahJeQ01JPpfZ0FF7p14=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190617223257.GX17978@ZenIV.linux.org.uk>
References: <20190617223257.GX17978@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190617223257.GX17978@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: d728cf79164bb38e9628d15276e636539f857ef1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29f785ff76b65696800b75c3d8e0b58e603bb1d0
Message-Id: <156081450132.13377.2414887019319976014.pr-tracker-bot@kernel.org>
Date:   Mon, 17 Jun 2019 23:35:01 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 17 Jun 2019 23:32:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29f785ff76b65696800b75c3d8e0b58e603bb1d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
