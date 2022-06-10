Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E651546C4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 20:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350142AbiFJS0A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 14:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350127AbiFJSZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:25:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF94E2CDDE
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 11:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 800D5621E4
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 18:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5E83C3411E;
        Fri, 10 Jun 2022 18:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654885554;
        bh=6eHeLGjQEfIy35DnhmNUTjm+wzZ4tHx8fyCXZLu1iGE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cn7Zf2U1xCiX/KlbeB/Se9jEO7b6P+ZewlXmFMuRmJDljOWMsnV7JLEUzi+SF5kZY
         XlTbCdro5IKBBAbxVoj55WETep0yz/rIEpKqpJYv2BWBecH1X5XNQheWzi2hBwntF+
         EnscZ2LUuDOT90h0f+PwNW3FhJ2WlR5tGYP+B0YMCHT45daqm5g0mKkziyR6iZ9Qp1
         Bf+2kvhxyIMqXwQHSqAFcLKesX83bWFqDRoSk3MAZZqtCeaJmUrtsH00as2099+GHJ
         LABouvLGiqyURhBpsFLUbzl41LcMHze7o/vooPtLK17kvtA3IoyQEcw3crZ2S/HqRV
         78tEl1TN/dzPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4831E737EA;
        Fri, 10 Jun 2022 18:25:54 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs fixes for 5.19-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220610105113.788534-1-damien.lemoal@opensource.wdc.com>
References: <20220610105113.788534-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220610105113.788534-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-5.19-rc2
X-PR-Tracked-Commit-Id: c1c1204c0d0c1dccc1310b9277fb2bd8b663d8fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad6e0764988a388a25323337c8d559fe14b2e6b2
Message-Id: <165488555486.32117.16419496041349971458.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jun 2022 18:25:54 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 10 Jun 2022 19:51:13 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-5.19-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad6e0764988a388a25323337c8d559fe14b2e6b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
