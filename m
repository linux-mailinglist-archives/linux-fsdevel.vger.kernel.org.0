Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6C75F3BCF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 05:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJDDp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 23:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiJDDpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 23:45:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D8813D7A;
        Mon,  3 Oct 2022 20:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8888A611F2;
        Tue,  4 Oct 2022 03:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED7FAC433C1;
        Tue,  4 Oct 2022 03:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664855101;
        bh=iaKRShUIOX8k2JsEUxYK3+diV0OKrFsZZZGKeTNZEyM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RxGiJIJ0tomEdXUgSdyjF95lxj7tvoPlEdRDPk/aaS2N0rNJIjCBCEt6NSZ+mk4Bn
         Pc8WPay6RYJYC2ZrdwELalWZ020FJ2Az2KNflxbuzg1g74B3DFDNHTvQXPiR9kZVxy
         X0KSPfATiz7vEfCMo5xSOWh7Yb0uddXrhDC+wj1hKBc4UdjktZGuKcaXtM0DSQQILh
         yCg+4fICn9mLxTJlZ6Ms3syW0nehHhaV/iheJhGKibs591mMpeTvcxbBzX1AUuM/6o
         dhojB/Qf8qw0WP0SZX/XnAWshmbNJ8jFQA8pIy/HlVBu5j1Vo7O2SIfzYNK8YA9H1x
         2BoQ/gihwsVCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB90DE49FA3;
        Tue,  4 Oct 2022 03:45:00 +0000 (UTC)
Subject: Re: [GIT PULL] acl updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221003111943.743391-1-brauner@kernel.org>
References: <20221003111943.743391-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221003111943.743391-1-brauner@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.acl.rework.prep.v6.1
X-PR-Tracked-Commit-Id: 38e316398e4e6338b80223fb5f74415c0513718f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 223b8452530da8816de09ec76a2182d1ad8f4fe2
Message-Id: <166485510089.18435.7795409333870497525.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 03:45:00 +0000
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

The pull request you sent on Mon,  3 Oct 2022 13:19:42 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.acl.rework.prep.v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/223b8452530da8816de09ec76a2182d1ad8f4fe2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
