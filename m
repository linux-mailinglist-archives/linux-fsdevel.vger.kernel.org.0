Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EB764BBB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 19:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbiLMSNn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 13:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiLMSNj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:13:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8762315733;
        Tue, 13 Dec 2022 10:13:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47BBDB815AC;
        Tue, 13 Dec 2022 18:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C04EC433F0;
        Tue, 13 Dec 2022 18:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670955216;
        bh=jnTHoolrByMruCDMf9xi8lDiLNWoBXvx3iO5KNOlC2M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RJR401GfjAmRYHehoVSE6hyUqQbW3/blmImSpyJBvhfI1EelFLlCC/G58bUT+yg+/
         IH2Zde7jHkrp5jV33pWIbxbmTiHFQ5eXdK4g5HI/tidlcXeU1jo/uUlOVJSNGdjSJ8
         DNSiEw7YbiqxGr/7p2CVhnqDZ5efLlcBquVxd1SG5tZHUocaHaedd2fZq+z2AX7ZxU
         bQm1hNVi/vTy8dHgIRPuG0g+84N6sPEL80g7JIKNiArjg1XPQTp7BBmjpVbaaMAbHU
         j3WaZosLjiH7J5X8tf+52bhnplNNajz5IlamIDUml8bYwn/5YSZn7bd5TJcAWE1OAZ
         6A/DOWY1LqDDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1BE2C41612;
        Tue, 13 Dec 2022 18:13:35 +0000 (UTC)
Subject: Re: [GIT PULL] simple xattr updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221213104643.238650-1-brauner@kernel.org>
References: <20221213104643.238650-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221213104643.238650-1-brauner@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.xattr.simple.rework.rbtree.rwlock.v6.2
X-PR-Tracked-Commit-Id: 3b4c7bc01727e3a465759236eeac03d0dd686da3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02bf43c7b7f7a19aa59a75f5244f0a3408bace1a
Message-Id: <167095521592.23919.16768036333916619988.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 18:13:35 +0000
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

The pull request you sent on Tue, 13 Dec 2022 11:46:44 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.xattr.simple.rework.rbtree.rwlock.v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02bf43c7b7f7a19aa59a75f5244f0a3408bace1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
