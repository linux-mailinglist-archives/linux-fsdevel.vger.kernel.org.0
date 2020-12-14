Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FCA2DA254
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 22:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503483AbgLNU5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 15:57:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503471AbgLNU5I (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:57:08 -0500
Subject: Re: [GIT PULL] fscrypt updates for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607979388;
        bh=8TA3M2fJC6eWzRxFjGh7dv0C/qOTmpZPhaCxujp6Nhw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GtNRIf8R7iFQLnZ+asV6awJfdvY2iwacFvGd201A+KsaSGv5L+sPRSk+rckYd37BU
         dJsaBrFj+FkiM81+odFK3mOHmVSfJ+V3tTJqvnyyPJOXNiKzmWbBvzazJi5j8hoFeZ
         kGqi7m6jvq6RVjshfQ3tJ1GUoJYgTBZIycDDZXcoa3spz11vvqzIBCWdWhv32tp11n
         KtlE8PlVu2QNUB7EmUFyX3g9IbBzqa26oGodoKh2lc0ouwJ3nRdVEDrIqbXi/URI3t
         EGXoEL1d9kNZSkj6aJr9m7MrYDNdbEBDKvNsz1HmG2hm6Yh83empS9+JWe1XDDi7QB
         3KKEjibp7dU1g==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X9b9G8p8AiRAzDwV@sol.localdomain>
References: <X9b9G8p8AiRAzDwV@sol.localdomain>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <X9b9G8p8AiRAzDwV@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: a14d0b6764917b21ee6fdfd2a8a4c2920fbefcce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c7fdaf6ad9fe868553c2e1fc8a920249820ac3e
Message-Id: <160797938816.26822.16942745095924482464.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Dec 2020 20:56:28 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-ext4@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 13 Dec 2020 21:50:19 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c7fdaf6ad9fe868553c2e1fc8a920249820ac3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
