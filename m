Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDA6B6DAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 22:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbfIRUaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 16:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbfIRUaD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:30:03 -0400
Subject: Re: [git pull] d_path fixup
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568838602;
        bh=aVtEsFQz3IdqAASUh/nUD4425z9OwoiunEOlVdwHSXs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tTFCmM0M8ZuW7FjB11E4zWeFT4pwNzrnvoCq8JZoNBVZy7kchWupyMLlo9FL2Hh6Z
         2MM9sJhzYMBQl5o5JshMa7jZqBmpa54oh0/wsQtriusq7CpvXDny6yn+wPMrjfmEAC
         HnuqWTtPBGPhz+3qQKOTy0ZhnLnjnWWJKcBZQv+Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190917013741.GE1131@ZenIV.linux.org.uk>
References: <20190917013741.GE1131@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190917013741.GE1131@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache
X-PR-Tracked-Commit-Id: f2683bd8d5bdebb929f05ae26ce6d9b578927ce5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b30d87cf969e1711f1f621b6b61efb145ee6c6d9
Message-Id: <156883860284.13812.11041506142316678879.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 20:30:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 02:37:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b30d87cf969e1711f1f621b6b61efb145ee6c6d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
