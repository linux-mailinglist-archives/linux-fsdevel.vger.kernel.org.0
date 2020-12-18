Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB412DEA8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 21:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgLRUzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 15:55:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgLRUzR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 15:55:17 -0500
Subject: Re: [GIT PULL] xfs: new code for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608324876;
        bh=/EZMjwCMh/Ud9L/N29ElYrTIvm99/Kz8CeiNdOYCORw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=B1UBmA+iCgeib63dlTpbpaRyqaGefMHvSuhTiLEdvfpVgOUlh6yYgzBVVWcNzyHeP
         2K2p+cD9g07DTUsxQ7rwVCwT1gmJVIyYa6zATfQ0f58SV0Tra+jRQnrdnlff5y3UHN
         +hdlKutCyu/arWbjp4ClpY6xB/TvMKhYO8kSQYC6s+z9ZlqzsdrsUzAX7o7BLjGjVj
         S345w4LndTynEQsh3aDqGiFQMaspWPtzOe4OZaAtqlykno/TMiXNwtYJurZ+6yuq7K
         FVNXlQdB0qTchM/y0dZX4OAjsO+2SNi21oL5cHet8a4gZ1eZ4LDT627HtAzIUV/MML
         fd68TF63Dbdkg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201218171242.GH6918@magnolia>
References: <20201218171242.GH6918@magnolia>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201218171242.GH6918@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.11-merge-4
X-PR-Tracked-Commit-Id: e82226138b20d4f638426413e83c6b5db532c6a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0b96314870f7eff6d15a242cb162dfc46b3c284
Message-Id: <160832487637.19372.7448008445325982345.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Dec 2020 20:54:36 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 18 Dec 2020 09:12:42 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.11-merge-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0b96314870f7eff6d15a242cb162dfc46b3c284

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
