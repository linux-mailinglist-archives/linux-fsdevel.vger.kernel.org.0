Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B601EC803
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 05:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgFCDuk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 23:50:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgFCDuF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:50:05 -0400
Subject: Re: [GIT PULL] vfs: improve DAX behavior for 5.8, part 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591156204;
        bh=4tH55mVl+et4vYGo20G5wKfRLoAuoi+9oKOHSEGHMXE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=V0IF9AN7bXf5uDc6cvMZVF2KgJwNSKMRClU88/4DZNCkEnR3K5VDgcV7MkLc2zfnH
         8PWyPv2CYgcX2tsfk/HoPN8dzwu2YlYxKVL0QuZ+b3bahIpvn7vTOI40ST1VSaUaj0
         9XM+W1k811ZD4ndV7BxT4EynzWUf3YVttr9tiO+U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200602172550.GF8204@magnolia>
References: <20200602172550.GF8204@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200602172550.GF8204@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/vfs-5.8-merge-2
X-PR-Tracked-Commit-Id: 2c567af418e3f9380c2051aada58b4e5a4b5c2ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8eeae5bae1239c030ba0b34cac97ebd5e7ec1886
Message-Id: <159115620468.30123.15334674165284603589.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 03:50:04 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, ira.weiny@intel.com
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 2 Jun 2020 10:25:50 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.8-merge-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8eeae5bae1239c030ba0b34cac97ebd5e7ec1886

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
