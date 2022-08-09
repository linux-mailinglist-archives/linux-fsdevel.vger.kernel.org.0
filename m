Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CF858DD30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 19:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbiHIR3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 13:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245702AbiHIR3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:29:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C967C252B6;
        Tue,  9 Aug 2022 10:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 47706CE171B;
        Tue,  9 Aug 2022 17:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD044C433B5;
        Tue,  9 Aug 2022 17:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660066182;
        bh=1s0kU8ZNmQOMeHYS5xzh4rY1xIVgQNQ7pjwwn99rFiU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=The/Vfktse3a86iT9E/03CwodAA3AWwJa5M4n68m6ZjPTCCkZPhJqMQ0oWR1VfNH7
         ULy8rwfuYsOthI7fe8UqLZeI7d9Cfxii7oo/dOetWOk9TdrsTzkdYmG2qyOsCAMr+t
         T5iJkVLwL+wQ0u2/uwQulQ2ISPpdknNHcyGnQKJcWcs5a0fL5MdwiH9b6UF6V2jwa9
         D9MovMQUPgqUTBRzqcbsSS0ZJ62Uy5ZeYfiDKie5hIMMvaALLGo3wS2GNoqXPI2CYX
         LlK1y8MAqDv0XQ0qaQos7c1TiutQ2r7H9EbAzGUF7sUUnouYvaVGLkDwm8J0ZYxsrh
         sI45UOGgQAEbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97D75C43142;
        Tue,  9 Aug 2022 17:29:42 +0000 (UTC)
Subject: Re: [GIT PULL] afs: Fix refcount handling
From:   pr-tracker-bot@kernel.org
In-Reply-To: <432490.1660052462@warthog.procyon.org.uk>
References: <432490.1660052462@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <432490.1660052462@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20220802
X-PR-Tracked-Commit-Id: 2757a4dc184997c66ef1de32636f73b9f21aac14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b22e2074195097c9d6bdc688288d12b7b236bae
Message-Id: <166006618261.16033.9354503954549139819.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Aug 2022 17:29:42 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        marc.dionne@auristor.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 09 Aug 2022 14:41:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20220802

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b22e2074195097c9d6bdc688288d12b7b236bae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
