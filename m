Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1525610108
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 21:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiJ0TCP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 15:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbiJ0TBx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:01:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300BC5D893;
        Thu, 27 Oct 2022 12:01:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ED1262445;
        Thu, 27 Oct 2022 19:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B09EEC433D6;
        Thu, 27 Oct 2022 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666897280;
        bh=cNHfST1sPAW+Zp1W/OnF1Y/ZS8Q11rVmsBRFKvTt6bU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nZT65YZMder8MG57z9PLMGexs2XG7P7ZoB5bKBi7wkFh4mhpWvtGgE/9TlU5zKcAh
         6+kNJ4KLBAREOmPVll/8KBTLye5VIdsd/brNB15/tssoF1oeKuLf1Ym2bOIGOj6FTh
         YmmdPcLrRl2QlKUFfmSm5HpVm5QnKl5x+uyTgoxZARn98Pvvgo1/yfk+6SSfduYMJ1
         L2u0ntfzX6QJAfmV6dm3uK/M49k4nRyVv9YPW9hV+77HNNpoRwFglZUzQ6TIvm1Nw5
         jRoMwmniXSa94zU5C3aI1ysCUFZ2gO9gDWClULAt5cYmXTsyFVoRYba5Cq7VJbv9K4
         BTVWIm8ii2ZWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D3D7C73FFC;
        Thu, 27 Oct 2022 19:01:20 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt fix for 6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y1oPDy2mpOd91+Ii@sol.localdomain>
References: <Y1oPDy2mpOd91+Ii@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fscrypt.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y1oPDy2mpOd91+Ii@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: ccd30a476f8e864732de220bd50e6f372f5ebcab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 200204f56f3b5a464c719ddb930a1a2557562dda
Message-Id: <166689728055.22946.5315906565732942930.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Oct 2022 19:01:20 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 26 Oct 2022 21:54:39 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/200204f56f3b5a464c719ddb930a1a2557562dda

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
