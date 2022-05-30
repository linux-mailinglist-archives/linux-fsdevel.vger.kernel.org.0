Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D7853873F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 20:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242666AbiE3S22 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 14:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242766AbiE3S20 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 14:28:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9585A5B5;
        Mon, 30 May 2022 11:28:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2411B80E9C;
        Mon, 30 May 2022 18:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AEF9C3411E;
        Mon, 30 May 2022 18:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653935303;
        bh=eaXYp9++UGCP5E2UOyyCsk+iO/QRthdO3rdedzzoOXA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z3s7+VG+5eeUeVyggt3hyseq6p3UcONefDrN/kUI2wX37fcdO17XIIZuI0jf2H2ef
         OP3pdNFwb38nJmjuQYdhp+LhRjveQt9Ue2LKRSRRQbxPh6fB0mTemx/WYosLnaasnd
         oopigYAkxdXZLTnHEQva2FmwEQypGF38SVA7wv7g/n2mWOhxez+mPvYRUnQhpaVSFX
         oj15afyUGM1YDRAUZ7A8k5La/KyAhbe47LPWL78tP/dNh03e0ZcJIzkulsZKnS57tB
         kBF1KpYT1d9FsURrsClDcUJKJBIl1BA/KAXe37dUO0MNbjpJxomDdDi65skdRiZLEJ
         cCc045mXfIvxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75A1DF0394C;
        Mon, 30 May 2022 18:28:23 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs update for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YpR9rJkjso7lXdFC@miu.piliscsaba.redhat.com>
References: <YpR9rJkjso7lXdFC@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpR9rJkjso7lXdFC@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.19
X-PR-Tracked-Commit-Id: bc70682a497c4f3c968c552e465d1d9948b1ff4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c5ca23f7414eb2c782f945aa417cfab7b5c88dd
Message-Id: <165393530347.32021.7385395832659499208.pr-tracker-bot@kernel.org>
Date:   Mon, 30 May 2022 18:28:23 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 30 May 2022 10:17:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c5ca23f7414eb2c782f945aa417cfab7b5c88dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
