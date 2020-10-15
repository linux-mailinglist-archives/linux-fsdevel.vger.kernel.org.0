Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF8F28FB23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 00:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387981AbgJOWUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 18:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731621AbgJOWT0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 18:19:26 -0400
Subject: Re: [GIT PULL] Fix unaligned direct IO read past EOF for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602800366;
        bh=AgJdIHkgZm+pBlRHPhP+Yw70g51fk3eBwYF9wL9G1ws=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2ti//ITMbzwv4G2KhyK+aNWgSGEDVJT4EeVmPN5H9vmwEpomucN9Cs/wYrO4mSv39
         jXoc3CRlIFsGXo7IOVYi2+/UIkEm1ujRDZtjEWes0DGb32m1w6JIPGQfdW7TGFLnL7
         qR3s5QKqJ9C8cGp1V1oDx36FmW2GliSPwK8Fc6VQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201015134213.GH7037@quack2.suse.cz>
References: <20201015134213.GH7037@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201015134213.GH7037@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git dio_for_v5.10-rc1
X-PR-Tracked-Commit-Id: 41b21af388f94baf7433d4e7845703c7275251de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a165feba26547d2aa84a6efc494f3f2729f35b5
Message-Id: <160280036629.16623.4379772617754229749.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 22:19:26 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 15:42:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git dio_for_v5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a165feba26547d2aa84a6efc494f3f2729f35b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
