Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F706EDA54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 04:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjDYCt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 22:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjDYCtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 22:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02E665A4;
        Mon, 24 Apr 2023 19:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C72C462B23;
        Tue, 25 Apr 2023 02:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37935C4339C;
        Tue, 25 Apr 2023 02:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682390974;
        bh=4MpDiWdWYuj2CKuCaRk2ucpbnPEcTBbER7OAQYf3CJk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Yziw9IGAMHamNSCF5+LdkoV6r92bgNuUcYKjq77RNs1sZdOqEONa6mTZqOGfyh/QC
         AcsZwhr2Nk1n1GQ/3vkUKDyAA7idib4/H4J+V1JFhVUkLfUE7YgI1dfIp0FHDlezB1
         hoVkvjmsn4OZEdKiiLuBC9ZzSFgdqeGFPNt3NWtGCS6/P3muRP4wVALVtn1Aenst1P
         uSV07E03e90IV8D081XF5X8DhXZWIBfCoZCfpJ/sxacfw9eBwy+ZBbpRdAbHCKm5he
         GMdGg/kgtfzPCJci1EM3KipWjB2HCFQLU4lJE728e5RPMkO2oQrJVnjwWjGdjZQfXD
         asNz2z9C3FohA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23782E5FFC7;
        Tue, 25 Apr 2023 02:49:34 +0000 (UTC)
Subject: Re: [git pull] old dio cleanup
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424042757.GK3390869@ZenIV>
References: <20230424042757.GK3390869@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424042757.GK3390869@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-old-dio
X-PR-Tracked-Commit-Id: 0aaf08de8426f823bd0e36797445222e6392e374
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11b32219cba462b1e12cfd91069ba82574bc2dcc
Message-Id: <168239097414.20647.223362721430612051.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 02:49:34 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 05:27:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-old-dio

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11b32219cba462b1e12cfd91069ba82574bc2dcc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
