Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FCF4AAA94
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 18:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380726AbiBER3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 12:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380724AbiBER3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:29:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B42C061353;
        Sat,  5 Feb 2022 09:29:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02EC0B80B74;
        Sat,  5 Feb 2022 17:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC13BC36AE2;
        Sat,  5 Feb 2022 17:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644082166;
        bh=5+HCditrbPpy5v9oHJPHL9rhep8qdFsY4P9gEPHMytw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iEzyME8CgwGflpi+fZZ2OoNkTzNPFfhLcmajSpkw+48aXn9coT47tkpc/UMzVFJmL
         +EHU0jLP8bi5JD9hGXNw40aHBJXZDuG+EJ675KNm+09Tv8a7ApsvR/e4M49o4WJvxm
         lLMsCMlmpqBpd02xrXRETf3Em1ud1zzxuiGHsuZiD8WFu/Jh/msRSc231RPIWLPVA9
         BjoqdpivC164POeCeAlq07BsDVboofeB2EfakvG//rz5OvFNQ0FtUDGkWjIWDeUKQp
         rvO6RYz44FvQwdpjCjVDtow85iw4MaWCRorGYkF4W8PSAKQw5ik5teXAE7goF6Y8WB
         XSCbOynm5XDdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9848CE5D07E;
        Sat,  5 Feb 2022 17:29:26 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: fixes for 5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220205025606.GX8313@magnolia>
References: <20220205025606.GX8313@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220205025606.GX8313@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-fixes-1
X-PR-Tracked-Commit-Id: cea267c235e1b1ec3bfc415f6bd420289bcb3bc9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbc04bf01a8d5a639c2e90fea9402f715cf10ff2
Message-Id: <164408216661.7836.4930013315804213982.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Feb 2022 17:29:26 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 4 Feb 2022 18:56:06 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbc04bf01a8d5a639c2e90fea9402f715cf10ff2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
