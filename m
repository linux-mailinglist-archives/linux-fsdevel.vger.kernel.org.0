Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6425BEC18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 19:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiITRfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 13:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiITRfK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:35:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C060D474D7;
        Tue, 20 Sep 2022 10:35:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D8743CE1AE6;
        Tue, 20 Sep 2022 17:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2916AC433D6;
        Tue, 20 Sep 2022 17:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663695305;
        bh=nsfHZ3Jfvzw5jGqlx39VujHHEXx3G89wLXBZIlGlTDQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m3WvOw5M4Sh7n311VEV5Zu3FEHdcE+hL/QUhd7rZcnnoLFcCfhZpH4tLsMUXlsr5G
         UIoHNNYmAVTW5N5sT/qRphM6II0EJjtZ7rDJQDORu7qsuwLKUznHhfj2ziYx+WX7vY
         rADq1oVvbP3x/8j+Ofv9RZ4sa0JP3cEDi+vs6CizTedc/xQuMqA6egM1w3Uh0MgNgJ
         tYaDte//aKgbJX8S8KdYfzZeLNo9IVmUCU/kGq9uRMulb593fI2a6DOLFTaAZhkDxx
         mT0G4m3fwtDouhhFC/OKteu2QGg68hdD4LThwrifbuzPcUQSIAXi13bije6HeHPD3x
         GNiDN1Tzo7GFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0787EE5250A;
        Tue, 20 Sep 2022 17:35:05 +0000 (UTC)
Subject: Re: [GIT PULL] fs fixes for v6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220920105109.1315345-1-brauner@kernel.org>
References: <20220920105109.1315345-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220920105109.1315345-1-brauner@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.fixes.v6.0-rc7
X-PR-Tracked-Commit-Id: f52d74b190f8d10ec01cd5774eca77c2186c8ab7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84a31938831f6d2338ceffe630a1271ec2a51a59
Message-Id: <166369530502.7287.1984272967200332027.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Sep 2022 17:35:05 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 20 Sep 2022 12:51:10 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.fixes.v6.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84a31938831f6d2338ceffe630a1271ec2a51a59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
