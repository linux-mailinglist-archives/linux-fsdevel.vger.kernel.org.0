Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA3828D225
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 18:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389747AbgJMQYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 12:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389732AbgJMQYF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:24:05 -0400
Subject: Re: [GIT PULL] fscrypt updates for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602606244;
        bh=0GDL0FDvlJWyLDYOyGXqNYN79mm0g6czXO6Y14y8hrk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mofhlG7EDLN4Wve2vrb/jiWtdjc82+lqb+c3kTbmI1iFf2xdVgtLjlQf0+l9/MtrC
         sE81COzKRt4L22V5GvwJKgzI+XyZCUsfnYqG3/HK4o0gRIglNXN8s9xuYDCF7C+Van
         fYZnaujwVqmKli37bmbx/DRw8xt2EHPDN/A1MYzs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012163543.GB858@sol.localdomain>
References: <20201012163543.GB858@sol.localdomain>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012163543.GB858@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 5b2a828b98ec1872799b1b4d82113c76a12d594f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f5032a852f9bf3c449db58a9209ba267f11869a
Message-Id: <160260624476.24492.420695043633414876.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 16:24:04 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Daniel Rosenberg <drosen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 09:35:43 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f5032a852f9bf3c449db58a9209ba267f11869a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
