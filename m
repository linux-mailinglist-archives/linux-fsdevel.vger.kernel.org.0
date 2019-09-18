Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B86AB6E2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 22:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfIRUpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 16:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfIRUpD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:45:03 -0400
Subject: Re: [GIT PULL] file locking changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568839503;
        bh=LyJ802uPBL0EVDncOPDpjj5pPAejFhVMEM1Cxx0x9P8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0tXkXFxDjGzhMN3oilNNlkUr9F+QSkSiSJ7a15ncW2Hu27VjWtkuvh38Hhqg/e7cr
         YafHQE4AxpttXjsyH5PmA9rAq3ofuAqWovmsxOxseVEVOGxLYd1XR7dOwRrJ0gu9Gd
         Ww40HhFRi7RMhVVtplP2zVPLFKEMg68TC/pyFj1U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f3b4a58a47b4eb3346581f541348a1fc18aabdce.camel@kernel.org>
References: <f3b4a58a47b4eb3346581f541348a1fc18aabdce.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f3b4a58a47b4eb3346581f541348a1fc18aabdce.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
 tags/filelock-v5.4-1
X-PR-Tracked-Commit-Id: cfddf9f4c9f038c91c6c61d5cf3a161731b5c418
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d013cc800a2a41b0496f99a11f3cff724cf65941
Message-Id: <156883950328.25420.17251362930862063579.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 20:45:03 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 06:50:40 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/filelock-v5.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d013cc800a2a41b0496f99a11f3cff724cf65941

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
