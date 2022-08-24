Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D7859F174
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 04:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbiHXCqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 22:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiHXCp7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 22:45:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F7E32049;
        Tue, 23 Aug 2022 19:45:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F55A617DE;
        Wed, 24 Aug 2022 02:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D70A0C433D6;
        Wed, 24 Aug 2022 02:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661309156;
        bh=cEcIM708fFRL+18AzgeZ9K0lhHmbf+e8aaFHoWsdwzM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZCFN3MCNYrlKNAaJMXLEPteTWAQ39e7nbqbPDlQcDsxSm24v+pIeyrBslERN2UwFN
         GufZ1nxlNT5giI3ofcp2hTWJR+ZItv0LhJlwUagEDidn7/Z947hpU6dAM8s/WjEXQS
         BvFzgCxylBqlUXspmH0o9LHjSTcIlZHPPZSjmFEP5UfcfXWrEHUvKzEc/H/c8pWxIX
         EgVtxEHAVloAb4WRgdlNAw/ATQxE52R5GI2hrcEeLoMj0mcPRy7Mhs4Lv2FjcIlucV
         cOhESPFwVdksIbztCgSNzlyIOO6N7kU+4LjR0EVdAx/n+pkGPfk7KasearHq+grZEn
         RODky5RpI/tIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE0EAC0C3EC;
        Wed, 24 Aug 2022 02:45:56 +0000 (UTC)
Subject: Re: [GIT PULL] file_remove_privs() fix for v6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220823111056.858797-1-brauner@kernel.org>
References: <20220823111056.858797-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220823111056.858797-1-brauner@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.fixes.v6.0-rc3
X-PR-Tracked-Commit-Id: 41191cf6bf565f4139046d7be68ec30c290af92d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 062d26ad0b36829c0142e5b96a694f3cdb6eaa43
Message-Id: <166130915676.7543.5083804304418300659.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Aug 2022 02:45:56 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 23 Aug 2022 13:10:56 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.fixes.v6.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/062d26ad0b36829c0142e5b96a694f3cdb6eaa43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
