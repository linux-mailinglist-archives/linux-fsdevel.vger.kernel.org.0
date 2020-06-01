Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719921EAFA5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 21:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgFATfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 15:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbgFATfD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:35:03 -0400
Subject: Re: [GIT PULL] fsverity updates for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591040103;
        bh=FG5YZrumuxu+SUe9tE67sVQlsmLyNC7e800RwFody5U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KeExiaz9m5h879IZ1BEQl3nEkk8hevGPTuX/HTBMuE2abZI2ifbmaB5R/CNVUeKdW
         Zy0uNXJWso9ocrLXtq6DWF3YggXoBfGdMb0/UA5DY/dnhFAeX+EgV/wRrplS8o/GUO
         WFI1fbrkwDNfuAwAhSlYazDURGbqszfUUDgf6SE0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601063150.GB11054@sol.localdomain>
References: <20200601063150.GB11054@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601063150.GB11054@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 9cd6b593cfc9eaa476c9a3fa768b08bca73213d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d67829e11863072aec7cd1dd2939b1fd3eda17b
Message-Id: <159104010315.18844.6258170183596402649.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 19:35:03 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 31 May 2020 23:31:50 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d67829e11863072aec7cd1dd2939b1fd3eda17b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
