Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986D950C139
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 23:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiDVVkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 17:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiDVVj6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:39:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD871ED403;
        Fri, 22 Apr 2022 13:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C857961E63;
        Fri, 22 Apr 2022 20:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CE89C385A4;
        Fri, 22 Apr 2022 20:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650660400;
        bh=meuDKnhO1M99Wzv8KUrHnQ6eIb0HXt8vRLW3RougdoQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fDySc25vt8trr98EoUyO5W2ICLos58/8IEuZXESn4+oXdUdSvsGW+IXEsFqqqAg4W
         ybon7Lz73vzuy1oK1Zl0vPSJWJt6HBQcq5FQo5z7AY6zm++Gj4ZpU7i2XWWN64NdRz
         ubqqcsAkbv5cAZO9JFO4qCUmONY2WxE8bhmAy+0BJMM1G1fC/M+rv2AVIeDUsidMDZ
         T5VkVlx8TlWOgbiaFrfMU+WaASV85+52iJ5l3T+rPXrtfMnVjNWirMImSRoSrCV79h
         r1napFj3XrI62qw58AQ8GFfHZs4EtSjv8A9EM/paQJMpWjhQnvQxvjARDEtdiRobkb
         Oe0IZp6Ra71IA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 223DAE8DBDA;
        Fri, 22 Apr 2022 20:46:40 +0000 (UTC)
Subject: Re: [GIT PULL] fs: MNT_WRITE_HOLD fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220422105231.197721-1-brauner@kernel.org>
References: <20220422105231.197721-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220422105231.197721-1-brauner@kernel.org>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.fixes.v5.18-rc4
X-PR-Tracked-Commit-Id: 0014edaedfd804dbf35b009808789325ca615716
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 279b83c6731c73a2197a1724d67312ba415e0607
Message-Id: <165066040013.3510.9061507080441725788.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Apr 2022 20:46:40 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 22 Apr 2022 12:52:31 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.fixes.v5.18-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/279b83c6731c73a2197a1724d67312ba415e0607

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
