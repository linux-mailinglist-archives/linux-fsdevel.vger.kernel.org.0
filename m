Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12F454706A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 02:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349442AbiFKAIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 20:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348213AbiFKAIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 20:08:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A70AF4;
        Fri, 10 Jun 2022 17:08:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36B8861E59;
        Sat, 11 Jun 2022 00:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9988FC34114;
        Sat, 11 Jun 2022 00:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654906118;
        bh=dbtYq6HBXwfSN1cQQg40oG/l2BKus+CnPs9gkl2YLOw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r3v0NrV6G3iEIzF+2xq1/hlktgqWDMjvw3i44kESVlypYCnq6Cq2zmqRNYmruL25V
         NLT+F4Krqn1KlRMGwMzTRIcjoeP2gKf2b820ui7C3D+8t1s9tbXJyTonUJwuKvfgFa
         wIhcgVmcNYIf4GbA/pRSDe39cFzkqRoQ1QxVSuwBGGVJTD9JBYq+YVvTGlRkSolrRj
         XhDVDasUNc+so+5dYjzlgdr4fd5HYZiVac68BM+fChW+N2ERh1v9xVe9v8AD2IcA+Y
         1ilDM9792W4R7Cgx+BqljDfQAXIIxaKsVSitjO0wR74UPOoJ14Cxk2vG6B0eegB2f8
         6RftkuwLUxMvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84E70E737F6;
        Sat, 11 Jun 2022 00:08:38 +0000 (UTC)
Subject: Re: [git pull] iov_iter fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YqOjMvUlZKpeYg76@zeniv-ca.linux.org.uk>
References: <YqOjMvUlZKpeYg76@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YqOjMvUlZKpeYg76@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 6c77676645ad42993e0a8bdb8dafa517851a352a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b09891598557a0ef408d9a7605e72ed3c67c8c15
Message-Id: <165490611853.9139.17850184070611486296.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jun 2022 00:08:38 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 10 Jun 2022 20:01:54 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b09891598557a0ef408d9a7605e72ed3c67c8c15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
