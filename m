Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192F050C13A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 23:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiDVVj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 17:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiDVVj6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:39:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F4C1E9DB2;
        Fri, 22 Apr 2022 13:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA9361E71;
        Fri, 22 Apr 2022 20:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 728E6C385AB;
        Fri, 22 Apr 2022 20:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650660400;
        bh=AdXhmtSTpYKpMcmRZqTIKrMYIbiTtOX+0k+P+DlYDv0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hcogm+21/7SKIYhAm6Gq2U7BBBbnR6sZp0g2XGnpg5TKxgPVdZNE2lx7kcGqMCWqY
         jcvY0tCx5drLB1ja++doe1yq2Fu3MXoM2Se1BiXZIoUx5mhNf/GUPE1URQ3UFSL5G2
         WPcxNmxIIN2XTlMWi8sZ0fcV8Deu73O0mX83FY89bscMXAFV2CS26G9MOwS/66u4EF
         pkQQV5JUvzpmADWZFJ1UjjCU6ukMAye5E3d5sWDvtRoKNPXW6tPiT4OgyTBy0xZEvE
         G700yUftJI24Atc10WVthO9BVQ/Sek8j/PyE15gRu5yqt2WgoZCGijSFSLCdgg+5dL
         lkw29UWPC4Uow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F746E6D402;
        Fri, 22 Apr 2022 20:46:40 +0000 (UTC)
Subject: Re: [GIT PULL] Rare page cache data corruption fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YmMF32RlCn2asAhc@casper.infradead.org>
References: <YmMF32RlCn2asAhc@casper.infradead.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <YmMF32RlCn2asAhc@casper.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/xarray.git tags/xarray-5.18a
X-PR-Tracked-Commit-Id: 63b1898fffcd8bd81905b95104ecc52b45a97e21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22f19f67404833c2282b7a8c2f4703d9aff8f748
Message-Id: <165066040038.3510.17469771036327281492.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Apr 2022 20:46:40 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 22 Apr 2022 20:45:35 +0100:

> git://git.infradead.org/users/willy/xarray.git tags/xarray-5.18a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22f19f67404833c2282b7a8c2f4703d9aff8f748

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
