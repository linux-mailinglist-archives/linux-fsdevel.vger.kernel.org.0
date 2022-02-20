Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AD94BD0D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Feb 2022 20:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244593AbiBTTGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 14:06:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244603AbiBTTGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:06:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0A44C7B4;
        Sun, 20 Feb 2022 11:06:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 547BFB80DC0;
        Sun, 20 Feb 2022 19:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2807EC340F0;
        Sun, 20 Feb 2022 19:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645383960;
        bh=XK1CaPRJP+TW9kZsyn9kwDrAuHNgVQaFOx5iyW8572I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f92JjSjuC4DL5s+S1LGMS9qQygIsR5eyZnl8ivVQh3UzmCrLEECoWEkRY6OvkmYN9
         hLlUjQGGZxbhewU6b79egVzxIkbuKIBxx8su+kucjkZJyOr9bjCq57OzcCy6fRyVle
         TJnIYslrwfLq3zPI5hzsJ1YcMXlenLuwcabj1eCnQtse1ooPJp2atFAiy0B8P3Ogcj
         tus/fgp2mRgmM6/zpVIPf67ppR8zsnlhGd65QAZl8CnblNQK19Z6xX7ANs6eb2n+Pt
         7UW7D4d6+AzOzCSbqcBCMNctqBQCvc443nQL1SPoPgQ2Sb5akSvsxwkfqzhGthbHyy
         AcF8JrIgY2OLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 148D8E7BB0A;
        Sun, 20 Feb 2022 19:06:00 +0000 (UTC)
Subject: Re: [GIT PULL] fs mount_setattr for v5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220219115327.3635609-1-brauner@kernel.org>
References: <20220219115327.3635609-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220219115327.3635609-1-brauner@kernel.org>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.mount_setattr.v5.17-rc4
X-PR-Tracked-Commit-Id: 538f4f022a4612f969d5324ee227403c9f8b1d72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f25f0412c9e2be6811e8aedbd10ef795fff85f2
Message-Id: <164538396008.24844.16173704332043691169.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Feb 2022 19:06:00 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 19 Feb 2022 12:53:29 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.mount_setattr.v5.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f25f0412c9e2be6811e8aedbd10ef795fff85f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
