Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7D816BC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 21:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfEGTzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 15:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbfEGTzG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 15:55:06 -0400
Subject: Re: [GIT PULL] iomap: cleanups and enhancements for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557258905;
        bh=su8VHeTt78N5/PaCxKF+VeEb+ARV3MYc1liAQHVsM4I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wngAzOH4iIbKhOuvIlM/MGTfJPXvf+fUXHkE3T3befEG7PvDyGPRq6ZBJQubvITfd
         tyNCSfRTFETdK+YAj0Z3niQGmXVf/M5aEpjrv+LB3cQ+3v3fMlsr95RbyHqIutjkJ1
         oU2YGddjGVcBIfArKnwv5RTUgJIYkwBxz2LkzetM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507152430.GB1473023@magnolia>
References: <20190507152430.GB1473023@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507152430.GB1473023@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/iomap-5.2-merge-2
X-PR-Tracked-Commit-Id: cbbf4c0be8a725f08153949f45a85b2adafbbbd3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8456eaf319a27d33186f1091bc1ff5c59cf0f0d
Message-Id: <155725890540.4809.8195890757045131551.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 19:55:05 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, agruenba@redhat.com,
        rpeterso@redhat.com, cluster-devel@redhat.com
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 08:24:30 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.2-merge-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8456eaf319a27d33186f1091bc1ff5c59cf0f0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
