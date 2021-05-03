Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FDA371F5F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 20:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhECSPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 14:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhECSPJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 14:15:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8588161059;
        Mon,  3 May 2021 18:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620065655;
        bh=stKaPt01rR1JQSZUn7K/9xKGvwwbh5Ab6oNp7uwqoLk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cuUOmMvG7+R5OpwmAADuqc6WXvZmsAT9HEw4PLxUO13asI5NpO47Ogy41B4RnjKoy
         yPBPCJhDYaj6+n9h6n4C7wO8ECcea8KfpzZ98/8afKIxzzcPLXlDkVTt4K3+OFrrMy
         qUc+JR7pXQex10Kdq5lw1kGoofnqcmcrSNIeJjS7KwgQtsbVpl6QhlHhp+mqS9XkXS
         kz1AeX9Uu4BJOBraAg+mH/8+YvXCNGM4pPMI8hARYtafdliLMSxic6/8xn7M06lVUv
         c6PPeJH9hHMAlQLTzxbx5g0vKjMRjEDNR68j9q4+M0ylJS93GCfm0D3lpaMiV8Grm3
         o6k83ms0ST+sQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 75037609E9;
        Mon,  3 May 2021 18:14:15 +0000 (UTC)
Subject: Re: [git pull] #work.file
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YJAzG9Xur8Dk1OnY@zeniv-ca.linux.org.uk>
References: <YJAzG9Xur8Dk1OnY@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YJAzG9Xur8Dk1OnY@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.file
X-PR-Tracked-Commit-Id: 42eb0d54c08a0331d6d295420f602237968d792b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23806a3e960048f8191ce0d02ff8d5f70e87ad4b
Message-Id: <162006565541.30353.2607690954040907735.pr-tracker-bot@kernel.org>
Date:   Mon, 03 May 2021 18:14:15 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 3 May 2021 17:30:03 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.file

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23806a3e960048f8191ce0d02ff8d5f70e87ad4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
