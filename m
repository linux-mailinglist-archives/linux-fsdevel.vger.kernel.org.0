Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CC36F25C5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 20:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjD2STz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Apr 2023 14:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjD2STx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Apr 2023 14:19:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EFF9F;
        Sat, 29 Apr 2023 11:19:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B578560B6B;
        Sat, 29 Apr 2023 18:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25A04C433EF;
        Sat, 29 Apr 2023 18:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682792392;
        bh=jAG+yJQX34tM7CeBpl6lPXmvLMoxVAl638WT3+BxpIA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bV8dGl7ToY0FzRS6AzRNxD9W4RcW36qYDoU3inSC2w6b6zUk+AMfRDAx57FxdChmU
         5XmpUuSYlCJGIp8SNZBWfDbTlPp7RCLrUa/0OIzpbQZeVzRgZQ2xnZYay+5hJrNTxz
         uAoMwDIUp3cPXHzUPbapeR+pfj82Jx2glbz3Rtktg6xSPdMagpr1s/2zMPnZL6eANC
         N2gcyOG6rT+Om1S8UOR6+XBx1j2gthlSpngOoo5iUy4aPNbqm7+TslCab1Bn3wgmDj
         e+YJafi1PQ8gu9JSProWundByPscDdeqMQfSRIUcgmhWfdEn5vUAxxkBo5jokypF6J
         CIhaVmmI0xndQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11222C43158;
        Sat, 29 Apr 2023 18:19:52 +0000 (UTC)
Subject: Re: [GIT PULL] iomap: new code for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230427175543.GA59213@frogsfrogsfrogs>
References: <20230427175543.GA59213@frogsfrogsfrogs>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230427175543.GA59213@frogsfrogsfrogs>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.4-merge-1
X-PR-Tracked-Commit-Id: 3fd41721cd5c30af37c860e6201c98db0a568fd2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bedf1495271bc2ea57903762b722f339ea680d0d
Message-Id: <168279239206.22076.5283792032677231044.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Apr 2023 18:19:52 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     hch@lst.de, torvalds@linux-foundation.org, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, disgoel@linux.ibm.com, jack@suse.cz
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 10:55:43 -0700:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.4-merge-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bedf1495271bc2ea57903762b722f339ea680d0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
