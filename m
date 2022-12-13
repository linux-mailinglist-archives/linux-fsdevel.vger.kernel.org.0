Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447C164AE68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 04:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiLMDtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 22:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbiLMDtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:49:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA711E3CB;
        Mon, 12 Dec 2022 19:49:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D3AC6130E;
        Tue, 13 Dec 2022 03:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E2F3C43398;
        Tue, 13 Dec 2022 03:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670903374;
        bh=BKwl63qEQqJZ1eV4zFQELesGjb0ZTigpY0NBJkHWrq0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JA3YoQ+jyGo4MUoyFfWwrmhRuYOkKDfW5NXFtkyb3DmL0xkt/n4g+yIY9GpRu09RW
         jTwJv0u3PbgdVtd20hmcv/c4X+qMdC7E3B/2JKddZzViPeRqALD29Z3kyt3P+aObbN
         3wN+h+P5cXIjM8103MpBTb8NyzxX1bSWlP1IZLVPgr1laGP/muIOjVSS4kAtNAs7DU
         4May3Cb3KozphtDuVOR1l0t1xW4NGofKszy3nAXTMW/n5yY1RIWDp0iehGR4rKS427
         XF0mHV+gTpiV0KarRorkLN/ST3I7GpYNCDMSnG2emfiN49JJJP13ui8Y+QqSq0+6RA
         BGLpaoFOHLBng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B389C00445;
        Tue, 13 Dec 2022 03:49:34 +0000 (UTC)
Subject: Re: [GIT PULL] vfsuid updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212123348.169903-1-brauner@kernel.org>
References: <20221212123348.169903-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212123348.169903-1-brauner@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.vfsuid.conversion.standalone.v6.2
X-PR-Tracked-Commit-Id: eb7718cdb73c6b0c93002f8f73f4dd4701f8d2bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4236f97688afc21151bfc050acfce9ac3b56f6b
Message-Id: <167090337404.3662.2428824287676427419.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 03:49:34 +0000
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

The pull request you sent on Mon, 12 Dec 2022 13:33:48 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.vfsuid.conversion.standalone.v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4236f97688afc21151bfc050acfce9ac3b56f6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
