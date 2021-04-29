Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D0436EF67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 20:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbhD2STM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 14:19:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241003AbhD2STL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:19:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id ECEA461450;
        Thu, 29 Apr 2021 18:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619720304;
        bh=hPsQNfL0GKLaYvKQA2YOwpV1ujQec566IiI/Q1jG9/o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cWoS3bggqV0uBKt0nbLuIKzsvzMZjsB9al5eL+a8YKY47RmOAbnEUyqU/YlEXX13t
         MTG7iz4rVjNYW8kSF1C7iyBVXxd5vj9DiFopJzb4ka8vh1zfmc8WqLICqDYZQzG/6t
         IdX71XQNHo4N+c2yXOVy5np0WoOneKNm7Vte37mmXD+JjAsU09cS2//KPPK+G4Uxnu
         eYl6ZoXhd/uGf5Z7tZEIu4PZR/fFh1BI7N1gSjGUEQw35uUQypf94+8CW3W1GzIjk7
         zKYzYBJVDhqLRZtpP6mCkjLOKf7dZ+yDr4VizkVEXRKgPa4P+RLpWsJrv5Xigo8NBG
         EfERqLrla86Mg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DC3AC60A36;
        Thu, 29 Apr 2021 18:18:23 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify changes for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210428121956.GB25222@quack2.suse.cz>
References: <20210428121956.GB25222@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210428121956.GB25222@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.13-rc1
X-PR-Tracked-Commit-Id: 59cda49ecf6c9a32fae4942420701b6e087204f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3644286f6cbcea86f6fa4d308e7ac06bf2a3715a
Message-Id: <161972030383.24326.18189916522328268210.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Apr 2021 18:18:23 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 28 Apr 2021 14:19:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3644286f6cbcea86f6fa4d308e7ac06bf2a3715a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
