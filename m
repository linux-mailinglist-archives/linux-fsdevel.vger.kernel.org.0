Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2813FCE09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 22:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240983AbhHaTxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 15:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238633AbhHaTxk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 15:53:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0DF9A61074;
        Tue, 31 Aug 2021 19:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630439565;
        bh=sbJcIfu7MdpaMZcH2QMHjf2QlSaDrA0KiusoLU8bS4Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rVqXVCoJyeO1iTvEJo+uBQqLnaR+v8NX9fd2ShZHs8SJcKsywIEC87duE8T5fSr6u
         2J5IgqIumQtySNidp5zR1VgzIgpnjl9ozeustmZWDLT85hsjyA+ricNIFFU2l9OOTD
         qEV4eDP+xMOzpQqNofAhnGCmrnnMF8xHzqNZHxMQxkRrwlQQRm+qV5SLG5j4x9kJhS
         t7J3gMihaS/lareuuun5pdVf64leC0Efb0gcYXSUHz1GwdLzrMYNj3K2Wi8UKr4gRf
         boDFSveRNrekIwAKZZFNOmDawzgl883oX+OFmk6bOJqQQ4fh3xuT2OPxsf8gQRlwM8
         BlmdNUqA3L2JQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 098D560A6F;
        Tue, 31 Aug 2021 19:52:45 +0000 (UTC)
Subject: Re: [GIT PULL] idmapped updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210831100252.2298022-1-christian.brauner@ubuntu.com>
References: <20210831100252.2298022-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210831100252.2298022-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.v5.15
X-PR-Tracked-Commit-Id: ad19607a90b29eef044660aba92a2a2d63b1e977
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67b03f93a30facabf105b8b8632e3b9b6ef9200a
Message-Id: <163043956503.8865.1335172445062378275.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 19:52:45 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 12:02:52 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67b03f93a30facabf105b8b8632e3b9b6ef9200a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
