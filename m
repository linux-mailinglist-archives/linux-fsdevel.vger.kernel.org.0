Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03D7619CB18
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 22:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390167AbgDBUZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 16:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389588AbgDBUZE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:25:04 -0400
Subject: Re: [git pull] vfs.git pathwalk sanitizing
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585859103;
        bh=9zKOneaNbe3WFi/I+f8XBuM9GaHulXKcXFpHcHNYb6Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2Kbyk5kEr9qCIFWWdFsWNJ5o2MFTvzHn6sH0EFPFWXq9Szr8w6sIWgkUZ7i69uOvJ
         fICZCY4cmR7LqNQ6uzaUNHcmPAH/AtFz9AusgukRHK5wjnTkecKKzgLo5oLdGRF7R9
         WnnxDumetJa8QRPGQlAWadpXJ8wWfVntgUzvreoA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200402052414.GE23230@ZenIV.linux.org.uk>
References: <20200402052414.GE23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200402052414.GE23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dotdot1
X-PR-Tracked-Commit-Id: 99a4a90c8e9337e364136393286544e3753673c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c577491b985e1b27995abe69b32b041893798cf
Message-Id: <158585910370.7195.18418854991270255576.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Apr 2020 20:25:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 2 Apr 2020 06:24:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dotdot1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c577491b985e1b27995abe69b32b041893798cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
