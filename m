Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C937586E74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 18:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbiHAQSn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 12:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbiHAQSP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:18:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADA933E16
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 09:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65961B81218
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 16:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19AF5C433C1;
        Mon,  1 Aug 2022 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659370692;
        bh=6xTOtrHsGm5naosYN3fuyrzv3DEzGnumW1IPFilsBJ4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gtoctKXnCgHTt/i10Bw0S0boXyjkkcQIe4xfyxBa39NK6NqmzMwHL/Bd2I3MRoPPu
         AXBVMVxOHoMofOjgSI3UbHzFLcJZiN2L4ZYE5nxfz5Ur9tU3ww7z7ybC1cuwUDX0j7
         KXCO0tMLoXjN8ELyEVCs06tWW8P81Ng1epdvrxca4c10IJddAB6yqhVe060dbdqbxR
         G6RRizolSCIdrUnsTwma4fUpASh8W+gJrbpqX/cENTXX50Cl33MmfFOJCKdCGphPRx
         GHw2TWZH1tt93GQlyoJkav+RC5/8x7aLqsv6tEij5/iHBNyVh2UjXsJLdrr/pb/lGN
         Aj3WpIxCwngcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08AAAC43140;
        Mon,  1 Aug 2022 16:18:12 +0000 (UTC)
Subject: Re: [GIT PULL] Ext2 and reiserfs fixes and cleanups for 5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220728122416.h4bu74ptr6l3g2ur@quack3>
References: <20220728122416.h4bu74ptr6l3g2ur@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220728122416.h4bu74ptr6l3g2ur@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.20-rc1
X-PR-Tracked-Commit-Id: fa78f336937240d1bc598db817d638086060e7e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af07685b9ca18a5104c073847c83cf443f5c6114
Message-Id: <165937069203.17475.13755418735561775584.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 16:18:12 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 28 Jul 2022 14:24:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af07685b9ca18a5104c073847c83cf443f5c6114

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
