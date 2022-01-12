Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC3348CF68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 00:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiALXul (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 18:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbiALXuT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:50:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BB1C06175A
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jan 2022 15:49:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20875B8218C
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jan 2022 23:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAF14C36AE9;
        Wed, 12 Jan 2022 23:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642031372;
        bh=dNiWw8QZMzclstq8xoQulo5sIYuMsSmk2rqvaAVuo8I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Qrp/B8pu4FSQJqjOo9IZZU9RqWRwy0+Tn/CZWYJYrn3PGZf7WS/YQ8YhmqsH/UTqy
         Na+0Awl9G5lHQxofEsCt5Puuu1EVcgYJz+qU/La4GNls2UJZUE2PPrHMRn5WKq/UeY
         ulB8ToBRjOzI531H87EqzusYVm9aRZ0Kn4T2WdE9KoCQcw8tfK39IdtMEd4ZVOUHnF
         7OD3vhR0O7wFqajJJwz+IT7oFlYS+T1NJbHPcp7xj6a0p+29KBpSiixwBbCSeD5kkU
         wvrIkU0qF1/6YQyM1E53cZNy5QfLrvBQmNU8CzWBn2ciB7tLTQdcKi5aVeeRJZhS+y
         cS2+fv2oPAecg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9B7CF60795;
        Wed, 12 Jan 2022 23:49:31 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify changes for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220112083825.td2ds6qej74tm77c@quack3.lan>
References: <20220112083825.td2ds6qej74tm77c@quack3.lan>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220112083825.td2ds6qej74tm77c@quack3.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.17-rc1
X-PR-Tracked-Commit-Id: 8cc3b1ccd930fe6971e1527f0c4f1bdc8cb56026
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d3d6733065c9670f8df6630990d4885933b1e55
Message-Id: <164203137188.22460.15884301884533111591.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 23:49:31 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 09:38:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d3d6733065c9670f8df6630990d4885933b1e55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
