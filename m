Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785C823ABEA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 19:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgHCRzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 13:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbgHCRzD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:55:03 -0400
Subject: Re: [GIT PULL] fsverity updates for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596477301;
        bh=F9J1NDKhlGuaR61i60J1kZCqAJQw5HbTND9VwIKUQZw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=p1E5Q+qhC/Ckte/Cs4JZx0YQrT80BjjCjWMFkjy7hr2vR7O9dQ+f8Iljt10f5yf4+
         Ook3zT+75+ndAgojyiZ770s2Sfp38FTOZPqccmXfWr3N7mvxrYJlI3ogJFZLNbH27i
         VQvhWaqNwgxnGc+5N2/ejl7odEAyBYTS60r1xfjc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803070730.GB24480@sol.localdomain>
References: <20200803070730.GB24480@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803070730.GB24480@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: f3db0bed458314a835ccef5ccb130270c5b2cf04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5577416c39652d395a6045677f4f598564aba1cf
Message-Id: <159647730180.19506.8428131408463045290.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 17:55:01 +0000
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

The pull request you sent on Mon, 3 Aug 2020 00:07:30 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5577416c39652d395a6045677f4f598564aba1cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
