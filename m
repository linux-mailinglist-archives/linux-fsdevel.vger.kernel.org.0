Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15476534F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 18:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiLURTp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 12:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbiLURTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:19:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246732DEE;
        Wed, 21 Dec 2022 09:18:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D172EB81BD2;
        Wed, 21 Dec 2022 17:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A09F6C433D2;
        Wed, 21 Dec 2022 17:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671643105;
        bh=iBP8Ti+5OBCePtOAra3VXwYLBbZZ68Hu+Y6ytSn84t0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uCrw5iTxkpJF/aggxlk1fEvZVpoL+adRE8KyjHwPzh/qyiOYG/4D9aXYrq/xuAo5c
         +EanEdwhldNeuFhw2MXmOnn8T5NArDmOqTTeSREQ5QhXo0Rd/TJHMYknqIzNbRFNvT
         E21PtccQ2ddJlNQsAg+NOgVLsPulJTOr92nBpSr9WgjbRpsRLIsrT7sfZjLDhcyvSv
         9Q5xCFmIYxUp3IsWlTmDOju4qdzSzLHg+X2ZJej3lngtE7dBxJT1CQxXp0IPk+fuIr
         eM8DfvbSejPNnEzpoF4CEtfTpkLXudt6gHnTKeVQq+bkC01RJVgXGCMctrHNUtCWgY
         4qOs3QERs1l9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 849B1C43141;
        Wed, 21 Dec 2022 17:18:25 +0000 (UTC)
Subject: Re: [GIT PULL] vfsuid fix for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221220141743.813176-1-brauner@kernel.org>
References: <20221220141743.813176-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221220141743.813176-1-brauner@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.vfsuid.ima.v6.2-rc1
X-PR-Tracked-Commit-Id: 2c05bf3aa0741f4f3c72432db7801371dbbcf289
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 878cf96f686c59b82ee76c2b233c41b5fc3c0936
Message-Id: <167164310553.3046.12075378918799550025.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Dec 2022 17:18:25 +0000
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

The pull request you sent on Tue, 20 Dec 2022 15:17:43 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.vfsuid.ima.v6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/878cf96f686c59b82ee76c2b233c41b5fc3c0936

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
