Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BDD5893EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 23:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbiHCVNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 17:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiHCVNl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:13:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2901153D3B;
        Wed,  3 Aug 2022 14:13:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAD436157E;
        Wed,  3 Aug 2022 21:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28EC1C433C1;
        Wed,  3 Aug 2022 21:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659561220;
        bh=1gxG9rwnMiJi4jck1bFSUWDnN7CN1nuM3cV6ScO+dzs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DMA/plLf9BNOFt0jgV8m7ce/XioTc7JwCahHYvAm+lbWRRKyRAFBvKTJclLo2Nj/w
         uzwkrLKnQacRfOAJ7jaR1vj0+aNhZf5PUwYKuJgg9EoazL3mxWaNKrEHm2ZPEGnHuL
         jDajFVkD2ibF87mTBl+ssby7IUupNe/RHI9S9a4GHyVE04rzY8BKhRSy7mQm/tOM0q
         uMo6Rtlcnc2gIv7hhNClWOY9J+QEufj/bXKvPAdkfvwRI5Vg1ToS3L+sn9zLYsS0lD
         /J0OoJTAUQMbKmF0tLqE+yyZjxDb9nOzO1UUfeebNbmLeLNaCREU2cyK6tmia2v34R
         cqZdydl0nJ9iQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17862C43140;
        Wed,  3 Aug 2022 21:13:40 +0000 (UTC)
Subject: Re: [git pull] vfs.git copy_mc_to_iter() backportable fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YurPILsZlc47V2+O@ZenIV>
References: <YurPILsZlc47V2+O@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YurPILsZlc47V2+O@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: c3497fd009ef2c59eea60d21c3ac22de3585ed7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9b58ab789b053b70dc475f1efda124857f10aa2
Message-Id: <165956122009.15182.7966328419845730840.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 21:13:40 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 3 Aug 2022 20:40:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9b58ab789b053b70dc475f1efda124857f10aa2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
