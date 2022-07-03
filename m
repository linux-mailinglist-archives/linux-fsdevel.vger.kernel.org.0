Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FED5648AA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 18:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiGCQvx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 12:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiGCQvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 12:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397356313;
        Sun,  3 Jul 2022 09:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C35B96103E;
        Sun,  3 Jul 2022 16:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89B78C341CB;
        Sun,  3 Jul 2022 16:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656867110;
        bh=4y5p1F6d3LBQE85AO6rVtJeIalOdN8QNI2RXPd1PZrk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MfoCOFclb3Tsz4v+2zk/fa2pTDQX055WHZKVjhna1eJcffMlfPWoBAfe0Cu6ZecLC
         D1K3pa0q1c/3e/jdWUQT24YLcKi+9GdT+eUMMEcd3TbGfatn2In/DqPQoElT61BMaA
         SmUkAp65+dH91LFiNfzI1me7F7rvzhPul23JvuYQYURd5zp2T9WOwl6t2pw7WguJ79
         gys9v3fEaguWNlghG1gJqrT5ZsY2sXzuudrrrJattFJBwEHBL5ChtD9BdID9IwiG/n
         d/TZ78UA98GKj0jMeR/kumvcNI9j9H4sHjn6UPipkPdgNGNlww7tFvRGTVx1lRhtRh
         Nt79m3FfBjXsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7591DE49BB8;
        Sun,  3 Jul 2022 16:51:50 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 5.19-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YsGwPqUYSW/IwgkN@magnolia>
References: <YsGwPqUYSW/IwgkN@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YsGwPqUYSW/IwgkN@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.19-fixes-4
X-PR-Tracked-Commit-Id: 7561cea5dbb97fecb952548a0fb74fb105bf4664
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20855e4cb361adeabce3665f5174b09b4a6ebfe6
Message-Id: <165686711046.30745.15607778543141737550.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Jul 2022 16:51:50 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, fstests <fstests@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 3 Jul 2022 08:05:34 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.19-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20855e4cb361adeabce3665f5174b09b4a6ebfe6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
