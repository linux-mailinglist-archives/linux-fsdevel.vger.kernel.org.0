Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A777323A767
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 15:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgHCNWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 09:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgHCNWs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:22:48 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CDF206DA;
        Mon,  3 Aug 2020 13:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596460967;
        bh=ufsL/pmWSkngby8zuQJiW/P+em3p9n7UYjlbBqngg+M=;
        h=Subject:From:To:Cc:Date:From;
        b=QbZjVL4iBwJgcqvXVR1Yqhu2PzHPcTAM+hNSQ0Pa9kdp3yP2CnzSeV8jRSjcOhLQ0
         MVEH1wd2aLLvJwePqcC9Z4fXaS3lzh+BAShZG5A6zon8wvZ1CL7AvLUphT/d+CL/C8
         YUn0cYYFhZrwovYq4+96Z9AcszoH9Q+7OfZYCWaQ=
Message-ID: <56a44e097a1408a6bf593270bc5e5d4bcc8b3766.camel@kernel.org>
Subject: [GIT PULL] file locking fix for 5.9
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     yangerkun <yangerkun@huawei.com>,
        Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 03 Aug 2020 09:22:46 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/filelock-v5.9-1

for you to fetch changes up to 5ef159681309621aa8fe06d94397b85b51974d55:

  locks: add locks_move_blocks in posix_lock_inode (2020-06-02 12:08:25 -0400)

----------------------------------------------------------------
Hi Linus,

Just a single, one-line patch to fix an inefficiency in the posix
locking code that can lead to it doing more wakeups than necessary.

Thanks!
Jeff
----------------------------------------------------------------
yangerkun (1):
      locks: add locks_move_blocks in posix_lock_inode

 fs/locks.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Jeff Layton <jlayton@kernel.org>

