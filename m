Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465DB4179E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 19:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344302AbhIXRfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 13:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343937AbhIXRfT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:35:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CA2176105A;
        Fri, 24 Sep 2021 17:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632504825;
        bh=ewmkPWrtWahwyJiIva66kKZ0/Nl9yfW5h9+eMFdvSxg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DKw5eHSfPGr8Ea//tDKBX4z6mk00724KRW7+0rKFB2ogt/411H15yrvHhWOdGPDBy
         rbPfW/eECPH/9QLe0uR8h06bA0fd7/+H4sAOT+j08abQavxSfPCpKObUlpkVSxjcBI
         Lw4cW7/UkM/3xrCdoYcGxUOfiNUqfOFhWze/r4zYIPNpFbUq+8trtPBkupW57Kf6eD
         W6swQZ6bD9CnvpwL3JtYp1krGJiXTeYWH6L9KOJECNs/f8SExGItY083UaXm2vxz2u
         r88xk3nyx/CIprH0EK6A3CLFXkDsAOP6GK/TBixF2oZGoTf85kY36E9myyqrPDUuAv
         LSKZ8VjU9YiRQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B5DA560A88;
        Fri, 24 Sep 2021 17:33:45 +0000 (UTC)
Subject: Re: [git pull] a couple of do_mounts.c followups
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YUv7mXzzl/JxZ6te@zeniv-ca.linux.org.uk>
References: <YUv7mXzzl/JxZ6te@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YUv7mXzzl/JxZ6te@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.init
X-PR-Tracked-Commit-Id: 40c8ee67cfc49d00a13ccbf542e307b6b5421ad3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a801695f68f40e75e47ed292bc9aaab815814b53
Message-Id: <163250482567.13479.13250371838899903701.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Sep 2021 17:33:45 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 23 Sep 2021 03:59:21 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.init

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a801695f68f40e75e47ed292bc9aaab815814b53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
