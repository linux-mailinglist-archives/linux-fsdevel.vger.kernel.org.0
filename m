Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B25AC120
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 22:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390311AbfIFUAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 16:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfIFUAC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:00:02 -0400
Subject: Re: [GIT PULL] configfs fixes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567800001;
        bh=Mp/oAOjhpYcaOkvUcbGV3VSePN/KAkSXNpuCoN72zu8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IOnfz48kFnBSz+ag/5Xn4p2DJZEpDdeZdqOqPzq1OFDZZvkAChbAfQTFH284W9Pbb
         ok2KJF0ruL+l5R1vnOJlTK8szRvvgEGX7gmAzR2N7jLyhE0BI9Hv8Dtga8o19DVzRf
         5m+E/bOKMvtHhR4UqvW7qJiHXyrVmzw9bINJLF+Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190906155650.GA32004@infradead.org>
References: <20190906155650.GA32004@infradead.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190906155650.GA32004@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/configfs.git
 tags/configfs-for-5.3
X-PR-Tracked-Commit-Id: b0841eefd9693827afb9888235e26ddd098f9cef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30d7030b2fb39d9b53270b2fe0caac8e8792890c
Message-Id: <156780000153.21952.2583030971241850317.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Sep 2019 20:00:01 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joel Becker <jlbec@evilplan.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 6 Sep 2019 17:56:50 +0200:

> git://git.infradead.org/users/hch/configfs.git tags/configfs-for-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30d7030b2fb39d9b53270b2fe0caac8e8792890c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
