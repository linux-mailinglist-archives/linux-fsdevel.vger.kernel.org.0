Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927CD69D598
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 22:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjBTVMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 16:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjBTVMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:12:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A959C1D901
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 13:12:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10B8360F26
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 21:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 735C7C433D2;
        Mon, 20 Feb 2023 21:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676927502;
        bh=RX302KYFequOmukSSBRPiURC5VNgeGEiSXqv0aHN1pc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RKQJxKmO7NuR9ElMERBZcMYLa8vT9qx7DnSbp68Cg48WiAceq+K+WN8S9HgCSxIX2
         Lm5peiZMKbnPpBfDTOQ+pM0ifjKMNsMNIqUSDwS8g2XBy+gJ3SVCUGUAw6VuhtZqKw
         o2G/ZPGLixLG5hZYMwCpT+l4k1qk6OYTy+R2YvmXlQK1d5Ccn94s7um829rhlrOb0Z
         9D4Mh1/SwkL1sCpBXbKQWkNd5B28K5sBA+bGy5iSm7kIKYutuJjrhD4Cg24refkEVR
         GubMdHtGNTEF1Ql84LbMHm3mIKnigkM8eru2GvjXd+6dQBUk5Q/76gPOhscOmv2KGD
         uZ+4GdrTozTVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 632ECC43161;
        Mon, 20 Feb 2023 21:11:42 +0000 (UTC)
Subject: Re: [GIT PULL] UDF and ext2 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230217114342.vafa3sf7tm4cojh6@quack3>
References: <20230217114342.vafa3sf7tm4cojh6@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230217114342.vafa3sf7tm4cojh6@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v6.3-rc1
X-PR-Tracked-Commit-Id: df97f64dfa317a5485daf247b6c043a584ef95f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 274978f173276c5720a3cd8d0b6047d2c0d3a684
Message-Id: <167692750240.16986.9323349640571964364.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Feb 2023 21:11:42 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 17 Feb 2023 12:43:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/274978f173276c5720a3cd8d0b6047d2c0d3a684

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
