Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056D41EAFA4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 21:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgFATfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 15:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbgFATfC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:35:02 -0400
Subject: Re: [GIT PULL] fscrypt updates for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591040102;
        bh=tUb3ekvU9GlhHcK4V45Bi06IqlKQCN2nkMKHtfMvVso=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yHvB5tN0rf5bOSh4MLRjHoZIDvOq9AuIa+SvvQM835LQ3dji88L4esQeK5PxwflsZ
         Pn1NWQtfhceZty02BxQswjwaz1BD9yMQes3bkD+u6u3Y4N/8sorEca/tPkgqYMt18X
         0yq63fhTUl5lLCN8EgZBcRiXy0ph3hrjk6GWXspY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601062848.GA11054@sol.localdomain>
References: <20200601062848.GA11054@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601062848.GA11054@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: e3b1078bedd323df343894a27eb3b3c34944dfd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afdb0f2ec57d4899eda2c5e09fc3a005f2119690
Message-Id: <159104010228.18844.5659318322191292629.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 19:35:02 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 31 May 2020 23:28:48 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afdb0f2ec57d4899eda2c5e09fc3a005f2119690

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
