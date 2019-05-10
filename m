Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7C6196C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 04:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfEJCkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 22:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfEJCkC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 22:40:02 -0400
Subject: Re: [git pull] vfs.git braino fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557456002;
        bh=gwWdGm+lzGwS6EDLPFlG0owva6ZzrylLJimFAezPCh4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0fwkl7dH3wgkNAKMM5SVTPIpcZM0t5YwSQGD+hgq714tjlPqM9bsWoJeZOEZdSlf1
         /Bjvhcr67YiD4r18AnmivwP/8IM056k+QG8WyZhmXZQucccp0W/gwFGFVldewEPGsU
         XGVaNylsN62CzcFvxLViV8D7yU+uH/6PkmbCRTbo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190510023333.GS23075@ZenIV.linux.org.uk>
References: <20190510023333.GS23075@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190510023333.GS23075@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 05883eee857eab4693e7d13ebab06716475c5754
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ea5b2abd07e2280a332bd9c1a7f4dd15b9b6c13
Message-Id: <155745600207.30349.746499813986574941.pr-tracker-bot@kernel.org>
Date:   Fri, 10 May 2019 02:40:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 10 May 2019 03:33:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ea5b2abd07e2280a332bd9c1a7f4dd15b9b6c13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
