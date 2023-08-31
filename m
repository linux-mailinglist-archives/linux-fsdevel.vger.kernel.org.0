Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3687778F5B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 00:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345411AbjHaWmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 18:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbjHaWmq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:42:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617C4C5;
        Thu, 31 Aug 2023 15:42:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00DF060BC7;
        Thu, 31 Aug 2023 22:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6510EC433CC;
        Thu, 31 Aug 2023 22:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693521763;
        bh=BPddDA/70CH0PeAk32/0zrS568xTu8wUgn61y4v3FIQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cFZXwKzm/UBCmXw7TJPjgH/tqPMXzNkEy1eFuckAd8mNJq0jWuC1mQhbD24OiYvEL
         JN+JZLhWXoSqPpOYFohnuYfX1EJ2um5ioiNKlBZE9Sj6sSgxx5tzLipnSOx5FUzWGo
         4TkuFHfqEa4DmK396ITaO6SZIMMRbBgymLv2dKoWVwFxYq9ZbP/hzQcqPTMI/Hv3n9
         xUyWc134Roo2qhEFuXvkzngGXeDcaK1QOsW+qeSZwCwDBe5qw8A8fa4G5K0WFaoFrs
         hnSiH6mx4670IkIK5S3/e6P45mHhmszH7xZprqBnWb2eL24p7/3fR3Dcb/amC9D0Xp
         zIxSTC3L9x0KQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C740C595D2;
        Thu, 31 Aug 2023 22:42:43 +0000 (UTC)
Subject: Re: [GIT PULL for v6.6] super fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230831-innung-pumpwerk-dd12f922783b@brauner>
References: <20230831-innung-pumpwerk-dd12f922783b@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230831-innung-pumpwerk-dd12f922783b@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.super.fixes.2
X-PR-Tracked-Commit-Id: 5069ba84b5e67873a2dfa4bf73a24506950fa1bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7e9423db459423d3dcb367217553ad9ededadc9
Message-Id: <169352176330.24475.9732725297267621963.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Aug 2023 22:42:43 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 31 Aug 2023 13:04:04 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.super.fixes.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7e9423db459423d3dcb367217553ad9ededadc9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
