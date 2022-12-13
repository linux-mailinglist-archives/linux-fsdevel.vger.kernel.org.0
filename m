Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CD764AED7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 06:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbiLMFAQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 00:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiLMFAL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:00:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964C51DDED;
        Mon, 12 Dec 2022 21:00:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50365B810DC;
        Tue, 13 Dec 2022 05:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E54E3C43392;
        Tue, 13 Dec 2022 05:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670907605;
        bh=JwYXKpAVcTdwR2Rf5xb2H8UJEsAzC7+7eh/QhcipVk0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=duSrA4mWbsAjvZYkFthPT8MTLcA7ZIwzW7598dScLDDb/5rKRkAIR3yjQUvkbMIR+
         1Y64okrlt5DoTj1csZ6kf9Q5jlPDOzlfJbfnSWc+d55s3+6PR9GzYdm0PMj8wixjPy
         0Dm2Rckew6iaja0vAocnmXICjjGWFTAL/Hoy/kdxIhSYrbarO41mEogYV16Ek40b4z
         drSw1bNF5lNz3+87J+mJzJFf8HFtwc16rcWlDUcxsLLq5Sztdm3dcLw86KnxCjWk1f
         J8Eyi76/wikTU1KSCXfEyd/5fgi1c/5F5HE4cQsQx5EPhOrmH65uyWA362l47Uxx6c
         NcsEtpq4mybKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA124C00445;
        Tue, 13 Dec 2022 05:00:05 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity updates for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5ayo48TtNrPgU9D@sol.localdomain>
References: <Y5ayo48TtNrPgU9D@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fscrypt.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5ayo48TtNrPgU9D@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: a4bbf53d88c728da9ff6c316b1e4ded63a8f3940
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad0d9da164cb52e62637e427517b2060dc956a2d
Message-Id: <167090760582.4886.14939795830910220424.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 05:00:05 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 11 Dec 2022 20:48:35 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad0d9da164cb52e62637e427517b2060dc956a2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
