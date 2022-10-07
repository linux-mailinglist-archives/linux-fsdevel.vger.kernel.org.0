Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBC85F724C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 02:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiJGAgs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 20:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiJGAgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:36:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AA5B97A8;
        Thu,  6 Oct 2022 17:36:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71013B821FB;
        Fri,  7 Oct 2022 00:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26106C433C1;
        Fri,  7 Oct 2022 00:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665102993;
        bh=mD27Eo2rFC7cImdDe2SAO5OKhlX1noOWc0rc8+foleU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ie0GifgLvZuTAUuWNskiXnlKJ3Qel6FP8w43Bn8Zk2JRAQWJ7feBftqACY9ym0Rdj
         TdvmKd0eULpNxsu7xareOuQwznT0lkBd2H363zyWxVW80I2qch6977mlPM0nxSBanh
         ErWIq8h5172vAMqNKd2CxGbEOqcXAQynevOak49lZ+9KDhL2LWu8C2p/LIjseGD2Gt
         qgfJ+VRPRXnf1fzom+N8uERpA/6covYYv29icUuXBLCXF2NdZjthxrE8v4m5RpvmJ0
         3zAb17V5Nl/wIameSQ0YOgCWJbENYGJkpNwma8kFs7xw/JiPzbqTewUAEMCbEIEJn0
         R6rs/YaFl9zrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 129BEE2A05E;
        Fri,  7 Oct 2022 00:36:33 +0000 (UTC)
Subject: Re: [git pull] vfs.git pile 1 (inode)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yzxkpi7JBteYzQMt@ZenIV>
References: <Yzxkpi7JBteYzQMt@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yzxkpi7JBteYzQMt@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-inode
X-PR-Tracked-Commit-Id: 2e488f13755ffbb60f307e991b27024716a33b29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46811b5cb369fe638665b805f3c84683f78e5379
Message-Id: <166510299306.12004.536090776426190939.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 00:36:33 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 4 Oct 2022 17:51:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-inode

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46811b5cb369fe638665b805f3c84683f78e5379

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
