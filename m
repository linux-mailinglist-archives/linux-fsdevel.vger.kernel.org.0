Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DC2501B70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 21:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344972AbiDNTBb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 15:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344820AbiDNTBa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D59AE8879;
        Thu, 14 Apr 2022 11:59:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDF87618AC;
        Thu, 14 Apr 2022 18:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52A6BC385A1;
        Thu, 14 Apr 2022 18:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649962744;
        bh=x/weOCQCdvFtzXlyiWa6EIeco2L9fkCRTJx4jP9BVB8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qZeSw6bL4FtjZRW3tzVe2uFuhoR3SUjEm3HOUGziwpkmqJ1Pk7NB1/leWB8ZiBMGt
         Rft4mPS/efypPjma7PByAB+7ON1sYITnhY/WoUiy2AwgU/q/GdJ8YF2gQmgKUAyvLx
         OCxTo0FxIjd3hwSmaKEmrqehfb8lBhOd1wqHt15t7RZlJDDeBVtb2W36+rlWGDuxOi
         GQp2nMlwK8Brl6cK/rqWJ0r0eT2n0OMwsXHdv/Hed6T8cCOuwDJY8P4NN/56W8ueht
         /ABZcHckXUHG/0zUMQ/dwP45qjN1bgAPCrHlaEAJC8VyhlaNahvzi95euV6qjAtopu
         zyH9IFhcju24g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E806E85D15;
        Thu, 14 Apr 2022 18:59:04 +0000 (UTC)
Subject: Re: [GIT PULL] fscache: Miscellaneous fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2266868.1649864097@warthog.procyon.org.uk>
References: <2266868.1649864097@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2266868.1649864097@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20220413
X-PR-Tracked-Commit-Id: 61132ceeda723d2c48cbc2610ca3213a7fcb083b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec9c57a7328b178918aa3124f989060bc5624a3f
Message-Id: <164996274424.15440.4867741345263392092.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Apr 2022 18:59:04 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        Dave Wysochanski <dwysocha@redhat.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>, Jeff Layton <jlayton@kernel.org>,
        linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 13 Apr 2022 16:34:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20220413

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec9c57a7328b178918aa3124f989060bc5624a3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
