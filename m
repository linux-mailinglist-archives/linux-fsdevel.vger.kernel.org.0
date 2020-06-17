Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD781FC2ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 02:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgFQApD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 20:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgFQApD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 20:45:03 -0400
Subject: Re: [GIT PULL] afs: Fixes for bugs found by xfstests
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592354702;
        bh=5e0a5iVK0TowUVssPommYkc0TiKB/g2Al8oPNa9mwdY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xmD6N+dN46UNILbjwMP2cHybDYG10PBuE8BXl69PdQU9/4tRZf/8DHgLvBqIhLynh
         6udFqP56Zm80iivQhz7UWd+QI+bJ8MQKJUcHibFZztlT7pEgn4fvHudl135suydsMn
         F5mD95K9IByHUZEQO4JDQP2yOV9AYp4uMooZ/154=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <930958.1592344306@warthog.procyon.org.uk>
References: <930958.1592344306@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <930958.1592344306@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-fixes-20200616
X-PR-Tracked-Commit-Id: b6489a49f7b71964e37978d6f89bbdbdb263f6f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26c20ffcb5c86eb6a052e0d528396de5600c9710
Message-Id: <159235470279.15875.12694874433794392475.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jun 2020 00:45:02 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        marc.dionne@auristor.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 16 Jun 2020 22:51:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20200616

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26c20ffcb5c86eb6a052e0d528396de5600c9710

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
