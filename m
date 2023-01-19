Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6313C674C86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 06:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjATFgx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 00:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjATFgg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:36:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA96966CDA
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 21:33:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C25AB826F5
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 18:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D3F2C433D2;
        Thu, 19 Jan 2023 18:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674152715;
        bh=0Y7tH7txqgUPOcgQZBlkxrjLSFqGgMf4yI0wkgR5lIU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IheXps1vw9Lp6B5S2yUxa8Nkf36i5nBeaQj62nJhwTDrpHxvfUiG3GPy+OzGUNTVy
         FBRMDhr9OBxfFiPn35q4qjLXsDbnmNxkVoCR4SrN18blNT6vqXbXg+8X4GhU38Ol8w
         7/fDaKzmNcwEekUeD2gOcGSR3AU1ay7bveRRzG4G/gUfZGGrzkBIbpySM3ElCbuYKH
         gKjXT1ZwHMZNAY+Lbin0yu0X14Z+F8aQiOE4Pkf338SUYJ9ZOCD0VEkQqiRKgF3eP2
         KHmZcqhAXiMdvvK8h/7pIPlU7vPkfKu7d5r4zRCupKPJ/jVSFjnVuqhMISK+y0/iNT
         lzFfC4JvPr/2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A61BC4314C;
        Thu, 19 Jan 2023 18:25:15 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs fixes for 6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230119014124.4332-1-damien.lemoal@opensource.wdc.com>
References: <20230119014124.4332-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230119014124.4332-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.2-rc5
X-PR-Tracked-Commit-Id: a608da3bd730d718f2d3ebec1c26f9865f8f17ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 081edded9b38ba6a3a8fa045cfa0d374343da08a
Message-Id: <167415271516.28049.3793257998362844270.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Jan 2023 18:25:15 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 19 Jan 2023 10:41:24 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/081edded9b38ba6a3a8fa045cfa0d374343da08a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
