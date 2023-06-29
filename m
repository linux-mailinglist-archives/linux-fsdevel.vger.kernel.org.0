Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919B0742F0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 22:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjF2Uwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 16:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjF2Uvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5D530DD
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 13:51:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E3BE61632
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 20:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B439DC433C9;
        Thu, 29 Jun 2023 20:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688071897;
        bh=Pl/udTSSE6Q96urQufPJ7uHEb/aV+0EcTXnNIzBRH1w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=owiHzPOAMOHImTYNLGpUvuRq50UtdvrV+IqjMrdIpZoR3/6X6qWwwItjgndrjNJtQ
         IKssP84PwDtNuLvmIyz7kIVpNMbv4UoxINcidA0qLFBPO9mToEEI0KVIO9nssKw7BP
         oB3j7mqJoCMHVh6mnkGIJu7aO0TRdxKgLKvR16HlaU4h0XPyrkhr3RTQHd9KeoVEVh
         +brvc5vH7/mgPO3X1Wk7+ybodvMIZa6eo129q+pU98If7iLTjKq8OCiHq36MaJxc/8
         fLCOd8DEzmRIxgKinBsvroLE8U/g7w/kmOLzTJnQ6/XHX37hCI20/QB397zCupGHwD
         4Vv+zZ1X7zVHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A30ADE5381B;
        Thu, 29 Jun 2023 20:51:37 +0000 (UTC)
Subject: Re: [GIT PULL] Filesystem fixes for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230628152314.ynd5xt4ip3zk53go@quack3>
References: <20230628152314.ynd5xt4ip3zk53go@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230628152314.ynd5xt4ip3zk53go@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.5-rc1
X-PR-Tracked-Commit-Id: 028f6055c912588e6f72722d89c30b401bbcf013
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6b0271053e7a5ae57511363213777f706b60489
Message-Id: <168807189766.21634.17467705820473135185.pr-tracker-bot@kernel.org>
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

The pull request you sent on Wed, 28 Jun 2023 17:23:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6b0271053e7a5ae57511363213777f706b60489

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
