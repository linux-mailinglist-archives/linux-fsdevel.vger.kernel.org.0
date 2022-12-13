Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9F164AE66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 04:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbiLMDth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 22:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbiLMDtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:49:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752D91CB11;
        Mon, 12 Dec 2022 19:49:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1291A6130D;
        Tue, 13 Dec 2022 03:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 765F8C433F2;
        Tue, 13 Dec 2022 03:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670903373;
        bh=vFpLBh3AKibQNdDpcYmmMmBLMIz0AH0AzyxtkTYS7Og=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WCO1KHL2nhwCgJSgfTT6+u+DdLDShf4w5zf9io6WaV2tOWHjstFYwsDK13f3vHjnP
         K7eJo0Kkt7w9bD3iRg002WM2QUF0rLg2Lks7cLbI3tL1eMkItZJ/UMlqiJ4+FjkaRR
         cplEzOIhFWMQeKA8VGII67sXRShEPlFpJayR0JscGEVu34sNU8Z8bkD8sN8/wJ4bTH
         I2o+dbYjzSgdEHjFpjwdOadRLUPdfk//OTmBftuhfScMyvGCaQztWLKmZDW4V/Dzy7
         ekf21m+v/MCuj03rjKZ68w85yz924v4KTbvgni/0/CCoZuZiUUhN0tLWeCAYn1R0r9
         EJKQXxFyJvi/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A917C00445;
        Tue, 13 Dec 2022 03:49:33 +0000 (UTC)
Subject: Re: [GIT PULL] acl updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212111919.98855-1-brauner@kernel.org>
References: <20221212111919.98855-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212111919.98855-1-brauner@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.acl.rework.v6.2
X-PR-Tracked-Commit-Id: d6fdf29f7b99814d3673f2d9f4649262807cb836
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a518afcc2066732e6c5c24281ce017bbbd85506
Message-Id: <167090337336.3662.7690631838085834522.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 03:49:33 +0000
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

The pull request you sent on Mon, 12 Dec 2022 12:19:19 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.acl.rework.v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a518afcc2066732e6c5c24281ce017bbbd85506

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
