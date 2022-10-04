Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D105F3BCD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 05:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJDDp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 23:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJDDpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 23:45:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D002813D49;
        Mon,  3 Oct 2022 20:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7088061255;
        Tue,  4 Oct 2022 03:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D525FC433D6;
        Tue,  4 Oct 2022 03:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664855100;
        bh=dMhYL0DHz+DZNJgFTOV/hKsuUe8uOmLPTb3gEZI36tQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iSO9zQAWnzREgesHtsbDIn/8ChKjJhETmQqXMKiwxzjgvLfR0kG/jyjBcEl1bVU0X
         U66Kik8qpMjlDmVDHEsOmBe61OIpnm+ohJR3QN0/8aTIlq9afKR2WFDJg/ptHdrQCM
         3S04UwVNWkp7DDm0Ew/+88DTTN280e7+uFjB58lbYmaCCdAALLA/DMShGJ6B4Kg+5Y
         K07yH2p7rtRaQ/WZTBXlivX4lBasO2wARQ4V+ela3YhVz78Jvchj/NLua4VE6Idjd9
         CHKyXzTiqZGMYaozxxDlwPHINyCVW/hLDLh6dzO890TREfFvHsX64OaSAZYjvTrdxt
         PA0pZmt5XaXvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C231DC072E7;
        Tue,  4 Oct 2022 03:45:00 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity updates for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzpQziDjTaZADriK@quark>
References: <YzpQziDjTaZADriK@quark>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzpQziDjTaZADriK@quark>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 8377e8a24bba1ae73b3869bc71ee9df16b6bef61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5779aa2dac9a8dcad89b3774ee354de8b453ab21
Message-Id: <166485510079.18435.12173572676581593608.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 03:45:00 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 2 Oct 2022 20:02:38 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5779aa2dac9a8dcad89b3774ee354de8b453ab21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
