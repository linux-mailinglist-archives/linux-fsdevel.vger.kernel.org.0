Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFE749FE5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 17:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350287AbiA1Qus (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 11:50:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45236 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350281AbiA1Qur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:50:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8A6D60E65
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jan 2022 16:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AF77C340E0;
        Fri, 28 Jan 2022 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643388646;
        bh=aUWOn5qgFCa4XQnoDZOyGaYzJIeVLNlUWzHL2as2ZKk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D1w3nz+hrMS4byQtAVyD6tLXWC2TPhqiAuW+RV+Ik6s3pXGN7lE9AtlVNce9MfcG3
         A1BG9WPIb0c9NhoYPq23/V4Vt6aVtA9CSRSGW7tbb7htLkPExPTesCIErvAkiG7MBP
         Xz3ry+2UoyBRbhfvFPodukgw49B+z3MI1qDNtAbn6sSfTsEMIgXSxuAVodo656JQbx
         GyT/qzp8Ln5SYu/ORD/B5+tAmxohfgJROlF+A6Pi8gmt3TL/oXoSEzplUYA8/XLqJP
         9Ol8LVkLMvGOHoSTnhKuXiCLm7d/HpKmVBmbTO3xmGb7D7sbFKHwHdWUTFrSxih7Ex
         DF32SjSakNayg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19A96F60799;
        Fri, 28 Jan 2022 16:50:46 +0000 (UTC)
Subject: Re: [GIT PULL] udf and quota fixes for 5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220128111811.ijyqfq6fckxutuoi@quack3.lan>
References: <20220128111811.ijyqfq6fckxutuoi@quack3.lan>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220128111811.ijyqfq6fckxutuoi@quack3.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.17-rc2
X-PR-Tracked-Commit-Id: 9daf0a4d32d60a57f2a2533bdf4c178be7fdff7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2b19fd753114f8e11d313389ee1252dc3bb70d7
Message-Id: <164338864609.23534.7841892501894596031.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jan 2022 16:50:46 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 28 Jan 2022 12:18:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2b19fd753114f8e11d313389ee1252dc3bb70d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
