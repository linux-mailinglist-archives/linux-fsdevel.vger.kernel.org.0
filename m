Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D4B74B980
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jul 2023 00:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjGGW1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 18:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjGGW1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:27:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7AC2684
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 15:27:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABBF561A9F
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 22:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20A9AC433C7;
        Fri,  7 Jul 2023 22:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688768821;
        bh=pSMwC4Fb1GlqAmoiYKyHLFw+G5oI8CJ1ZH5DnWn2vNM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B7oo47NLnTr0RQhk4TGL6Z7y4/mc9cKmkTr8REQxMHxFgKYOoGgSyTl5xPM6PDnPe
         2bB7zvRZQMiLM/Y8uch9yJcben3TV9ttHGdlhKsSnQJ0K6O1uB7SXPKk9sB78fzG5j
         7+diHUj7JA7O/ona4iTQjz3yamTfmRocKqJJI4kqkG6uKIqzhZwjmVrA1uvLvJoOOh
         zXl44dOdu72kH7iZSxApAYN8ZRqDAT6on+YpJed3iRVJtHYy+L9VnTzAcwwZ4DFJzv
         dXGnP9AiXPx4eD5Uii69aYOYG44NIrOUb2sR2aFgUAIhjqx5gk4ZUZrzQHBVMMFrwC
         WvTCl9+elm6cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0EC1DE537FC;
        Fri,  7 Jul 2023 22:27:01 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify fix for 6.5-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230707124132.ixcwe6xhelmauh3h@quack3>
References: <20230707124132.ixcwe6xhelmauh3h@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230707124132.ixcwe6xhelmauh3h@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.5-rc2
X-PR-Tracked-Commit-Id: 69562eb0bd3e6bb8e522a7b254334e0fb30dff0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 986ffe6070d661650f8198069f6f3c228e23bca0
Message-Id: <168876882105.27307.16002178655138479484.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jul 2023 22:27:01 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 7 Jul 2023 14:41:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/986ffe6070d661650f8198069f6f3c228e23bca0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
