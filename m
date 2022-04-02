Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1934EFE14
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 05:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbiDBDJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 23:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237727AbiDBDJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 23:09:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC334993A;
        Fri,  1 Apr 2022 20:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29A9661CC7;
        Sat,  2 Apr 2022 03:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D4BDC34112;
        Sat,  2 Apr 2022 03:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648868867;
        bh=FWiyUXXQ4A0bXUQH/XkSyDgAb5wHgSW6Lc5+saPfdhc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gwvrrel4vacutRQ8y71munrjHotxmpeSQvwYcAEk3Uck3GK2Mj9yDtzfuPhzZcztj
         OGnBGZz49zRNfulzOV25RxhDQtPp/22zmA8PGrzLnqHk7Oc35E/tMrAr3goxx0W5Wr
         vyml8m5AnACooB+YITB/DJmc/0rKb/xfziVEz8yUF5zTlahqFMKmQIFvOKYTweDHGb
         PuIFvT2bol6Hft2CFOtqDAJ7BscQuPPW1kL0dLE9noS5wi8GgDfHn9oVTgfj//UsH6
         ppCNKhkmlce9SWDx7RblMwZYyu8gLc+okz3VN05LKirdE9W53vgsPp3RWgd6FC31ki
         BK+71/lZnSyZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 781DBE6BBCA;
        Sat,  2 Apr 2022 03:07:47 +0000 (UTC)
Subject: Re: [GIT PULL] vfs: fixes for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220402010338.GP27690@magnolia>
References: <20220402010338.GP27690@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220402010338.GP27690@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.18-merge-1
X-PR-Tracked-Commit-Id: 49df34221804cfd6384135b28b03c9461a31d024
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4251ab9896cefd75926b11c45aa477f8464cdec
Message-Id: <164886886748.20951.15563111126876313060.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Apr 2022 03:07:47 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 1 Apr 2022 18:03:38 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.18-merge-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4251ab9896cefd75926b11c45aa477f8464cdec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
