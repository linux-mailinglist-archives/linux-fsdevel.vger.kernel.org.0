Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEFF371F60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 20:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhECSPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 14:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhECSPJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 14:15:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C5EDE611AC;
        Mon,  3 May 2021 18:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620065655;
        bh=3vlTIOiu8yrkS/0CL88cn+MHmMqveg1l6DhRjWHclxA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e9VhW2otwERMAn64I9+MzKHnCQSygD6UEJRKvsbPO+E2E/zNyjvWJKn0mkw1RHmXA
         VnbravqIttwIcO5tHdr5zlQ+qEV5ZvZ/Bcso1lVP/KfOSSMfrSI7Pzat9MF05eregY
         playZY092ri2LQacsGj4xEf4XyqyexuEkcvCXWSaUTOnU7jpxBe+H7s8YDkWUQOYtz
         kB/Bonnw2bG1cylR/Bfi42ASuiOZm82nb+6BPlEkfNnKYEj5jk2XBGJ1LwFBZjH0IA
         4pzw3rFLRgYNilLdaCtKcgibewv7QRVfpIqD5pi63vO5SYbRO8H79YJRAJ2bzShNLk
         YTyoWPBVUlAew==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C1411609D9;
        Mon,  3 May 2021 18:14:15 +0000 (UTC)
Subject: Re: [git pull] more simple_recursive_removal() stuff
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YJAzn3u9tGXYIt+i@zeniv-ca.linux.org.uk>
References: <YJAzn3u9tGXYIt+i@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YJAzn3u9tGXYIt+i@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.recursive_removal
X-PR-Tracked-Commit-Id: e41d237818598c0b17458b4d0416b091a7959e55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f8ee8d36d076b517028b60911877e27bc1d8363
Message-Id: <162006565578.30353.10474452558920498618.pr-tracker-bot@kernel.org>
Date:   Mon, 03 May 2021 18:14:15 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 3 May 2021 17:32:15 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.recursive_removal

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f8ee8d36d076b517028b60911877e27bc1d8363

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
