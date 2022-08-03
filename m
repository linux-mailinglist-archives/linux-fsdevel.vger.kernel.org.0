Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CBF589466
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 00:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238950AbiHCW3e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 18:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238927AbiHCW3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 18:29:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013BC5C9E1
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Aug 2022 15:29:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83D1D61631
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Aug 2022 22:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC881C433D6;
        Wed,  3 Aug 2022 22:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659565761;
        bh=nktFujVABqQNLeYFxksUa0k1pn6cc/L+BCoR5paloEY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hY0RcsBSlBQRq51Xbbdn9HeOWK1N+xYWQkEunmgTS8aCDHld+lALet9ufoXj/DUqW
         KvE11QtWQFucMks/cj0RjKNM8cEUUT5U88rCVBQrjP0dURswWFPh6Ctj0yESrpQoox
         F8PXX01RubZjsweKpM6pJBG8NqQyKOrx6Rr4LWMAt7gxQ4QmTeaSmLymLAiROJD5zY
         SkPDvfzkrLvdaYc+G2iLIQrCe3XSLUd5ZICXAVwcrh/bOD9+z1RRKR7BLxNWYe7bjH
         lLpi8gd5uAJp5d+j0E82SIgzlZqcN+ict0KzK6zk8ePLv8B5zaqh5iojzpN9InZLMN
         K93KDiywsmSmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DAA5AC43142;
        Wed,  3 Aug 2022 22:29:20 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs changes for 5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220803064113.986932-1-damien.lemoal@opensource.wdc.com>
References: <20220803064113.986932-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220803064113.986932-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-5.20-rc1
X-PR-Tracked-Commit-Id: 6bac30bb8ff8195cbcfc177b3b6b0732929170c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a39b5dbdd2bc5ba36e6b90f2f979efcb090b0613
Message-Id: <165956576089.24057.874770379066495529.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 22:29:20 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed,  3 Aug 2022 15:41:13 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a39b5dbdd2bc5ba36e6b90f2f979efcb090b0613

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
