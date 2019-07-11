Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E688C65135
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 06:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfGKEkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 00:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbfGKEkG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 00:40:06 -0400
Subject: Re: [GIT PULL] vfs: fix copy_file_range bad behavior
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562820005;
        bh=HzbaSkYNegZPeSfETFSWpJVZw37iuQryRylnFNyVoho=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2kiiJXkLYKRmVPp18hhQnoxezHW0gx4//6wm4gS6dbIb1mMmZn2WOyREjG4DW9Kkv
         NeN1z9X9q+coFZmbh+Hjep5r2a7LfeBO9BxNcygm9chUuu3xSxjCXqAvlNgB86l7bu
         BUC8uU2Hug/V+NmTDAUG7Zcn+qsuiTqceZtUWRiM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190709163947.GE5164@magnolia>
References: <20190709163947.GE5164@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190709163947.GE5164@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/copy-file-range-fixes-1
X-PR-Tracked-Commit-Id: fe0da9c09b2dc448ff781d1426ecb36d145ce51b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40f06c799539739a08a56be8a096f56aeed05731
Message-Id: <156282000553.18259.7365960992420931129.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 04:40:05 +0000
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 9 Jul 2019 09:39:48 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/copy-file-range-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40f06c799539739a08a56be8a096f56aeed05731

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
