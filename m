Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81CB318236D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 21:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgCKUpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 16:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgCKUpB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:45:01 -0400
Subject: Re: [GIT PULL] fscrypt fix for v5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583959502;
        bh=BpqMPqVMEExHAmwE9Beff6FPwRMgQuXwVzkTYS3rtlU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Xs0c8KJMFvlIzYcA40MhFlGm1IOWy8yJpK+Fr+m+FqJo0T4F6QMhQO5I8brlBTQQ9
         uN96LInyTlX1axYS0S+hFluaPchZGwlMsSGXC1kNPWesIoYBt+wReS3ilar28gicxk
         whhVJL8+3q1awpkbNsNhFivAMtRZl/XbkoeJm9ig=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200311194839.GB41227@sol.localdomain>
References: <20200311194839.GB41227@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200311194839.GB41227@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 2b4eae95c7361e0a147b838715c8baa1380a428f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6e6ec48dd0fa12e8a2d1ff6b55cd907401bd7fe
Message-Id: <158395950136.14877.831369511825672693.pr-tracker-bot@kernel.org>
Date:   Wed, 11 Mar 2020 20:45:01 +0000
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

The pull request you sent on Wed, 11 Mar 2020 12:48:39 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6e6ec48dd0fa12e8a2d1ff6b55cd907401bd7fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
