Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB35523ABED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 19:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgHCRzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 13:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728551AbgHCRzC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:55:02 -0400
Subject: Re: [GIT PULL] fscrypt updates for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596477301;
        bh=zoMh0nl23+pSyDpQtAkLlOsvsO3R3HRl5QxOs9dNUU4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TLwaIfx0FGEcrWa8IyQvq9a7sCFcL5Hs9++NjdORSBd7cBQh+tigrF0hl0ngo8WQv
         vViE81VquM5FAC4FsrHj6uUDYR347M8nqGW1qLlkaix7hcIlIieNBfM4t7Ert75B2h
         X9nZpi7wEgte2Q41n4BAtsH35GnoWdJy86VK6eFI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803070547.GA24480@sol.localdomain>
References: <20200803070547.GA24480@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803070547.GA24480@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 55e32c54bbd5741cad462c9ee00c453c72fa74b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 690b25675f5c9c082cb1b902e6d21dd956754e7e
Message-Id: <159647730140.19506.4501237993165044273.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 17:55:01 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Satya Tangirala <satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 00:05:47 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/690b25675f5c9c082cb1b902e6d21dd956754e7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
