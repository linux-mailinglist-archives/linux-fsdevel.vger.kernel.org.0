Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB7258DD31
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 19:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245308AbiHIR34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 13:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245444AbiHIR3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:29:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA492558F;
        Tue,  9 Aug 2022 10:29:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29B9460F2A;
        Tue,  9 Aug 2022 17:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85C5CC433D6;
        Tue,  9 Aug 2022 17:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660066182;
        bh=K0aTzl+Xj/MgnNACv7Y/18Rpa/8JIsaQY6MoUV9XplE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DvwE8hTsFG2n0utnL0XGyJFe6Kl6N9Jq9Oj6WuUXo8BH/AFczoBjfTXSuQPN15L3j
         M6ht4LhbdxRBSGC7gHRYMIk2yUDfCdpIRcQdkO3oa/dNMKV94APqpzxro19i7sdzMN
         e8nF1tVSBjEEKJLxBYQqoE2p86Xm2byFhzVVOp2bxMcWpQtTkFirSpHGX6Rym7Cm3P
         lKzBBSCzYsXmD3gBmPKMs6uOU0PmP04EMkLQ7rvQjdae46hyyo0F/6WR9T9Nj0z6uO
         aFygU0t7IRJvffOB1uMf58w/H3xMaTQsqNIISplqCSeu8Uk01qVRNCaUbaJb/H1BdF
         ViZdrKFQCvnFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F550C43140;
        Tue,  9 Aug 2022 17:29:42 +0000 (UTC)
Subject: Re: [GIT PULL] 
From:   pr-tracker-bot@kernel.org
In-Reply-To: <431242.1660051645@warthog.procyon.org.uk>
References: <431242.1660051645@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <431242.1660051645@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20220809
X-PR-Tracked-Commit-Id: 1a1e3aca9d4957e282945cdc2b58e7c560b8e0d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15205c2829ca2cbb5ece5ceaafe1171a8470e62b
Message-Id: <166006618244.16033.9864491589347925426.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Aug 2022 17:29:42 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        jlayton@kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 09 Aug 2022 14:27:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20220809

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15205c2829ca2cbb5ece5ceaafe1171a8470e62b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
