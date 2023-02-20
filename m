Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD3869D4EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 21:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjBTUXs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 15:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjBTUXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:23:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC3C212B7;
        Mon, 20 Feb 2023 12:23:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3D2560F45;
        Mon, 20 Feb 2023 20:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5248C4332A;
        Mon, 20 Feb 2023 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676924405;
        bh=yDMATgylroDX89FLnuj7maemArnbS7kpDPETWLDIMsM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=maoR3C1i2vS8wKSF2j/l3ln+mzIcyOBhkJ/EFrIqe7fBxI4eunWsSLE9ODvp5bS67
         A1tbr69jaugOuYmZERVUcwbfC3q1qFTuaTVMsIWZ6uvsfIhLYGTieKTuCRTgrCtK/K
         MmDyFMblORFBnGRNx05non68DkEOpdtUFq/SWDJtUkaz+sfV5Ec4r2t7+bhVVvhUcn
         mfpToaGKKcLZXYK40kvfkfG3Wp7YYZb+IeelwRVXm8jm5DD9IlGoSFYjnXFzPTGmnM
         Hw58Qg+SplGea3S7GXTHLejHbmvu8oojmd2GCNJIl/SkehrEf3ybgrgw3vNp0PSshL
         /H0GHXCziHVVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BFA1E68D23;
        Mon, 20 Feb 2023 20:20:05 +0000 (UTC)
Subject: Re: [GIT PULL] fs updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230217080755.1628990-1-brauner@kernel.org>
References: <20230217080755.1628990-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230217080755.1628990-1-brauner@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.v6.3
X-PR-Tracked-Commit-Id: 47d586913f2abec4d240bae33417f537fda987ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea5aac6fae94bff4756051b0503f86e31ef6808b
Message-Id: <167692440563.19824.16071161083391467935.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Feb 2023 20:20:05 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 17 Feb 2023 09:07:55 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea5aac6fae94bff4756051b0503f86e31ef6808b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
