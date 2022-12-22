Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B43654694
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 20:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbiLVT3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 14:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbiLVT2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:28:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5483026AF7;
        Thu, 22 Dec 2022 11:28:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5E11B81F50;
        Thu, 22 Dec 2022 19:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BF2DC433D2;
        Thu, 22 Dec 2022 19:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671737327;
        bh=qI4EWlB+X51Rhi8+HoTK/M8EjBxx/6EywCaxj847JEk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HTLffqFBw6rwpJXdcCCaX4+9neBYyx1DuF3p2H/fexYl8CQfMXLSZOlcR5aMTSpIn
         NPNVtybcSmgyOiXwZWoFeUOj74IeYTHIYPr8Pdn/1z+UzVrxgAPrOyi1jA2RZTlwhM
         lKOKPxbndhaNoWhpIBzuv9seDsoSKM8gEpGHKdmUH4mlpWzFN+hcgGrPMOWYFPOtHd
         1Y+C5/520kFMeF0BjbiV62utmQXhrcBB188WxxjEZ6z2iY8+9FUwl6GwYDN7izkNId
         Zo8NzMgJXjBJiRD8mTxmfeAOQopc6XI9IbqNxfcWf+DV6cdMiuU0UrMUjYhlcQCvx3
         h16mOnPGsIFsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79F6AC43159;
        Thu, 22 Dec 2022 19:28:47 +0000 (UTC)
Subject: Re: [GIT PULL] afs: A fix, two cleanups and writepage removal
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2219505.1671710165@warthog.procyon.org.uk>
References: <2219505.1671710165@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2219505.1671710165@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-next-20221222
X-PR-Tracked-Commit-Id: a9eb558a5bea66cc43950632f5fffec6b5795233
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff75ec43a2f6fbf7049472312bab322d77eb1bde
Message-Id: <167173732749.14570.17368419975624435846.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Dec 2022 19:28:47 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        Marc Dionne <marc.dionne@auristor.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 22 Dec 2022 11:56:05 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-next-20221222

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff75ec43a2f6fbf7049472312bab322d77eb1bde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
