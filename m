Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605E17ABC6D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 01:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjIVXrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 19:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjIVXrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 19:47:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD221A2;
        Fri, 22 Sep 2023 16:47:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F6D6C433C7;
        Fri, 22 Sep 2023 23:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695426425;
        bh=TdS1ZuZlAt40479VMrdWJdEh9l9LYee0826UvUik5mc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IZ4iWtqnyvib+zcPrewFKVRPVvppoV6vJEedPdwikN2FnBa/5d679tJhpGcq/AGEm
         kPUI6qGLFisg2SZd0P1mYwUYxyXCiEEDviepDxz/Nvxo2mTYLP7frv8XGVjhtoYpTJ
         0z5g2TUsbnrpksDrOlDzYB+2sAv5QAKoHS+jRhce+FnKBaUq5suFLFq4sZUhPq8mz8
         n18vrkaGoAGAjtd41856bJY4cXY2b8fsKPfN/uzISTbgcJk4shI9ksFfQnBPzqCDpK
         wsq+0Y1Sn93yh0pZC36Am6soJ3VMB2F9ZwN2Nsrq+W4mg/iLhoEmninwXb3/SmYh2X
         mNOO8hsGanM9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E725C04DD9;
        Fri, 22 Sep 2023 23:47:05 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ediqit40.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87ediqit40.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ediqit40.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git xfs-6.6-fixes-1
X-PR-Tracked-Commit-Id: 8b010acb3154b669e52f0eef4a6d925e3cc1db2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3abc79dce60e91f2aeec8abf1d09b250722fbeb5
Message-Id: <169542642550.13260.8636780757032586902.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Sep 2023 23:47:05 +0000
To:     Chandan Babu R <chandanbabu@kernel.org>
Cc:     torvalds@linux-foundation.org, chandanbabu@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        bodonnel@redhat.com, david@fromorbit.com, dchinner@redhat.com,
        djwong@kernel.org, harshit.m.mogalapalli@oracle.com,
        lukas.bulwahn@gmail.com, peterz@infradead.org,
        ritesh.list@gmail.com, sandeen@sandeen.net,
        srikanth.c.s@oracle.com, sshegde@linux.vnet.ibm.com,
        tglx@linutronix.de, wangjc136@midea.com, wen.gang.wang@oracle.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 22 Sep 2023 12:22:00 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git xfs-6.6-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3abc79dce60e91f2aeec8abf1d09b250722fbeb5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
