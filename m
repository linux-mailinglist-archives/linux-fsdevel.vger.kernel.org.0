Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1992414C39F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 00:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgA1XkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 18:40:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgA1XkD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:40:03 -0500
Subject: Re: [GIT PULL] fsverity updates for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580254802;
        bh=9uTx239fooQ7plHBZTD5UrhlEffcj1C8aMwsaCAAq7A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NyIceaZsXCVYbOokVaYNLUJfCu61F+S/qyKlSpWbLDTRehexksnLX99Iv4zylcp+3
         Zy8b8dsSMMMJCa8+nPif1Mov4/azHx09UOn59K+SznaP3Fx2a9+Ip597Aurp4wtrvG
         Av69XK6AbmvHS+YgMHu9oaZ8p+OUcwQsBu0h79dw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128014944.GB960@sol.localdomain>
References: <20200128014944.GB960@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128014944.GB960@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: da3a3da4e6c68459618a1043dcb12b450312a4e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8994374d90b5823b3b29a5e5d8648ac418b57b4
Message-Id: <158025480250.16364.14659123775629628109.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 23:40:02 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 17:49:44 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8994374d90b5823b3b29a5e5d8648ac418b57b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
