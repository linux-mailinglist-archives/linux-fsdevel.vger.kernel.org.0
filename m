Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0461311C395
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 03:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfLLCuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 21:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbfLLCuD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:50:03 -0500
Subject: Re: [GIT PULL] afs: Miscellaneous fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576119002;
        bh=UPCC/x01BlBLT7CIZuEuox8GyPHZ1Q2XEbX0lTlzesc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cvQzquuc8itBxKh0Vav91ng5TybS0BXsT73JgmzEPqkXsJwLuNrqEtH+EJPXvWIjT
         +2TUnjwolugI0FVynllGh0i4rU7KqZJdGrqFWJCLnxJ6ABwHlPDZthg38SBFOLYpvJ
         YxuCaKUJziYxyZIAZ+dgliZ0I9tx1m6ANf8ye0sw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <11743.1576099077@warthog.procyon.org.uk>
References: <11743.1576099077@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <11743.1576099077@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-fixes-20191211
X-PR-Tracked-Commit-Id: 50559800b76a7a2a46da303100da639536261808
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae4b064e2a616b545acf02b8f50cc513b32c7522
Message-Id: <157611900281.8855.6872248503781144513.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Dec 2019 02:50:02 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        marc.dionne@auristor.com, jsbillings@jsbillings.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 11 Dec 2019 21:17:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20191211

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae4b064e2a616b545acf02b8f50cc513b32c7522

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
