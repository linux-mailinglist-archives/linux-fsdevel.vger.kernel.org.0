Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC660531E18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 23:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiEWVkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 17:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiEWVkt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 17:40:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CD85FF1F
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E27D561531
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 21:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EF40C34115;
        Mon, 23 May 2022 21:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653342040;
        bh=Wq4c6GXphqaAnTpXdOcPtesaWRIgZz2PdSsHuhjNAuo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JMd2ZcoLwc3JGd5D11zPyXvv6O2ZTk0jYYpE+WuVezjrG4Fxs1U017C5s3zLZcA8H
         IVLBWd05Vl9Apq3JNF4mOqkgVvyusVN5RIptzIyA8DFVsSpKGgTtSfBc2Y2ZAyjJly
         w3VwtqVlBaiJkTp7+QydOGIm4bEdzQVgE40QdJYHawPQctNXp/NNgNQ6b/4vPTc2If
         dIzByWH92XHNj2zNkvbmJc6OuTT25IixxB5y1DFFArYT1pH2o0WShs8eMORF6eowHE
         i3M/Kd+Fqae88lYTZ+dIKJ8AJlopyyjbTdoXnZHgtzQYjXMjQoUKQHquqYpoS51LiM
         UcKmYwZ0wfaCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C39EEAC081;
        Mon, 23 May 2022 21:40:40 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs changes for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220523050144.329514-1-damien.lemoal@opensource.wdc.com>
References: <20220523050144.329514-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220523050144.329514-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-5.19-rc1
X-PR-Tracked-Commit-Id: 31a644b3c2ae6d0c47e84614ded3ce9bef1adb7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 140e40e39a29c7dbc188d9b43831c3d5e089c960
Message-Id: <165334204023.21378.9434029489022386284.pr-tracker-bot@kernel.org>
Date:   Mon, 23 May 2022 21:40:40 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 14:01:44 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/140e40e39a29c7dbc188d9b43831c3d5e089c960

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
