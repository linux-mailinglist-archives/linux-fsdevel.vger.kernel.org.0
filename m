Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB944407F73
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Sep 2021 20:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbhILSmd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Sep 2021 14:42:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232959AbhILSmd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Sep 2021 14:42:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 893CF6101E;
        Sun, 12 Sep 2021 18:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631472078;
        bh=da0N1vDTDaCg3IL9J1BbgWEzZru7UmcEmVhMgcKMXXY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rTWbQa8TtGMjA9LptgXT7LjEIKMB57y+UqrfQU8A9QjUVgUHSkLcZt9hUGQEWUi+q
         xXT9dMjioaEp3zxXdQByuuKl+RpZIwzqOsamQjEKOjPllWILSsuLSyydo5E8UPKnlB
         6qmpHF+9BkZsNe+qi+7JTEVwGSFf7bgwaCJncxFSJKZkC3CAHgpz7Q1LEVUMOboYjz
         R7/u5drtY5FK3Ud1LRuYPZyCvVUfIwezowcZP2/ff6Ub2qTnLzWid/Oz0P7xA5mJEe
         Bpx7sMmf3MqBcoUGCEnsNCKA/6zPk7wkrJ4C3/cRP372iSdjE9gbhJe4WuOZlzOHbs
         KSHkYA8IASHhA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 833DD60A47;
        Sun, 12 Sep 2021 18:41:18 +0000 (UTC)
Subject: Re: [git pull] namei fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YT4KzvXdKg6fJGk3@zeniv-ca.linux.org.uk>
References: <YT4KzvXdKg6fJGk3@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YT4KzvXdKg6fJGk3@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git misc.namei
X-PR-Tracked-Commit-Id: ea47ab111669b187808b3080602788dec26cb9bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fdfc346302a7b63e3d5b9168be74bb12b1975999
Message-Id: <163147207853.12542.8464326457721927737.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Sep 2021 18:41:18 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 12 Sep 2021 14:12:30 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git misc.namei

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fdfc346302a7b63e3d5b9168be74bb12b1975999

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
