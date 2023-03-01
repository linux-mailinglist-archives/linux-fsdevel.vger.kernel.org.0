Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1366A6413
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 01:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCAANr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 19:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCAANm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:13:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1660037F02;
        Tue, 28 Feb 2023 16:13:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8E8A61213;
        Wed,  1 Mar 2023 00:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CAE9C4339B;
        Wed,  1 Mar 2023 00:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677629621;
        bh=5cl1V6dcStcrN5DZsvs6IOJQhl7uablYH2MtKO1xfs0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F2OrRmr4VYgvpqyAqH8piry/Hm2360tdfIdaEWHz/+QtY9gMan1XCoQnn4Dry1smV
         s+Y31Ntt2ovzTl9bFqXNedz+NQSnVbCVGc4+SznqbumE5vhE9oww29bVmxrcyBWqVo
         MZGPbEEdJ+KhUtqWzQkjHupKdWre/tE5p8sLwHr8DIGex8WtjDI+sBBJvKcw93+TRH
         mRXc00aS7Likx/W1Z/2Va9mmxxbldzFbNcsTHAWZxr4oPmJ5tucP0axKABxwOZ2piq
         +X6+o4jCp8RGCQ4H2MsU3zUP0I7mM8E0WZjoTn96xAoCchljaMUVHJ81okIK6+sd2o
         kPbkwa96RmZKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02E68C59A4C;
        Wed,  1 Mar 2023 00:13:41 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: moar new code for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167762780388.3622158.16184008545274432486.stg-ugh@magnolia>
References: <167762780388.3622158.16184008545274432486.stg-ugh@magnolia>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <167762780388.3622158.16184008545274432486.stg-ugh@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.3-merge-4
X-PR-Tracked-Commit-Id: 6e2985c938e8b765b3de299c561d87f98330c546
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
Message-Id: <167762962100.26350.7173920358971274450.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Mar 2023 00:13:41 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     djwong@kernel.org, torvalds@linux-foundation.org,
        allison.henderson@oracle.com, dchinner@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzbot+090ae72d552e6bd93cfe@syzkaller.appspotmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 28 Feb 2023 15:46:53 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.3-merge-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0927a7a5391f7d8e593e5e50ead7505a23cadf9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
