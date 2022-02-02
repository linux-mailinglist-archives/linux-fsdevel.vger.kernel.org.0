Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41E04A77C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 19:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346609AbiBBSTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 13:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346611AbiBBSTT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:19:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3CDC061714
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Feb 2022 10:19:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5FCBB83225
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Feb 2022 18:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76D18C004E1;
        Wed,  2 Feb 2022 18:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643825956;
        bh=pMqeYuDv7Up0mq7NWYEDKrMBeuri/wtBlMzsnpS518E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Mq0mofTY5tLzF+aTSfq7ko/dbKA1+DZNYGbS2iS6G3T5cUpwx0U1c4A2pqNsNsgsf
         VmnkmJ1hmUtAa2aOYSwQ954vZl3Y1OaS2NW2LF9zgnUIJD/o6aDbSrXm+rCnqxjWwl
         o3MkKimRVr5zyxLokc2pTISykUxy/67VnrcsoZrQLaxZZarrPd0KZe49abZ25nYoMx
         aK72XOGy/28YJnpguHEANKiAFFRSvctwF/CgvQKzWnE0LRIdVZR54PmOgnwS1ULDZ5
         +q5xLJRY4wyaLjMOoSgKMMmHPajqPVEp6H378be6zzlEb3t0kFsMoSTU1kZFz3og3X
         rYgo5Y+z4sR1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 631FCE5D091;
        Wed,  2 Feb 2022 18:19:16 +0000 (UTC)
Subject: Re: [GIT PULL] Fanotify fix for 5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220202131243.oe6w4ffjamujgnea@quack3.lan>
References: <20220202131243.oe6w4ffjamujgnea@quack3.lan>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220202131243.oe6w4ffjamujgnea@quack3.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.17-rc3
X-PR-Tracked-Commit-Id: ee12595147ac1fbfb5bcb23837e26dd58d94b15d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5084ffbc50c76e4a237d87e022e88f6b15b3cb9
Message-Id: <164382595639.967.17146139408982818459.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Feb 2022 18:19:16 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 2 Feb 2022 14:12:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5084ffbc50c76e4a237d87e022e88f6b15b3cb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
