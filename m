Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6F9742F0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 22:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjF2Uwh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 16:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjF2Uvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEB83585
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 13:51:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 251F761636
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 20:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F9EAC433CA;
        Thu, 29 Jun 2023 20:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688071897;
        bh=GgNPf40wOcVrJ9Ny81Ltnqi3L1y1aw/oOZw5z7UYR8A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g496qCrOpPRixCONHsYBjLl10If1G+nd4W5xonPjorj0OC8ldaX01Fz67bpqUYHiQ
         smhbWqyDPNiigvTgdehQyJOW6cBDa+E4n8yBNmLW3NmgpOuzbTGGNG4UoQkkf8tv7Z
         wM3s43As0ynbPOEv/r6wlteaLJo4/rKYfksCruotfuV5Nbxl6KHZ00ARRGgTWq1N6t
         f/nQhF3roEyY09osTPV+WN6rfKguIdfpbptG8f4uISLqDpoF/r3JeeoKeEhsTiMBdp
         tUn/YakF4zVJBpAgKDJu+oE1YX0mrJvPsnYpATSb3iUVOcnB4B+cY3rbRG15GCywWN
         QhPVEzpMY0eUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 796D3C64457;
        Thu, 29 Jun 2023 20:51:37 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify changes for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230628151821.2henh5bzlk77bytp@quack3>
References: <20230628151821.2henh5bzlk77bytp@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230628151821.2henh5bzlk77bytp@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.5-rc1
X-PR-Tracked-Commit-Id: 7b8c9d7bb4570ee4800642009c8f2d9756004552
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18c9901d7435b20b13357907bac2c0e3b0fd4cd6
Message-Id: <168807189749.21634.13494881695237580161.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Jun 2023 20:51:37 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 28 Jun 2023 17:18:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18c9901d7435b20b13357907bac2c0e3b0fd4cd6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
