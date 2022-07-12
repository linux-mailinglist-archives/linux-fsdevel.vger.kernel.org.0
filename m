Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA7F57202F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 18:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiGLQCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 12:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiGLQCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:02:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCFFC54B6;
        Tue, 12 Jul 2022 09:02:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAE36617AB;
        Tue, 12 Jul 2022 16:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27DECC385A2;
        Tue, 12 Jul 2022 16:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657641735;
        bh=0Qg4rX/nTEz2srme6kYvG//si1aLq7lju1ZtMsDkPYI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kCxNuv/IvdyTi6md36MANZyQc1YMwVw0A/X/7ixLxHurwChonRCLXljlmTf4tXcUK
         4BIdq2P4MAFLnFEMnv9P3zZiVXlNtpd5tzHxRVpu4TP/iw3d40QbJxl7/A53d4iQ/O
         mojllDbIpnJP1jn88ITaoIwqhCXOv7kADKSVtTEF0gDNU/EGKPw4vW70pnpSX/ZU2z
         VAuFC/AqXIDfioGArk8LT7eVCmlnsEGC7BcTRYhLvohO7Y3/zkfxuDl/IW77aVTIRP
         myQE0+nuhk6X6tGKW+Fs+tQWEIf6petAmNuSB6Pv403S+zEtHxrTfAHHw+tX9sfedO
         fJ3vdh7/6Q7tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13D1CE45221;
        Tue, 12 Jul 2022 16:02:15 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs fixes for 5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ys13gTA+irEuI+OA@miu.piliscsaba.redhat.com>
References: <Ys13gTA+irEuI+OA@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-unionfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ys13gTA+irEuI+OA@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.19-rc7
X-PR-Tracked-Commit-Id: 4a47c6385bb4e0786826e75bd4555aba32953653
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72a8e05d4f66b5af7854df4490e3135168694b6b
Message-Id: <165764173507.23543.13119309512770152751.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Jul 2022 16:02:15 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 12 Jul 2022 15:31:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72a8e05d4f66b5af7854df4490e3135168694b6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
