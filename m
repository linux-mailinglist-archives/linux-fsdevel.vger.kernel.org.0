Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E109C64CFF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 20:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238470AbiLNTRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 14:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbiLNTRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 14:17:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C5A101C1;
        Wed, 14 Dec 2022 11:17:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FD4561857;
        Wed, 14 Dec 2022 19:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63BC3C433EF;
        Wed, 14 Dec 2022 19:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671045419;
        bh=DEU23idWnHqHEI4rr4cJ5kq50LF+J35SVC+UqRvM9lE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NlyNkwFqkxmc5CXq/bwiDo847PTLuhVwCzIC1snqWwE+iQ5IF25BQUp5W8TWMqDVJ
         f65lgjK+GttPScU2kCE0f58+Ufsvd8wcEWcgXhm05/QDC+2JQAg9yFmzjBaGEY1yQB
         K42F+RsGJrQCrUuzWq/occqgR8pYxpDSGlsOxyLorEYrr+9QRiA0MPXxpe2wN+k6th
         SXqlrSb5dQpRw5vU7blc+M0o7h4b9JfNUNFoq//BJCd62Wn2GTu1sz9b01D5fPy9dB
         xeInwVb7nPUv9yy0EZ9FBu8VbivDqNSTBLd3Tc72IMN3bA53MQ2rT/0vPBa5kiJ62p
         QiWbjjS/JU/5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 526CFC41612;
        Wed, 14 Dec 2022 19:16:59 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167095620599.1676030.3465657691717452291.stg-ugh@magnolia>
References: <167095620599.1676030.3465657691717452291.stg-ugh@magnolia>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <167095620599.1676030.3465657691717452291.stg-ugh@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.2-merge-8
X-PR-Tracked-Commit-Id: 52f31ed228212ba572c44e15e818a3a5c74122c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87be949912eedb73690d8eaeb086f24bfe17438d
Message-Id: <167104541932.22233.3380119867797546136.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Dec 2022 19:16:59 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     djwong@kernel.org, torvalds@linux-foundation.org,
        aalbersh@redhat.com, abaci@linux.alibaba.com, dchinner@redhat.com,
        guoxuenan@huawei.com, hch@lst.de, hsiangkao@linux.alibaba.com,
        leo.lilong@huawei.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, lukas@herbolt.com, sandeen@redhat.com,
        syzbot+912776840162c13db1a3@syzkaller.appspotmail.com,
        yang.lee@linux.alibaba.com, yangx.jy@fujitsu.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 13 Dec 2022 10:58:54 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.2-merge-8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87be949912eedb73690d8eaeb086f24bfe17438d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
