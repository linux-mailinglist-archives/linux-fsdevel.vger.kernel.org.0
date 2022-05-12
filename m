Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF94525416
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 19:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357294AbiELRuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 13:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357289AbiELRt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 13:49:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAE31FE1E8
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 10:49:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A268F60C69
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 17:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 125D6C385B8;
        Thu, 12 May 2022 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652377795;
        bh=xOv7pGmndc+7LWBthz2TluzCxEg7kP3wIpc69A58glo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OYzKqpzN7H6dg/DStokFdN4SpDl9fznWh+I+3DF0vH96SMcy7dbECCPCfp6wP7lVY
         ov4cMQX5ICQ+HiqCN1UwD6qWIl6yP6Sl4412C79egi8IJy8O+THt2yzPObTiXEPj5H
         HILCgJDJKN8UNjraOfVmx9RdYU3l/2j17jgLLFRzis9j/E3Jpi2LXDRsp7TOfjK8UT
         XyEckg7dFG+LhDhp6aR+girvHaiGEEloZUeaRPlaQCitZk1ejFPV7jL4tlpOKAmuX6
         U31ZFLBdy/WOwfFcmm3khaOgymCD2NidKJ3iNhfkG0MXE/r/tvkSqKPeLJLhTrY//c
         hZbyfX+FMNkNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F21E4F03934;
        Thu, 12 May 2022 17:49:54 +0000 (UTC)
Subject: Re: [GIT PULL] Three fixes for v5.18-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220512170128.ivnuzvsspd4bbdyb@quack3.lan>
References: <20220512170128.ivnuzvsspd4bbdyb@quack3.lan>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220512170128.ivnuzvsspd4bbdyb@quack3.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v5.18-rc7
X-PR-Tracked-Commit-Id: c1ad35dd0548ce947d97aaf92f7f2f9a202951cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c37dba6ae45c2f0ec9913d7c96790fc00976d3d4
Message-Id: <165237779498.3166.15978816710167425028.pr-tracker-bot@kernel.org>
Date:   Thu, 12 May 2022 17:49:54 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 12 May 2022 19:01:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v5.18-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c37dba6ae45c2f0ec9913d7c96790fc00976d3d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
