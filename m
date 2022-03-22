Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AA34E460B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 19:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbiCVSdd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 14:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240911AbiCVSdZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:33:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7FF8CDBB;
        Tue, 22 Mar 2022 11:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 089A7615EE;
        Tue, 22 Mar 2022 18:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BF36C340EC;
        Tue, 22 Mar 2022 18:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647973916;
        bh=QmIvL3x8HBh1HSJ5HGqlajc0d/oc/GSWwN3g8Ue+tgw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qpQNaLLWNGdTXJNp1yFVvP8HOkGwx10E4oaW9mgIS5zeqS0KdAK1xdiDYY7YCCVIj
         RKe62fmkzdU+UFK92nh4q1RqbY+JPhC9U/NnVoPqcE0PpKUOC7jlYC0eAwMVFWpNgC
         GUVxknfyxKOSbPYaViwtPjtGcPpk0irruF0YRaaxFKthX9LCTbaaiPBObr07CrCtpq
         /YNnk8Alowa8viXW8Fzq4AiuhYaDg2F2x+PreKOC6lweqOEpNYvvRIuwY1CmxJcFUd
         eHUmU0BXIdawrYE7l5FoJhLHi1pJ0W//NfCq3yxEnTNunRYvKfVWqqh01jVQpvJLZP
         DFSdugupI5e9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 535C8E6D406;
        Tue, 22 Mar 2022 18:31:56 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt updates for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjgEC8Nw9PDmdY0O@sol.localdomain>
References: <YjgEC8Nw9PDmdY0O@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjgEC8Nw9PDmdY0O@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: cdaa1b1941f667814300799ddb74f3079517cd5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 881b568756ae55ce7d87b9f001cbbe9d1289893e
Message-Id: <164797391633.17704.3889508763261319003.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 18:31:56 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 20 Mar 2022 21:50:19 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/881b568756ae55ce7d87b9f001cbbe9d1289893e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
