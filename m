Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C2C73EB98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 22:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjFZUGQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 16:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjFZUF7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:05:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F287172A;
        Mon, 26 Jun 2023 13:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A917160F7E;
        Mon, 26 Jun 2023 20:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19CE5C433C9;
        Mon, 26 Jun 2023 20:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687809762;
        bh=uQWoicPq4Osumk5UgA1P/3IbYUGcJ9ivuvSp30lFhTQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kmcSFCx4jXxBwUVCYdfD3RrUW86ak1kHkfrAD2e0SxSU/J+TS4Q8fyfH789KHhfH/
         g76rQZCecMaPluHMyg93sJlAg3bO2he7cb7P3S3PGXs3HQfnNr4nhTWEZ9GDcjUdrk
         ZRgbvniN9apV6JC8lN6VjeZZemmutrkEdvBH+qp8zaz2lpSKrjd4an4xayK9kQgUuO
         JikoXsqyindTByEGyt4v7+86ttlW+OgEiwJ0GbpmwYgo4WHNuYZnjIspXKpxA+ltfQ
         cuntLkU0mbHvucK1UdVc0hqu4/vrcttl/pVLG+RZ6RtSUYhd8aqt3zRvu3mfPugxWJ
         i3HeMwW8sJiMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0935CC43170;
        Mon, 26 Jun 2023 20:02:42 +0000 (UTC)
Subject: Re: [GIT PULL] Splice updates for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <81469b33-44cf-8b42-a024-25aa22f9c2a0@kernel.dk>
References: <81469b33-44cf-8b42-a024-25aa22f9c2a0@kernel.dk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <81469b33-44cf-8b42-a024-25aa22f9c2a0@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.5/splice-2023-06-23
X-PR-Tracked-Commit-Id: 9eee8bd81421c5e961cbb1a3c3fa1a06fad545e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbeb087e5a6f849e776874cfce1e3c2414b13bb1
Message-Id: <168780976203.7651.7203110734956746953.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 20:02:42 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 25 Jun 2023 20:38:53 -0600:

> git://git.kernel.dk/linux.git tags/for-6.5/splice-2023-06-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbeb087e5a6f849e776874cfce1e3c2414b13bb1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
