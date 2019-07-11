Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D89196513B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 06:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfGKEka (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 00:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbfGKEkE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 00:40:04 -0400
Subject: Re: [GIT PULL] fscrypt updates for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562820003;
        bh=Ba1MrJuwoj0OebbihIv6ZvrlOX7lJzbqKnTEO64A5T0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SLjt1HC1WDPOYSBl7T6hdAO68HB/vASyHd/HtV2/a88dqfbtmAzyQ2xmOJSJoB7lg
         yvPids7WbYJ6L42EtA+4SjvGTi4cQtEl5d77UTcSAGkuOkTCq200dKDUotOoaJAvNT
         5Q3IJNhajEjqyVt8W/3grwe7jt23kT9+WkI9GpjU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708155333.GA722@sol.localdomain>
References: <20190708155333.GA722@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708155333.GA722@sol.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 0564336329f0b03a78221ddf51e52af3665e5720
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25cd6f355dab9d11b7c8a4005867d5a30b8b14ee
Message-Id: <156282000373.18259.5513361785712374150.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 04:40:03 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 08:53:33 -0700:

> git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25cd6f355dab9d11b7c8a4005867d5a30b8b14ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
