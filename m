Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4216A2701
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 04:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBYDkI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 22:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBYDkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 22:40:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0962611EB9;
        Fri, 24 Feb 2023 19:40:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A10E619B6;
        Sat, 25 Feb 2023 03:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E093C433EF;
        Sat, 25 Feb 2023 03:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677296406;
        bh=YL8dCl7AutCiTzqNMR2m5KT3bChx8XzbjFT+jYUPSOI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HoJRjRt5zUEE276Zllp+fMvem0vMJVgGSomiCZoyvtleZV+0tmeq05Mt6Q+2ldmSM
         fVJuWf2NDyAPtcy94UKpY5iSE8nqunJbdzlUzBNCtG7rFG7XirdJ9RbFGdL1bcruAw
         J7RlzjvUN51rVQMMJ56TbMvi8OyzR7lc2vHcKv1khs+kyeATGwc3OfGD51NvvTL1db
         D4Fsg5jjol+EsWWpQOViRxRpMDSc96qk8hKwshagUB7JZ0mgrOUHjYOFMtuVDTfb0p
         aiClXhHAkFEw9oYSp7atJRty9P00Za5v58o/n9f/68i33os02IucPP4w5Sc3WyBZjF
         FMVQSg/DiTX7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3AFCC43151;
        Sat, 25 Feb 2023 03:40:05 +0000 (UTC)
Subject: Re: [git pull] vfs.git minix pile
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/gtvKEGVuwHRZz6@ZenIV>
References: <Y/gtvKEGVuwHRZz6@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/gtvKEGVuwHRZz6@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.minix
X-PR-Tracked-Commit-Id: 2cb6a44220b974a7832d1a09630b4cee870b023a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 397aa6b63ff25cee0b8ed20a6d447527c8ab0849
Message-Id: <167729640587.19216.10931565895840984215.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 03:40:05 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 24 Feb 2023 03:23:40 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.minix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/397aa6b63ff25cee0b8ed20a6d447527c8ab0849

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
