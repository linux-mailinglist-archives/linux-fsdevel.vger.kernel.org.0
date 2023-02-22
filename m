Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABA369FE7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 23:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjBVW1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 17:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjBVW1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:27:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EED64740A;
        Wed, 22 Feb 2023 14:27:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9B09615BA;
        Wed, 22 Feb 2023 22:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35E3CC433A0;
        Wed, 22 Feb 2023 22:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677104822;
        bh=Hb5tZY3VuuweYZBKg+n5qNUTAVfEXqR8F2ZQY4uKbYQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=im74Fib/vLcYbM+sH2OhwNuYn7I/TMS5g1fcOpqcnGvXQ8MfNog/t70cnc1qnHJMm
         QE1jQ7r9GjF5ovZEfchofFrGR+ZvrWaveJB34S1OcCcfJvUbe5XDaf6ANEmOa4NAnx
         OaXTKW6PMg0QSkW1QU7FoRlsQ9v1/g1zLV3kcxIX6BaAWyneUqz8RF1uLSE0XKpP3z
         +WPEdQBEYxzMO77DMmXME8bhb2uhpysrF3678H72Hd3Mbos+on48pJ0L3eDADMlNpO
         ydEvkZTBZLd6thOJV3r7b97Q/gRGJfQzZjK5fR5P0NtOayloAhywoh0UFmtiL3jaDY
         Uy79UttSjOSKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24595C43151;
        Wed, 22 Feb 2023 22:27:02 +0000 (UTC)
Subject: Re: [GIT PULL] iomap: new code for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167703901677.1909640.1798642413122202835.stg-ugh@magnolia>
References: <167703901677.1909640.1798642413122202835.stg-ugh@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <167703901677.1909640.1798642413122202835.stg-ugh@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.3-merge-1
X-PR-Tracked-Commit-Id: 471859f57d42537626a56312cfb50cd6acee09ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63510d9f2f6e6337960499a3d72d5a457b19c287
Message-Id: <167710482214.21044.3464452166546298008.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 22:27:02 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        torvalds@linux-foundation.org, agruenba@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 21 Feb 2023 20:13:54 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.3-merge-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63510d9f2f6e6337960499a3d72d5a457b19c287

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
