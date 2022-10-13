Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4535FE09F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Oct 2022 20:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiJMSMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 14:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiJMSMI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:12:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623B216339C
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 11:08:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53085B8203D
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 18:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17461C433D6;
        Thu, 13 Oct 2022 18:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665684103;
        bh=qbF8TQnMC5VLaRhr4gP0STlTRKTVPSYjMPb8x4YSp30=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kN93SOWkqMF+L4vUKUtKJxigDcLYJzLNHp4WkQU+g5P1Ze053u+ibRRA0rEizdRqR
         sTvBBbWY2BIp1pjGoObrr3NMvIc3pc9wj2i145EgehS2fEhmvr36fxK/QFQ5Zi2i5W
         cNADPCD5EQUdoNvlgqRgOZx47EH9bid7qwy+L/R9IjCdCT2YYgneedNyDq/03P44O/
         DiC4hw96EvG00XchDvVdn5MOjD82ftbxlh+ywYqHYiVR9EAIBut6/GPizGrMVUHnZD
         3RB4wJO0nBdfBCgJjvlfab7AjMWyn5t5ng4luGqsNpDtBf7jc/ZwzqZ/OulBJ+tooP
         2BMizzxifr3fA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04B4AE29F31;
        Thu, 13 Oct 2022 18:01:43 +0000 (UTC)
Subject: Re: [GIT PULL] orangefs pull request for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSQAvtU3rJ-My-3MUE1Uv-nc5QYyhJBO4npk-wfdiBkMOA@mail.gmail.com>
References: <CAOg9mSQAvtU3rJ-My-3MUE1Uv-nc5QYyhJBO4npk-wfdiBkMOA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSQAvtU3rJ-My-3MUE1Uv-nc5QYyhJBO4npk-wfdiBkMOA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-6.1-ofs1
X-PR-Tracked-Commit-Id: 2ad4b6f5e1179f3879b6d4392070039e32ce55a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 531d3b5f731123a1ea91887a84f99bb8cb64be8e
Message-Id: <166568410300.10865.6284407992012090093.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Oct 2022 18:01:43 +0000
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Marshall <hubcap@omnibond.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 12 Oct 2022 14:50:27 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-6.1-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/531d3b5f731123a1ea91887a84f99bb8cb64be8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
