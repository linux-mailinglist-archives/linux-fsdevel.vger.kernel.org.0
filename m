Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00761F8481
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 20:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgFMSAE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 14:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbgFMSAE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 14:00:04 -0400
Subject: Re: [GIT PULL] General notification queue and key notifications
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592071203;
        bh=DiSJ1hWE/g9k99EDt5ikGF7JvqayWFuR3ud4Vg6KavE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VeF6fHUTN1FLEDzMN8KmgBbDTO2nyyhX/Wanz2oSf19w1NxNeXZ5rXgP5Orc9n7qE
         b0hirp7RTLr16wB2l2CmXnbokqW3w29B67ZbPYsbsDNG/fu/tKEYeNDDVAOQtXTVmV
         vprVlV25gxZoO7OLqNqMTct5Dztd2KKCO98tJsw0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1503686.1591113304@warthog.procyon.org.uk>
References: <1503686.1591113304@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1503686.1591113304@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/notifications-20200601
X-PR-Tracked-Commit-Id: a8478a602913dc89a7cd2060e613edecd07e1dbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c3297841472b4e53e22e53826eea9e483d993e5
Message-Id: <159207120392.28894.7192041280504683519.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jun 2020 18:00:03 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, dray@redhat.com, kzak@redhat.com,
        mszeredi@redhat.com, swhiteho@redhat.com, jlayton@redhat.com,
        raven@themaw.net, andres@anarazel.de, christian.brauner@ubuntu.com,
        jarkko.sakkinen@linux.intel.com, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 02 Jun 2020 16:55:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/notifications-20200601

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c3297841472b4e53e22e53826eea9e483d993e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
