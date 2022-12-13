Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E581564AEE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 06:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiLMFAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 00:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiLMFAQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:00:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B440F1DF03;
        Mon, 12 Dec 2022 21:00:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 535C961320;
        Tue, 13 Dec 2022 05:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBA3AC43396;
        Tue, 13 Dec 2022 05:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670907612;
        bh=Mp9D6Ug7n/+PR17/QLjqmea4jEW+SpA7d7Q7GslyjPc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IzpFQLd4d0NFj9AQXxVYrNmc808Jjchph/vprQjVXHQApo69X41bUU6ZGVHuYka0y
         8FI//Kdz7Fdx7BYp5Hks4ZpMFm73N69U49UbS7/cpMB3jbZECaqZ3x5x+2A8i4ycFV
         2Uu0Btf5TPXqLpkG3Qcm0+x5KWDt/bwhLjAQsnGGvEhVZ4rPEN57Tli8U9NQV6MbVA
         3iHAQYLZp4i6SJnBG0WQ3vChc+d0dHHoC276/Qp6SkEJ5Hfbv3zV613JmetjbH1tih
         NOLEgB8+gN6KNLra1U1zMc9Mzu+jeTwuAbA1xilZkjyK1AI8a6p43i1+iPIvKPX2hu
         ++iOxhzFD1jTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A96F2C00445;
        Tue, 13 Dec 2022 05:00:12 +0000 (UTC)
Subject: Re: [GIT PULL] enable squashfs idmapped mounts for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5dKl5Ksx0iyiJSY@do-x1extreme>
References: <Y5dKl5Ksx0iyiJSY@do-x1extreme>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5dKl5Ksx0iyiJSY@do-x1extreme>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.idmapped.squashfs.v6.2
X-PR-Tracked-Commit-Id: 42da66ac7bcb19181385e851094ceedfe7c81984
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e8948a0630f9ee46cf03dbf65949c1f4b6f6dd2
Message-Id: <167090761269.4886.5884999695545719707.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 05:00:12 +0000
To:     Seth Forshee <sforshee@kernel.org>
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

The pull request you sent on Mon, 12 Dec 2022 09:36:55 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.idmapped.squashfs.v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e8948a0630f9ee46cf03dbf65949c1f4b6f6dd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
