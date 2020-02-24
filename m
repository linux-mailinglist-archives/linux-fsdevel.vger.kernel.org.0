Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB55616B0EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 21:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgBXUZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 15:25:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgBXUZD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:25:03 -0500
Subject: Re: [git pull] vfs.git fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582575903;
        bh=oisAD9tMq5d5kXXXzZfh97L19gwIy1AWlqqeixm3LTE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0n3YCpKfuwf2qfgjhDDQFQhcvWPeebuWNvrWLVH6PabeLivd+bqmd2zTXIpbGPJXO
         kJ2o6qnNSPBywg/FB8m7KrDFdwLrLdh9q61T0ilXZYNm4pOvG6S6y5bYsI7J+jAc2a
         2cWbPTegnv3vhYs7ANnKv9n3qweQaud8VuDb0mME=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200224002241.GA23230@ZenIV.linux.org.uk>
References: <20200224002241.GA23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200224002241.GA23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: bf4498ad3f9a0f7202cf90e52b5ce9bb31700b91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc570c14b260946a66e13882eace862dc6eb16f8
Message-Id: <158257590316.9578.11347867378764271819.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Feb 2020 20:25:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 24 Feb 2020 00:22:41 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc570c14b260946a66e13882eace862dc6eb16f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
