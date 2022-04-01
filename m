Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CAF4EFC53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 23:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353033AbiDAVrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 17:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353022AbiDAVrG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:47:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC1510F6D9;
        Fri,  1 Apr 2022 14:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8021261AA2;
        Fri,  1 Apr 2022 21:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1367C34110;
        Fri,  1 Apr 2022 21:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648849515;
        bh=4RisvOEUZ5XiyYiDIkLhV2HZS6idsGA3xNeuGVIOkRI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ATayYMs2JKRiugjkfgm5vtw7NPrP5Oqp6fBcZHTkaLQy+qwkUMBpB8HXhnQ6gh7s7
         ATHiCm+/IKM2or752zgXp5WypYVAP/DOnCZ7QcInuFhDJ8mtIEz0r3I73QPCJEorpi
         /n9dWX8xdPSB8Y+eV/GSZbWW/lNBrBnEx7GVf5QeOVNP51MqUK7dOFFIEpqwRzG9z6
         FYYIpBYdV6WLi8ngP2dKhKI6BB7LdTJhIQ/beP56GqmdQQeLDSwh84ESQgajdpimDl
         PPnen1ETeX8ys7lRo9rDlTwp708Kvq7tVpB1Tt+J7CmE5hCRYpS+VbJ/fgxr1zqBxj
         OLevKhIL08sng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF5D2F0384A;
        Fri,  1 Apr 2022 21:45:15 +0000 (UTC)
Subject: Re: [GIT PULL] Folio fixes for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkdKgzil38iyc7rX@casper.infradead.org>
References: <YkdKgzil38iyc7rX@casper.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YkdKgzil38iyc7rX@casper.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18d
X-PR-Tracked-Commit-Id: 5a60542c61f3cce6e5dff2a38c8fb08a852a517b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cda4351252e710507d32178dfbb5a7f0f92488f8
Message-Id: <164884951584.9554.14883239670856082568.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Apr 2022 21:45:15 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 1 Apr 2022 19:54:59 +0100:

> git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18d

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cda4351252e710507d32178dfbb5a7f0f92488f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
