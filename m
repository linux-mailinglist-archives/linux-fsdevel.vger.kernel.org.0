Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9996C74501B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 20:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjGBS40 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 14:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjGBS4Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 14:56:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9968F10F1;
        Sun,  2 Jul 2023 11:56:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6894660DD8;
        Sun,  2 Jul 2023 18:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6F26C433C8;
        Sun,  2 Jul 2023 18:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688323988;
        bh=Q3EMtf5VK8uZi+RM85+MSbntYpgGHo9uKNET2So3y8U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lvE0d5Gw2br2VizPlRTu5es5bRWSUXHYCoe7HtDLF+zLuFza9ODFXPpceIZAlbI2n
         WaHSfHsubRN9vfuyvuF7IeoVdGtk4PmZWU3D7KbkG4af+5A3MbYIKgoKx3yxjKFw+/
         JqN59NqH6Tb6TwIHxfjryQNzfawhMGRPTTnFmh2h501GopP+6Py72CYuJCAlHw5U1B
         4zGbZyDuqHmUU0Y6DEdfkfsvqycvWGOIPcMFlvQGi1deqsFfxe71a1BJi5Sctbty0A
         lV+vbW8UNnc8HCFRtbSF6ei0IKWkD0paVOd3+QD1nQLe+EUreYeSOa8Se5IjsBjuJD
         R1CMdz6owbkYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B44D9C0C40E;
        Sun,  2 Jul 2023 18:53:08 +0000 (UTC)
Subject: Re: [GIT PULL] iomap: new code for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168831482682.535407.9162875426107097138.stg-ugh@frogsfrogsfrogs>
References: <168831482682.535407.9162875426107097138.stg-ugh@frogsfrogsfrogs>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <168831482682.535407.9162875426107097138.stg-ugh@frogsfrogsfrogs>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.5-merge-1
X-PR-Tracked-Commit-Id: 447a0bc108e4bae4c1ea845aacf43c10c28814e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a901a3568fd26ca9c4a82d8bc5ed5b3ed844d451
Message-Id: <168832398873.18363.17032806585074128796.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jul 2023 18:53:08 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, luhongfei@vivo.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 2 Jul 2023 09:22:55 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.5-merge-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a901a3568fd26ca9c4a82d8bc5ed5b3ed844d451

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
