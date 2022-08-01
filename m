Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA3B586E6F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 18:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiHAQSS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 12:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiHAQSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:18:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707B53E77E;
        Mon,  1 Aug 2022 09:18:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BA8F60EC7;
        Mon,  1 Aug 2022 16:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1E9DC43140;
        Mon,  1 Aug 2022 16:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659370683;
        bh=QlmL6dYNStkbz0pV2xhaPdReCfYT1eCKWt5yRN7n36o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P+isaaWzVM2LFeJr9EOSOTOvP3NjBvyApyID3H+dqxXX/BWnBhz5I9f1kn7p+Zq/+
         uMU6Usp55Mj3I09Am1Qr9owfq4c6hjiNlypWnL4/EeFJ7BXL8e7bCr77WTXRw2Iibo
         0HSgXxsvIfHalYAQE4GhAZtMfFwNXVXFyDzVAwSf/AoK+2RN4arfjUMS6URkWz6+Wp
         GDy2eAeDk89va3Xbe/BsYuYFknZihZ5UF2yo52hQpvjMIunUjx+d0oa0C/+wk1YFOu
         NvU+jwzLqdRcTsx670xoHsbVTNobPWYnNHy5297DXDIf3DPlDaw0satTry3Bgpz6Nc
         O4tHNr8b0Y2Jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 986C7C43143;
        Mon,  1 Aug 2022 16:18:03 +0000 (UTC)
Subject: Re: [GIT PULL] acl updates for v5.20/v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220801145520.1532837-1-brauner@kernel.org>
References: <20220801145520.1532837-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220801145520.1532837-1-brauner@kernel.org>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.overlay.acl.v5.20
X-PR-Tracked-Commit-Id: ba40a57ff08bf606135866bfe5fddc572089ac16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0fac198def2b41138850867b6aa92044c76ff802
Message-Id: <165937068362.17475.10462538290578813839.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 16:18:03 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon,  1 Aug 2022 16:55:20 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.overlay.acl.v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0fac198def2b41138850867b6aa92044c76ff802

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
