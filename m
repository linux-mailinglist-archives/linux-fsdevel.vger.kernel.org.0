Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A439735D7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 20:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjFSSco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 14:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjFSScn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:32:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41911137;
        Mon, 19 Jun 2023 11:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D308060DF6;
        Mon, 19 Jun 2023 18:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43E93C433C8;
        Mon, 19 Jun 2023 18:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687199562;
        bh=jG6PMwcy+ZkyVG2E4Q23eLIUvDiXuDGC4Mqv54NHSI8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tO5ORgMn9LJcYohAFYgfxcUuybJsXBxRSfcA04FF4aF13C4CMHGgsOvRxTe3fB2AT
         b5nky3H2b+d/TXLe851vrKxfK64k9wD89WVIWc7270eaMV1OgwRsuLehitEm4wgmxg
         eO+hTBgI46JTkuvlQTYMLq3jQ/aUg/lT0odVCKk9U+pGhhWX+Pz+p7o1OyAqiyWu1y
         XbG3J8xBfvxEMXLwVBgm7cPIaZ0Zx7NGfj5O/n3KLUnyo76Dhfp/JSAY6WF1wxZOxW
         LgRArY6nMGnYZl9SaRIE9fIkcuekhV5B2eLAYzSB1SCuuY1Ap26j6JuUw1g5N1lk+2
         pNZPWkAPbd37Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3048DC4316A;
        Mon, 19 Jun 2023 18:32:42 +0000 (UTC)
Subject: Re: [GIT PULL] afs: Fix writeback
From:   pr-tracker-bot@kernel.org
In-Reply-To: <923156.1687182529@warthog.procyon.org.uk>
References: <923156.1687182529@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <923156.1687182529@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20230719
X-PR-Tracked-Commit-Id: 819da022dd007398d0c42ebcd8dbb1b681acea53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbad9ce9397ef7f891b4ff44bad694add673c1a1
Message-Id: <168719956218.28660.13247863239033808293.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Jun 2023 18:32:42 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 19 Jun 2023 14:48:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20230719

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbad9ce9397ef7f891b4ff44bad694add673c1a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
