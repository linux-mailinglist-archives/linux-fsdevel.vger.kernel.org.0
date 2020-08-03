Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A011F23ABE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 19:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgHCRzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 13:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbgHCRzE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:55:04 -0400
Subject: Re: [GIT PULL] file locking fix for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596477303;
        bh=64N0MF51YRsF4m4Bz4Qx3RoipKM/AU+s7LH+wHF3By4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ucEvz2XjDi60PzMWMhU5vEuHk0pCmyRkRC+iaUls4TuMxM0RVJ3LE4y7Yq4P2Qsf0
         umns+CxUQ0RTgzQNySDe+DYN4yoeSLhhi2XvUMyPJ37f+4nPBBQ8XORvnEjISTHFOB
         NxgOL6TQsBQc2qzVYrD0nsfJj2J08WK8pUGdammU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <56a44e097a1408a6bf593270bc5e5d4bcc8b3766.camel@kernel.org>
References: <56a44e097a1408a6bf593270bc5e5d4bcc8b3766.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <56a44e097a1408a6bf593270bc5e5d4bcc8b3766.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
 tags/filelock-v5.9-1
X-PR-Tracked-Commit-Id: 5ef159681309621aa8fe06d94397b85b51974d55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3208167a865e862fff5045d7910387941ff7e114
Message-Id: <159647730351.19506.4382570710178556452.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 17:55:03 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        yangerkun <yangerkun@huawei.com>,
        Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 03 Aug 2020 09:22:46 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/filelock-v5.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3208167a865e862fff5045d7910387941ff7e114

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
