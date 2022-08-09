Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59E558DCB3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 19:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbiHIRDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 13:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245518AbiHIRCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:02:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399BB6419;
        Tue,  9 Aug 2022 10:02:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0082B8166E;
        Tue,  9 Aug 2022 17:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EB20C433C1;
        Tue,  9 Aug 2022 17:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660064558;
        bh=vs/RgoJOKweyDQaVfy6BsbugDW8SAYyCIJcI0pHYn48=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X5jYG0Re+3VlHqRCxsDVN+6QYUIwl4EgSx4pDM9bzHkb9q1lqwhYQFvOQZlihsqjK
         LJFg8MuEbryLu3GZHIedV7mCJ9Cnr5pPJ4WJQguXxDJHWWiI91hbuqyGYVlvtWixxH
         kDC+tTMkcHqkx6FA69aCX4GC4txwbF3/UjwDckFOXcc31dEb3Kb4Rw18QW+HKmOCcx
         Gy4muofuq1Z6blACogw/cJ7YCIwZRpvhQTH7Ah3HDc3kF9hQHDCgqlU86uSjkZm4ky
         Yr9kzdIYP7Y/tu0+ViePpViK6t7sQVj1PlyawUxuQRDWr5WL6wReO55Kg9ni/m4iWJ
         joW+YVicNUgZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E560C43140;
        Tue,  9 Aug 2022 17:02:38 +0000 (UTC)
Subject: Re: [GIT PULL] setgid inheritance for v5.20/v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220809103957.1851931-1-brauner@kernel.org>
References: <20220809103957.1851931-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220809103957.1851931-1-brauner@kernel.org>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.setgid.v6.0
X-PR-Tracked-Commit-Id: 5fadbd992996e9dda7ebcb62f5352866057bd619
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 426b4ca2d6a5ab51f6b6175d06e4f8ddea434cdf
Message-Id: <166006455857.27167.3132300456623890343.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Aug 2022 17:02:38 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue,  9 Aug 2022 12:39:57 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.setgid.v6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/426b4ca2d6a5ab51f6b6175d06e4f8ddea434cdf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
