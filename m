Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3054EFE18
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 05:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240809AbiDBDJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 23:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbiDBDJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 23:09:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669C049936;
        Fri,  1 Apr 2022 20:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0260961CC2;
        Sat,  2 Apr 2022 03:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C072C340EC;
        Sat,  2 Apr 2022 03:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648868867;
        bh=nia9gVLequCKrCipSRiu9PLs45Z5+qelDo++sMvE2Ik=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OIIPpUOwuoBPK58BBKexxJG2mHkfFju+55A1jYXD4VPo3vwSdmRcXDsTLkkyn0wY6
         XH4pXkVaycb8fCGu8qkN3teCa9nyg7rtylF2ufBoDiiGIRzUifVNcoI5Fakhiy6pou
         kpwG1f29QIzbc8lr4hJdkbM4cWCcjnm6zpypZg16x1OkT8rLW2q8JxY2qJ+IrXPBKw
         kyxyEceHB9qPUfEEsqrG/U8CPbOjqF72JOWq2ye2RHqERpK/NeertzliHuhU5LNRGj
         vUBHc5akOMmUHC3W6yy3Kguv15Y+2dLyR5Bk4knJ0unWKzR0MXfoOQEqYFxkImOGB3
         sVCU6Rw1jFPZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49095F03848;
        Sat,  2 Apr 2022 03:07:47 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220402005721.GO27690@magnolia>
References: <20220402005721.GO27690@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220402005721.GO27690@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.18-merge-4
X-PR-Tracked-Commit-Id: 919edbadebe17a67193533f531c2920c03e40fa4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b32e3819a8230332d7848a6fb067aee52d08557e
Message-Id: <164886886729.20951.2807133982895477424.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Apr 2022 03:07:47 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, fstests <fstests@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 1 Apr 2022 17:57:21 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.18-merge-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b32e3819a8230332d7848a6fb067aee52d08557e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
