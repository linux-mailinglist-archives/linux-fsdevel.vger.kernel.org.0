Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E5A6A2703
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 04:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBYDkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 22:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBYDkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 22:40:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AF211EB9;
        Fri, 24 Feb 2023 19:40:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74E2C619D0;
        Sat, 25 Feb 2023 03:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7EC9C4339E;
        Sat, 25 Feb 2023 03:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677296406;
        bh=+7JUmJKjaKsLoKuk5913zNebeiGbX0IeICm0XfrezWw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KGTS84H/UFmnpeZzoEezupzy0HS+GLc7CxGZO7r+QLZn96ToOiSlOKnYjcPNM1zZd
         Q4DgD+WyTxSBCEGJ+37MidZUU+Vk+l/9by/iN9iBwZFF8+X3/Oi+3RTDbq23MODO7W
         Mhr5gs9ZJbmW+nY0pYXLiAquU0cLSq9KksI8goZoZ7KsvyWuCtPy9LfsCjw//bDnzI
         9e+UyH9Y+tvWHDqx2GVEeLzU9yEzuiLaRvhiDCwe2KzLKpvdG8QpAAs1s7XlF9oyUw
         T1Ve3xPbadOzK2EzOuosmHosc5TYg5XvzgRKEAwPecApwkbPl2PxwQPhKtMGx4Url8
         QNOREOLJqXGiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5AB8C43151;
        Sat, 25 Feb 2023 03:40:06 +0000 (UTC)
Subject: Re: [git pull] vfs.git misc bits
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/gxyQA+yKJECwyp@ZenIV>
References: <Y/gxyQA+yKJECwyp@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/gxyQA+yKJECwyp@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc
X-PR-Tracked-Commit-Id: 39ecb653f671bbccd4a3c40f7f803f2874252f81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 489fa31ea873282b41046d412ec741f93946fc2d
Message-Id: <167729640680.19216.7121715163259425102.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 03:40:06 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 24 Feb 2023 03:40:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/489fa31ea873282b41046d412ec741f93946fc2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
