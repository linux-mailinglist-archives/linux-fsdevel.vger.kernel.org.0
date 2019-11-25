Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4059F10959E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 23:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKYWpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 17:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfKYWpC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 17:45:02 -0500
Subject: Re: [GIT PULL] fscrypt updates for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574721902;
        bh=AXP7zQMapTN1rWqrZDwdb3wcRiMjJxVjBSUx1h+liqY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f9AlqeliSTi2q+Z5YE7YxcEWbjXZMvGJhzMVylW3dD8QZvEoai2ZvVOk0flLPy82f
         0zjKG7wasISlpZIYVBFxEOuITOEy0AgNQJhLZ7OWFVFGm2b7n2jffMHyrpafDCMm75
         VOMjbO6obTXmLy/oBkvIobk6BkMlRnz+IZ4v+obM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125044122.GA9817@sol.localdomain>
References: <20191125044122.GA9817@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125044122.GA9817@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 0eee17e3322625b87ce5fa631bda16562a8dc494
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea4b71bc0bb646f811e4728389485f1d0522f7ea
Message-Id: <157472190221.22729.18046740901098864621.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Nov 2019 22:45:02 +0000
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

The pull request you sent on Sun, 24 Nov 2019 20:41:22 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea4b71bc0bb646f811e4728389485f1d0522f7ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
