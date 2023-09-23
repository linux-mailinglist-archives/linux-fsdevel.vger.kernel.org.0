Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE89D7AC465
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 20:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjIWSZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 14:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjIWSZV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 14:25:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4DC113;
        Sat, 23 Sep 2023 11:25:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01C4BC433C8;
        Sat, 23 Sep 2023 18:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695493515;
        bh=L0WlxjCS+oz/qWDEVRmJpIOxZkdzhaBNm4IrsFD2uoQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iJ3XM4XXZC1cOiS+YtpF6wosRNlx+dxf/IQQiG9uzfy3qMvehekfWczQPqXM1J7Gq
         ui0PMmS+IwGsCl4bgVjp8nr9VybXot4aNZdYABwZRTsombMgcOYCyLz9A4G+dgobtN
         jrcRA9dAUoVt+HMCuGVnY8+/KS1t+DB0i6TOy+xPfHagGMOaa8ZJ28vCJbDyNjUEFZ
         YKrUSYkr2RcH0a6FxjFyxQhJl3TmUj9hGR5BHPFUXQ6zGoTUj+u+CfLhvIbbUWAAuV
         7PcRVUTWbpW3aRM2jAz0EhjHq67M3yAzj+5cvOz8DJIk/yKfdrJA/7eA21PdyrjruW
         J9Q8JFmdscnRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E07EFC40C5E;
        Sat, 23 Sep 2023 18:25:14 +0000 (UTC)
Subject: Re: [GIT PULL] iomap: fix unshare data corruption bug
From:   pr-tracker-bot@kernel.org
In-Reply-To: <169542943249.26581.2290117144266358331.stg-ugh@frogsfrogsfrogs>
References: <169542943249.26581.2290117144266358331.stg-ugh@frogsfrogsfrogs>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <169542943249.26581.2290117144266358331.stg-ugh@frogsfrogsfrogs>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.6-fixes-2
X-PR-Tracked-Commit-Id: a5f31a5028d1e88e97c3b6cdc3e3bf2da085e232
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59c376d636387a9b896c8da1d1bb68bb0bda67c0
Message-Id: <169549351490.14827.11803409830201822927.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Sep 2023 18:25:14 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     djwong@kernel.org, torvalds@linux-foundation.org,
        dlemoal@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
        willy@infradead.org,
        syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 22 Sep 2023 17:39:01 -0700:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.6-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59c376d636387a9b896c8da1d1bb68bb0bda67c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
