Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A8265369D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 19:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbiLUSuT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 13:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbiLUSuR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:50:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C591C2252A;
        Wed, 21 Dec 2022 10:50:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78715B81C02;
        Wed, 21 Dec 2022 18:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F204C433D2;
        Wed, 21 Dec 2022 18:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671648613;
        bh=b9DURRfbQqnPSzIzIEP0c75/Ubr29bXb+zu4plHlJsM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mybtSh80g7SGQQ2h0ErkCTV+ZWJEDYqyxBvypDEV6yGzlbsWJGAizO6lDHIwU7Fuz
         opFjfTpzFXRnQH3LAJksula4jxc7gKYtZ5DYBSwyDbtDxhXNIEMIl/bqISGQ3FwYlx
         GcXfWcYgHjAvoXhQH6Fs2wEOp+uxxnVYMFRqSL98sdJDlUo4oWjnXf41M+CXgiyVhV
         exJ+VZuZzQF4kq/P2QWBsvvDiVPCue6rVyjAHnFS6BDqLB88+BIHvJQM3cJDfdPlX2
         bswhgVHhHzgS868zE8VrpC4HOurYxzOvuMxPzr4t4F/caI77SKhQKlSeIWp+ba2w3n
         QAEtfpRfMNxJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0891BC395DF;
        Wed, 21 Dec 2022 18:50:13 +0000 (UTC)
Subject: Re: [GIT PULL] pnode fix for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221221135657.867066-1-brauner@kernel.org>
References: <20221221135657.867066-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221221135657.867066-1-brauner@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.mount.propagation.fix.v6.2-rc1
X-PR-Tracked-Commit-Id: 11933cf1d91d57da9e5c53822a540bbdc2656c16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04065c12072b6124475c7c4f6ad7484475a2f66e
Message-Id: <167164861300.27828.5781431425578322471.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Dec 2022 18:50:13 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 21 Dec 2022 14:56:57 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.mount.propagation.fix.v6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04065c12072b6124475c7c4f6ad7484475a2f66e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
