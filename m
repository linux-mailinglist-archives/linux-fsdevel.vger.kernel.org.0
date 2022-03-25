Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2B54E6C18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 02:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352712AbiCYBk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Mar 2022 21:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357638AbiCYBiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:38:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E40BF53E;
        Thu, 24 Mar 2022 18:35:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E618060B2F;
        Fri, 25 Mar 2022 01:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E0A4C340EC;
        Fri, 25 Mar 2022 01:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648172142;
        bh=NiMOmtM5IBbWeap3sQWWZvW/eoEk9Sp3PdJxVqKhSi8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gXgAnl4Wpxslb9ZuOIwFdF66hlQSe3ZZpFFFxb0eTRJnMsI/H6KaEdvkC9dRomD+/
         /lHzmzOnHiKD0d99KrEB9KvRz3B//eWJqdX7HYSrtk6FG3NYc4vhYYkEP0Tf3NULcQ
         kMgXRZzWaB4Z8XMmLahaubcRKqntT04k7co6u1l0dYCZ0Jbd7Sjz6trTvh8DURDosV
         y+dTC8WtrkiKAEAAe8WX+MNao0Nn4lwt8ayOoaROlcU6eFT+imMo3793omzrvqQglW
         FrxbxxX2OlFVmc6OLQRozYOOWgo6w0maYjtzEsDrPsjeMDsueZNDWtefhdciUYiSfc
         ZpA4jvrF7Cobw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B061E7BB0B;
        Fri, 25 Mar 2022 01:35:42 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220323164821.GP8224@magnolia>
References: <20220323164821.GP8224@magnolia>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220323164821.GP8224@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.18-merge-2
X-PR-Tracked-Commit-Id: 01728b44ef1b714756607be0210fbcf60c78efce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1b07ba356f04268230e16a8e1813fe1b19dac54
Message-Id: <164817214223.9489.12483808836905609419.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 01:35:42 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 23 Mar 2022 09:48:21 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.18-merge-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1b07ba356f04268230e16a8e1813fe1b19dac54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
