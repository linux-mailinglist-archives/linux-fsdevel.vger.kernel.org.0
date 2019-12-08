Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F315116013
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 02:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLHBKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 20:10:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfLHBKI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 20:10:08 -0500
Subject: Re: [GIT PULL] iomap: fixes for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575767408;
        bh=yBoMYWkT55z3FCeHCu2jsXnsX/BLrVBO1+E3nyHFUik=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HreMkKBLF6Wz9vUdmySD9kA5Ai42j+jIu7SRqRa5cpl3jqK/8pVJEu3vxk5+tKVGU
         2O15g7rK8BTX6zp8w45c/P8xPsFPJnA+MWEF6/vUT89+RWk1CqPxnhYpDQNtQMYZr4
         QZX2lyuprPRTeEzRQ/BZ2Yr6tSGYlsFro8th6vIA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191206195456.GB9464@magnolia>
References: <20191206195456.GB9464@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191206195456.GB9464@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/iomap-5.5-merge-14
X-PR-Tracked-Commit-Id: c275779ff2dd51c96eaae04fac5d766421d6c596
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95207d554b968a552cc93a834af6c1ec295ebaba
Message-Id: <157576740828.7292.11243463351730365173.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Dec 2019 01:10:08 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, agruenba@redhat.com,
        rpeterso@redhat.com, cluster-devel@redhat.com,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 6 Dec 2019 11:54:56 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.5-merge-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95207d554b968a552cc93a834af6c1ec295ebaba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
