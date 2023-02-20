Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091A969D6D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 00:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjBTXAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 18:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjBTXAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 18:00:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC2116AF0;
        Mon, 20 Feb 2023 15:00:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23FED60F46;
        Mon, 20 Feb 2023 23:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E862EC433A0;
        Mon, 20 Feb 2023 23:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676934012;
        bh=ApC9GkLHt2d3esaK1JjAo40h95mTl+DwLwqIJ47uMuE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SSFWdkaCKqIy6ObeBQkozJnyV0IdvCBWjUNYAA+PA9ngRZOeQczAuimS8di05NdmG
         C9JO0DpQlfTcvhXSXj3J4lVoCz5GTfrzaMOSfEiievaGX1DKmJeC6eKHtWdFJwaiO+
         wnPyfKokRcA6nwS+0ycwCV5dt1DO34IfPpKhSvhukrQH4ZonXS21f6h3CtTletJ+wi
         hTWwNogyksj62jVoLDRAzNHPoAMTLd/TBh8sGMOCfXq3Zho//qoi4nlult/xRm7ndV
         1nxm8MqHVQj6JJ+DbGebbaFkZ+PUBo423HTNPoLxsJS4KuAT9qBlF9N9emyIOBBKTV
         rTeQiLdrypWDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D17C6C59A4C;
        Mon, 20 Feb 2023 23:00:12 +0000 (UTC)
Subject: Re: [GIT PULL for-6.3] Make building the legacy dio code conditional
From:   pr-tracker-bot@kernel.org
In-Reply-To: <754b3cc0-c420-3257-9569-833c42f93808@kernel.dk>
References: <754b3cc0-c420-3257-9569-833c42f93808@kernel.dk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <754b3cc0-c420-3257-9569-833c42f93808@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.3/dio-2023-02-16
X-PR-Tracked-Commit-Id: 9636e650e16f6b01f0044f7662074958c23e4707
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 553637f73c314c742243b8dc5ef072e9dadbe581
Message-Id: <167693401283.6080.4911455757745526963.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Feb 2023 23:00:12 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 16 Feb 2023 19:54:10 -0700:

> git://git.kernel.dk/linux.git tags/for-6.3/dio-2023-02-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/553637f73c314c742243b8dc5ef072e9dadbe581

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
