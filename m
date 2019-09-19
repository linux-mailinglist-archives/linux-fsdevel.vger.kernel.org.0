Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC410B6FFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 02:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbfISAUO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 20:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387406AbfISAUO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:20:14 -0400
Subject: Re: [GIT PULL] fscrypt updates for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568852414;
        bh=yjrMrZgFDuzZIDBYejuK7WbX6ZxavGonE0Fw0AE6YFE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u/9kfsaaTOjpp0bZA1iRqq6nN4zJLUN/1/SNh+v+qe9YXzc2Ca+u3dso6QVFN/gmM
         x/WVD/PvZNHoOnVexKj3THcrCpjM50hLYUpUQIuhEFuSETtQg6NeIcD+fGJujmcthZ
         XpigmechV44m7Y6bDzM43DzQjvPyrsiNFM1ulPBs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916044258.GA8269@sol.localdomain>
References: <20190916044258.GA8269@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916044258.GA8269@sol.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 0642ea2409f3bfa105570e12854b8e2628db6835
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 734d1ed83e1f9b7bafb650033fb87c657858cf5b
Message-Id: <156885240309.15091.17264386602149266891.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Sep 2019 00:20:03 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 15 Sep 2019 21:42:58 -0700:

> git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/734d1ed83e1f9b7bafb650033fb87c657858cf5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
