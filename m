Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC4367B8C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 18:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbjAYRmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 12:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbjAYRmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:42:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D7C37B45;
        Wed, 25 Jan 2023 09:42:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 078EACE20EE;
        Wed, 25 Jan 2023 17:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 431AEC433D2;
        Wed, 25 Jan 2023 17:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674668540;
        bh=Ejjm4FOUdaKKWkHq5trYwDwbcUx+La+RfeiglCyWxaA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Qvx2Xlocs1Gf3bqPoOs07fByeDf3SsHDCUUH5Znd8NMfO2NMqRCUGvKmCkY8ST7Iy
         qcK+5FnAzTRnNr9gEukwRRAIIdGcA4BQfVXU09PUPAZ+uLxUOeAefmvE/ZgvIfzIji
         vf+WJiJEVTphf95ifhGWhpRrIvOZNLICT6fhe5mM/sE0jVAy6NAwdW3coyJ0DxmcbR
         Wj1rPwFo+awZ0x4s3s7JeJvHwJVok70RaVSzIRisPS0qFpAGjwOwO0NaFi3hQjLoqy
         G0AHWXuAKdapJ/qcSk3uAv7X8yjZmpYaW5ecmXOx/VK71v6rvOo/0/+S6fUsrvZJQF
         4KSRw0lXJ85Wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27779C04E34;
        Wed, 25 Jan 2023 17:42:20 +0000 (UTC)
Subject: Re: [GIT PULL] fuse acl fix for v6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230125100040.374709-1-brauner@kernel.org>
References: <20230125100040.374709-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230125100040.374709-1-brauner@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.fuse.acl.v6.2-rc6
X-PR-Tracked-Commit-Id: facd61053cff100973921d4d45d47cf53c747ec6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c46948a6e9cf47ed03b0d489fde894ad46f1437
Message-Id: <167466854014.20999.16961050055018169582.pr-tracker-bot@kernel.org>
Date:   Wed, 25 Jan 2023 17:42:20 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 25 Jan 2023 11:00:40 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.fuse.acl.v6.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c46948a6e9cf47ed03b0d489fde894ad46f1437

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
