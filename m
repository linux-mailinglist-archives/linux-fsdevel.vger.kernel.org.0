Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF09069FE7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 23:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjBVW1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 17:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjBVW1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:27:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A3443918
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 14:27:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3280EB818AB
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 22:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE465C433D2;
        Wed, 22 Feb 2023 22:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677104822;
        bh=1h5q/O2qSUk+EAcvmXgXSFWvSPoJ7v7+lGbUyzyHf9U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AlE8MJVts/xoVhTX6KfI5MMLHFalcEuFpmo+/JpU84wE1TFXeQUrB9rhS1W9Z6XU6
         GRU16JBzFAra9n3iDvYDkQK1zWm6VOwCv5XiChEM37AurkjLC6MLaT2kotnUItofvk
         nef9FddrXWJrj5ttIgsupNs50yOlMdecTZ7AB5mI9Is4loi5pZ+gElu9cP4wMvY/cO
         2E5G8OUm6sIb/L76hl2r9ahlKZWw3z2982esL7hekKqQhHn2JPLEnQYfBCX3YPQ7yx
         PB721vniEW3PFbYWhvWIR2RbExyJs//e9YbA1mjpOYoi1MiHFAC/S0QYaQxUHyc958
         Ym1n+3OF/PbOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC134C43157;
        Wed, 22 Feb 2023 22:27:01 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs changes for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230222010246.1090081-1-damien.lemoal@opensource.wdc.com>
References: <20230222010246.1090081-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230222010246.1090081-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.3-rc1
X-PR-Tracked-Commit-Id: 2b188a2cfc4d8f319ad23832ec1390bdae52daf6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 232dd599068ff228a29a4a1a6ab81e6b55198bb0
Message-Id: <167710482189.21044.14553575010926746777.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 22:27:01 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 22 Feb 2023 10:02:46 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/232dd599068ff228a29a4a1a6ab81e6b55198bb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
