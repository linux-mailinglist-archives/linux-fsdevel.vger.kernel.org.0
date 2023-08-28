Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6809D78B95D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 22:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjH1UPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 16:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjH1UPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:15:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4412BC6;
        Mon, 28 Aug 2023 13:15:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 265DA6514A;
        Mon, 28 Aug 2023 20:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FCD7C433C7;
        Mon, 28 Aug 2023 20:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693253705;
        bh=bq4TMo3kLyaKFNYPUAhAJIUPtzjH5bbSKcOrkt7s+fI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iZgD27u/zNJks8z7RYMSJarKnfkjoGvuHctmxvHpYtMPOZiVWKpWx1C91fTvL0aki
         X4uNTtndE7+ZGHQQ2hxZd6r/cZ5vVy+lMi7IPV7MnEzNkIMDkokXQp+uH+vdU70vRp
         4ASsX/Zbbbeelimm60+f4EVBbHahV8eH74MsambBnt5HNucocSRwmezTR+WFhOL6nL
         +8ghQmbdYELvZvCYkd6IZNWXWRC+Y4Y7lDGyhkFYAIM1d5wDgCxvnHLtBOa6bcH5qL
         DIcTGr4wgd3y3S8GMXl4k0HPwgEluGy/mzyON2n0TgcM2rPszq0TESTUgsOv5a9Y6A
         ZTfFaVnLQiJLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E8F6C3959E;
        Mon, 28 Aug 2023 20:15:05 +0000 (UTC)
Subject: Re: [GIT PULL] AFFS updates for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1693225987.git.dsterba@suse.com>
References: <cover.1693225987.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1693225987.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-for-6.6-tag
X-PR-Tracked-Commit-Id: 4d4f1468a002b76fb4796985a11671d50c88e520
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f678c890c684373a387b0d73cd4d51edbf329c27
Message-Id: <169325370551.5740.785137608089374943.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 20:15:05 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
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

The pull request you sent on Mon, 28 Aug 2023 14:41:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-for-6.6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f678c890c684373a387b0d73cd4d51edbf329c27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
