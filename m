Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149C96ED4CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 20:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjDXSu1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 14:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjDXSuC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:50:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83737B44A
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 11:49:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DAD4628AF
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 18:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC364C4339B;
        Mon, 24 Apr 2023 18:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682362061;
        bh=dRBjelLaV92Fd4ow3kUwxneljdOqTcP6BsQmBL86i7c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A4tQavU51iR7B9+z8bYRF9ZrEPwQ5suVM0lWngqzOnTX8jmtJczu2FeI5CzdSC5xu
         Qt3BsHr2V1o1jLF10vVDLMPL1p02XoeXL0KxQH8+1WfG8qPDyC77u5iqAXAlCwB+i3
         HagiWvn2qyzw25+1Xeo5CXc2rBjvwYVd5ROp2MQaXymUENKoecvAOzCa1u9pwjjo+E
         OTp/SdBy9mb9o8JboDo/IQesvm1Yshyp3NnikuyLNBxl8iAeYGx5QpfBElpFFZcw3W
         jHhNvCFy85mxvZ30SJb4nzAlbVwb7CCiUimqoH+O/AiYEtBTHDIeMmoCT9/9dEiWRC
         c4DiGq0h+bjkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9B5AC395D8;
        Mon, 24 Apr 2023 18:47:41 +0000 (UTC)
Subject: Re: [GIT PULL] Turn single vector imports into ITER_UBUF
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f16053ea-d3b8-a8a2-0178-3981fea5a656@kernel.dk>
References: <f16053ea-d3b8-a8a2-0178-3981fea5a656@kernel.dk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f16053ea-d3b8-a8a2-0178-3981fea5a656@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/iter-ubuf.2-2023-04-21
X-PR-Tracked-Commit-Id: 50f9a76ef127367847cf62999c79304e48018cfa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9dff2195f8a5847fad801046b26955e05670d31
Message-Id: <168236206182.5635.4569034066349276876.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 18:47:41 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 21 Apr 2023 10:53:08 -0600:

> git://git.kernel.dk/linux.git tags/iter-ubuf.2-2023-04-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9dff2195f8a5847fad801046b26955e05670d31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
