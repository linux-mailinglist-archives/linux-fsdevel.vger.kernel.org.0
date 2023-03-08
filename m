Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4209E6B12CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 21:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjCHUSA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 15:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjCHUR6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:17:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F0844A6
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 12:17:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1D476194E
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 20:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17618C433EF;
        Wed,  8 Mar 2023 20:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678306676;
        bh=syTO83SLsbD12/e0cQy+s9cLUgq8lfp1D08RDWuz6Sw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p7Dy4OKwioEtaQ9jysugbNIY8c/jWqctYgRKWOpNE8WIgrtJocL/GdaCazXDvEYOT
         LWSGp+CIoBn3IWvREQ4tASw8JmqPDE7lH0BYNXp8qB8sMojFCpeIoW+3JMObKu5ZQS
         jqRdWNDW2F24a8x3Kd2jydtlyjlp0u0uGDfMuJAEdsuDcKB35eph6/qOKzW5hnZ7y5
         gtc6JrAEA5518JfWwBD2Uh91a0LZSXeBIoCyGYSKYnE2NPVwPBmj7v1NEQQrmN8C7S
         khCEBaQ6lBX5Sjw4M8fc9V0ehKXhBKWMtcFuNh980BG/NoPt2tbKcGqTaah35j+esy
         XSAMF8IvYZADQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05B43E61B61;
        Wed,  8 Mar 2023 20:17:56 +0000 (UTC)
Subject: Re: [GIT PULL] udf fixes for 6.3-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230308154729.zes6jnivoawftrkd@quack3>
References: <20230308154729.zes6jnivoawftrkd@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230308154729.zes6jnivoawftrkd@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.3-rc2
X-PR-Tracked-Commit-Id: 63bceed808c5cafbac4e20b5a40012a0ec6c6529
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a98c9cae232800c319ed69e1063480d31430887
Message-Id: <167830667601.31327.4126788419936502340.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Mar 2023 20:17:56 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 8 Mar 2023 16:47:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a98c9cae232800c319ed69e1063480d31430887

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
