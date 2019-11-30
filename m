Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3C210DEE8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 20:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfK3TkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 14:40:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfK3TkG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:40:06 -0500
Subject: Re: [GIT PULL] afs: Minor cleanups and a minor bugfix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575142805;
        bh=FAKuL0S0DRl5SVomXVMeTyFTKMQjz3YQ3essi+Iaegc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JDQWc6yVZcd1xz079TJT3fbqfzfvSZxwD76+NqVYxBHZ/hVyEsOqjdNkHr6TNv6TG
         eARFZBJCy3N9z/XqV4rWhpOceQ21dhvRoM3vzqkvWhySMj2QNJd6qaUCDN1KJ/F3ZB
         r+iC33+3nUZEyElr9VHCM5ejFP2Ci/UmWvHE9aDs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <27497.1574808228@warthog.procyon.org.uk>
References: <27497.1574808228@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <27497.1574808228@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-next-20191121
X-PR-Tracked-Commit-Id: 4fe171bb81b13b40bf568330ec3716dfb304ced1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a55d362ffe7caf099a01f6d2ed49a6ea03a4a88
Message-Id: <157514280589.12928.10700973031954050508.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 19:40:05 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 22:43:48 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-next-20191121

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a55d362ffe7caf099a01f6d2ed49a6ea03a4a88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
