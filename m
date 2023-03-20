Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749276C24D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 23:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCTWlJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 18:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCTWlG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:41:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153C832E7F;
        Mon, 20 Mar 2023 15:41:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39E8D6189D;
        Mon, 20 Mar 2023 22:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9891AC433D2;
        Mon, 20 Mar 2023 22:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679352060;
        bh=4L3Vx+UfdHeCQ+mCpbTW/50O8QaAx0uC4OXnthxEgek=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uURGoqvpwXIZ83HOWzVL+0nb6IWMcpn4O7M3phGCkI2iLZ3h+rkJOip184AUJyo1P
         WsbBR8orVCbRkNOQgyoi7JeaSOBrhPCLiTAVU2CHdNcITvOueB6aUemRkBNvC0x1Fc
         Ho81JQ7xT16vzxETPch1CMbJVeAn4BIsQHwlhN0ZSeuHP8kiH+vmaspg4UFo+Jp5PK
         ZPCxKz1ReNL5b9Cu31SGV/AdL9x4YIzA+Wnc+24us6l4tHqktiXghvjYB815yGibIA
         N4RPfkn56hagAiy4l6GtFa5D7yfYnZfoS1A9YTWcw9HQEpQGPkEgU63pNegHcDuoGZ
         6HyCRzTvsMo9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84176E68C18;
        Mon, 20 Mar 2023 22:41:00 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity fixes for v6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230320210724.GB1434@sol.localdomain>
References: <20230320210724.GB1434@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230320210724.GB1434@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: a075bacde257f755bea0e53400c9f1cdd1b8e8e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17214b70a159c6547df9ae204a6275d983146f6b
Message-Id: <167935206053.2111.7324679666714851244.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Mar 2023 22:41:00 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Nathan Huckleberry <nhuck@google.com>,
        Victor Hsieh <victorhsieh@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 20 Mar 2023 14:07:24 -0700:

> https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17214b70a159c6547df9ae204a6275d983146f6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
