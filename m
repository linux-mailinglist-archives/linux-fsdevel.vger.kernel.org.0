Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41706369D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 20:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbiKWTYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 14:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbiKWTYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:24:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917D59C7BB;
        Wed, 23 Nov 2022 11:24:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4380BB82465;
        Wed, 23 Nov 2022 19:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 057D3C433D6;
        Wed, 23 Nov 2022 19:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669231457;
        bh=JnvMqFARKDRgQcpv7qV4sfKwOEskmpy+MLQc3kVk6m0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JsDWn+vxh8zg8qimdWQW2WLNLobmtPm6ltVRwb6RMLbExIp2P5V3f4u2Sz1aPoZfh
         3bBXORyWTaHWjHqAC+5hRtlDHbKYE0L2Z49r0DAcx/FDU+nc2v10KHPeZzyG/sEAbo
         rcZDgeyOdS6G7mRhk59V4BGx/FXBVGJLjmooYRBjWuEXQCaIANy6gdhHk2Hwz24tjz
         0mkCkyl5hPESpFP51fqe0cdIFS/tUi2dVYH89VYzZ5kJnbFyeOlIDiugY6Yjk/sJ4D
         MqIu8dJ+CdYwNe+PDRVubPdOY7FaZBpJpatD1JsdmI7yVGHrXSHLf+3eCHzDD/ntqO
         4D12L56XEvgUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E53DDC395ED;
        Wed, 23 Nov 2022 19:24:16 +0000 (UTC)
Subject: Re: [GIT PULL] 9p fixes for 6.1-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y32sfX54JJbldBIt@codewreck.org>
References: <Y32sfX54JJbldBIt@codewreck.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y32sfX54JJbldBIt@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-6.1-rc7
X-PR-Tracked-Commit-Id: 391c18cf776eb4569ecda1f7794f360fe0a45a26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd64898dfed510a55b66080f8ab5c9b06982bbce
Message-Id: <166923145692.2332.11368016095153725752.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Nov 2022 19:24:16 +0000
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 23 Nov 2022 14:15:41 +0900:

> https://github.com/martinetd/linux tags/9p-for-6.1-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd64898dfed510a55b66080f8ab5c9b06982bbce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
