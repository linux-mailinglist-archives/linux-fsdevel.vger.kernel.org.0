Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232FF65541A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 21:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbiLWUIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 15:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiLWUIe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:08:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5EE13F21;
        Fri, 23 Dec 2022 12:08:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D407661EF1;
        Fri, 23 Dec 2022 20:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42027C433EF;
        Fri, 23 Dec 2022 20:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671826113;
        bh=xPTOnB2Q3hBfI+si9FmT6bNHaXCqqzT8BSb+rFgeoUg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rs45jhVhCgXa2Zomf6baJf76XsWic/Jz1LJ5ZCDrjotKD4srgXUuo+b6k6dhH/4IG
         osGliT3M5RD3DEp/C6eWyZTTP4ejhMpSisLQQMzw6D4ct2lFlChTaNlHDzFz9cVcwk
         1hOVMwSkeyG51lyf/LoB40DWRtMj3RaQHBdaMeYjuPFxZhgCB8x3OTiL6wTLAYoCyT
         FrXfG2LSUq9kQiBh1na90MJuGu9Jw38ktFtJDj79woNrfRLKeNNvH9TqEBDQlcb4AE
         8Y5VqvbWU5++CWP9DIyXKFDZGrF3+hPqEnDsFHdylEV/fOYMGtG0DvbdnbP4QyhruH
         1e5GpN1QJuWcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2FEB6C00448;
        Fri, 23 Dec 2022 20:08:33 +0000 (UTC)
Subject: Re: [GIT PULL] 9p fixes for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y6WNt21HKZmWTG3/@codewreck.org>
References: <Y6WNt21HKZmWTG3/@codewreck.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y6WNt21HKZmWTG3/@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-6.2-rc1
X-PR-Tracked-Commit-Id: 1a4f69ef15ec29b213e2b086b2502644e8ef76ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3b862ed893bf030ebdd78ead99647374a2cfd47
Message-Id: <167182611318.4135.10312690702165039666.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Dec 2022 20:08:33 +0000
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 23 Dec 2022 20:15:03 +0900:

> https://github.com/martinetd/linux tags/9p-for-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3b862ed893bf030ebdd78ead99647374a2cfd47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
