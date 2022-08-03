Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA800589464
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 00:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238930AbiHCW3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 18:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238883AbiHCW3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 18:29:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087F75C94B;
        Wed,  3 Aug 2022 15:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AECE9B82404;
        Wed,  3 Aug 2022 22:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54D71C433C1;
        Wed,  3 Aug 2022 22:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659565756;
        bh=40j6OGIpymzlKOOTWxGEug6m13iD/+9fDMv61JhHBho=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UP2xEKMe9dOFdW1+5+tWUYiu8Z1UDEz/rWLgWkh/PfvBaVHXhkA4DfBuOz6OAtDOG
         Y4ApZcnWQXg0For7gVlRFh1MLxFIddK9sDdK4CeP90ZglhyhrNQHqyKXSFNWBTsyxM
         zOBWqnNzetsaV9f1D31cPcKKZa0dDYuFegGuQgv1Q9fZTYsMSu71h9yCc4kVK9RAAL
         xP3cy8z2rrLsoxNQ501a4CneSy/GnwKrZ+/i6qbv1nF1LzjzrqUXK2c9Y1SvzkexmK
         FbIJZv3N931KfPOuhfSkc/R+kYoXRDOBtlydggBmhqrmfYh0R3AO0+/8b+S/2l+Xvl
         yGEvX7dDe86Lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4503CC43142;
        Wed,  3 Aug 2022 22:29:16 +0000 (UTC)
Subject: Re: [GIT PULL] iomap: new code for 5.20, part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YuqV6qB/p69HL3yR@magnolia>
References: <YuqV6qB/p69HL3yR@magnolia>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuqV6qB/p69HL3yR@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.20-merge-1
X-PR-Tracked-Commit-Id: f8189d5d5fbf082786fb91c549f5127f23daec09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f18d73096c0eca1275f586cb984e6e28330447a0
Message-Id: <165956575627.24057.3467366999233352672.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 22:29:16 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 3 Aug 2022 08:36:10 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.20-merge-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f18d73096c0eca1275f586cb984e6e28330447a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
