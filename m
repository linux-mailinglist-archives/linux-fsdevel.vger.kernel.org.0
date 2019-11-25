Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7DDB1095AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 23:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfKYWpW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 17:45:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfKYWpD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 17:45:03 -0500
Subject: Re: [GIT PULL] fsverity updates for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574721902;
        bh=iBG0BodDs0Gwe2XN+3tSn6/CzKDz6Y3Hq1qD3RP8fVM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DtDsSrUSnwwRHJAs7q+wn7NCy+oJCewmy6M4mKnDLa+fekgv+KY8iLupXJKXPmKtA
         fIp/hp484Qs8GDHFCzdKv6pW4DBnmxFSwhFsgb1CnOsQhgThquEGZWqucgX1gUkZvS
         Omu3s1Fbv+nmbK84xJ+WeEVZMb7Lip6E4uFdlcyI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125044503.GB9817@sol.localdomain>
References: <20191125044503.GB9817@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125044503.GB9817@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 73f0ec02d670a61afcef49bc0a74d42e324276ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c1ff4836fdab94c7c15b23be57bf64c1e56a36f
Message-Id: <157472190253.22729.6647142236304424052.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Nov 2019 22:45:02 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 24 Nov 2019 20:45:03 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c1ff4836fdab94c7c15b23be57bf64c1e56a36f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
