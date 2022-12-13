Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6533864AEDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 06:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiLMFAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 00:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbiLMFAQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:00:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A961DF07;
        Mon, 12 Dec 2022 21:00:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A999D612C4;
        Tue, 13 Dec 2022 05:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1911EC433D2;
        Tue, 13 Dec 2022 05:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670907613;
        bh=cuqEn+/S2ALeXy5jLheciKaqqn7HzosNl4WLkx3u3Zk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XgjLs5zX7jM/lRXQ3TGcmPb5+BnXSkSh6Aj5/GFeUjiq59sauw6AtybxDTykM23dz
         B3AkLH+SMsACvY6vLqDcWi3p0WO+XBqwL97GrWEOX9W4g+nRMekSjPFHctSWwCY9bT
         M/la5jq/b+HmlURi1SLGgGMpN9zKLgldW6CmWkwxN12lIh/Cu4hVq6biiwV9quWmY8
         FsivFCi3qxLUiH8PSIP8u7vFwhm9HQ32/RtHjUIS8qMzjRYdO09G0HLcrfqFeCLyjv
         ZPAlgIEVGDFifD2SB8jwNNa6znbtUKblLQ7DXOhUsIslNQ8qY3HQXQ4H6xj4G9EDAK
         alHBUwu5v5Feg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03584C395EE;
        Tue, 13 Dec 2022 05:00:13 +0000 (UTC)
Subject: Re: [GIT PULL] xattr audit fix for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5dKudhCyAktI/8E@do-x1extreme>
References: <Y5dKudhCyAktI/8E@do-x1extreme>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5dKudhCyAktI/8E@do-x1extreme>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.xattr.simple.noaudit.v6.2
X-PR-Tracked-Commit-Id: e7eda157c4071cd1e69f4b1687b0fbe1ae5e6f46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07d7a4d6961a221af7023d08c89da8ed12fa7dda
Message-Id: <167090761301.4886.10813129644052859707.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 05:00:13 +0000
To:     Seth Forshee <sforshee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 09:37:29 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.xattr.simple.noaudit.v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07d7a4d6961a221af7023d08c89da8ed12fa7dda

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
