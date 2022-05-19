Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BFE52C8A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 02:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiESAf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 20:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiESAfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 20:35:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A6FED7B4;
        Wed, 18 May 2022 17:35:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25BAAB80EA7;
        Thu, 19 May 2022 00:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAC97C385A5;
        Thu, 19 May 2022 00:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652920520;
        bh=MyQZfnUUYrJZEOFRO7RiXIEHbYea85zPOhGXi3211zI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=st5FFcX9iqeqhd+l2I6VUEHLLjXixDiBX+/sxlU1dpPLdatujEnYiCrCcu9xmCpCc
         H+Be7mC1pAlYKyKa5Hyq4gCAt/N0sWPf9OZuYxHTP/+GnwZszV4zbJfxyNqwqGU0O8
         GgOsE5ccZIz6hLqCbcpvnhyxMQmYECaOql7YhzIO0CwjWPgUf1BdhNZKDFWqb604PP
         /yT5ScJ/k4jOKyeJ3knqEHyoXu/A78D+nD4KTXmQuOUlgnLGGKEs+77+dxB7G680Nm
         MEbiyc0MHBunquGczj6kU/dr6GDb7ehnAEWZNvu5VCCYEVAQteplI6U7u0JmXo4356
         YRFo+2HQkm7NA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9586F0392C;
        Thu, 19 May 2022 00:35:20 +0000 (UTC)
Subject: Re: [git pull] a couple of fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YoUiHhz1NsTbN5Vo@zeniv-ca.linux.org.uk>
References: <YoUiHhz1NsTbN5Vo@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YoUiHhz1NsTbN5Vo@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: fb4554c2232e44d595920f4d5c66cf8f7d13f9bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbd380bbffc81f64afeb24c6188fb6889d431a80
Message-Id: <165292052082.29647.7231346230942188817.pr-tracker-bot@kernel.org>
Date:   Thu, 19 May 2022 00:35:20 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 18 May 2022 16:43:10 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbd380bbffc81f64afeb24c6188fb6889d431a80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
