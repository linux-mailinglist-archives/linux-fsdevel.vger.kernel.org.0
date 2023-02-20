Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE25A69D58C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 22:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjBTVL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 16:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjBTVL5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:11:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0801CAE2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 13:11:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6A7EB80DCD
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 21:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C86FC433EF;
        Mon, 20 Feb 2023 21:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676927502;
        bh=BRFvUSVt+J7SMOvNM5EmrDD95zemlN+58dijROqa3xw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j159T/XA7ks2DSohrBkXjJca/ag4951lsBLXa2N8/MWcYmK5rAJVEcI3TJL/gbW8S
         noZTmdBW15/rjhToIjQf8hC45wGYp+mZ0c3oIjJgOo5Rnr3U2pwtgxalqMaf6teVSV
         VGx/xHXQpXmavOd3wDtrHt/d34kuGVpyvPvk4Ydjwy5GirXsKShc1irUZ198bdPE7b
         rfNwymQM7VXY7e6xcNIZIHf4KqOeA5YeAI8punPArf5ffPao4Sq7+P6zGTQaJyKEb+
         DB7p5FS3DCdFERuLzGbneq7wCsG3YNilgZMx2VfnVWqKQbqCkIu+pDvrur3YacPtLs
         ykNw/A+arUTKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C628E68D20;
        Mon, 20 Feb 2023 21:11:42 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify changes for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230217112939.daimrvd7uivov5eu@quack3>
References: <20230217112939.daimrvd7uivov5eu@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230217112939.daimrvd7uivov5eu@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.3-rc1
X-PR-Tracked-Commit-Id: 032bffd494e3924cc8b854b696ef9b5b7396b883
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd776a4342b322a9e3df59b2da949fac4db313a0
Message-Id: <167692750224.16986.16965496295048784279.pr-tracker-bot@kernel.org>
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

The pull request you sent on Fri, 17 Feb 2023 12:29:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd776a4342b322a9e3df59b2da949fac4db313a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
