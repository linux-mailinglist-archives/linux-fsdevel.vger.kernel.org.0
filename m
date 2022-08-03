Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59C55893ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 23:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbiHCVNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 17:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238779AbiHCVNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:13:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D234D53D1F;
        Wed,  3 Aug 2022 14:13:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 923B2B823E4;
        Wed,  3 Aug 2022 21:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A77DC433B5;
        Wed,  3 Aug 2022 21:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659561220;
        bh=nL82EgyKKpKrlH1HS61n9VeQgqUeZ4A/isasT7uG0fU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SjWslV9PQWQs29H/64/vLzY484GFYjQugbRi1pBWRZE3W1wYj7C7ccu2dBeP6ifVI
         tzuBKMymkI4N6mwTG/0QqgzTWFcZqDlDve5RGKfcInqS6VtJyNGvxNJvwRCSNZxIzy
         idi4CzbIV66J5+Pd5hc7/rUs7noUwedplUDUcNBmO+lifD5AcNwSvHGM8rU9mgUUC2
         TCg6obk2vmGjtdBiPjxCegU2uBIXyz4SvQajqXgnC0ye/gDbxgi0d23jMvsXVvB+PC
         SffRaspOh7Mq8g3FoNqh66gnFHnHQd/jRs6MGPPD5WRPBNDHrc45CtbClfctcIxVrX
         KLiUxNDglW7cA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 458DDC43142;
        Wed,  3 Aug 2022 21:13:40 +0000 (UTC)
Subject: Re: [git pull] vfs.git 9p fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YurQkunyW5lfS9DH@ZenIV>
References: <YurQkunyW5lfS9DH@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YurQkunyW5lfS9DH@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.9p
X-PR-Tracked-Commit-Id: f615625a44c4e641460acf74c91cedfaeab0dd28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff89dd08c0f0a3fd330c9ef9d775e880f82c291e
Message-Id: <165956122028.15182.16589497695034512923.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 21:13:40 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 3 Aug 2022 20:46:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.9p

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff89dd08c0f0a3fd330c9ef9d775e880f82c291e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
