Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CFE53353E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 04:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbiEYCRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 22:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243835AbiEYCQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 22:16:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305F752513
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 19:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46311B81C29
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 02:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02EDAC34100;
        Wed, 25 May 2022 02:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653445005;
        bh=10ILFaYgUO/BMJdiufydQheqB5tQMKalfTVSu040q1s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eZAyLP2cRBlBfusE5WOKmCmDAm08ppw5JylBBudXTYVJr+A2kA9wEpZYLI+sexewk
         hhQLdJ1/VyudEcioSxnwnqHNI8g3jiJ23o3dDgSmCraRu1jlMMmXlFOmx2Rl2YvLtX
         4N76D2ma4s6E4cnsLtVcUDIKfXena4zkw2ln7zj6xpFUGcaQLCskrpquqP7ei7DhvB
         3zAC7a9YqHm+jlbFfP+zi1jOszYmmJi/N4LkQp7rzc6kPdB85addhNsspxRpSuZU6k
         OVRwhNItVQfXNdBET3OCDiOtNR6TBhbia9xZWjy/l2keALXpbkAHq1EIcxMPV32RRM
         vDj/zYdSOXz9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E593EE8DD61;
        Wed, 25 May 2022 02:16:44 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs fixes for 5.19-rc1-fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220524081253.989166-1-damien.lemoal@opensource.wdc.com>
References: <20220524081253.989166-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220524081253.989166-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-5.19-rc1-fix
X-PR-Tracked-Commit-Id: 14bdb047a54d7a44af8633848ad097bbaf1b2cb6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3842007b1a33589d57f67eac479b132b77767514
Message-Id: <165344500493.22339.5372415019341022803.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 02:16:44 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 24 May 2022 17:12:53 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-5.19-rc1-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3842007b1a33589d57f67eac479b132b77767514

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
