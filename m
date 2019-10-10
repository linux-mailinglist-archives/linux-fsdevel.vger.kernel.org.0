Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB0EBD2E02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 17:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfJJPpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 11:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfJJPpD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:45:03 -0400
Subject: Re: [git pull] a couple of mount fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570722303;
        bh=K1CS1UOSiYYuwX+mdwNwjcVOGX461mN029iuNAdeHBc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IcbyxbRB3gZ8AH90W+ICj88wzewCbKxVoJb6cAqWQSI7V6QLroybKqfBXnqBNZjDW
         hFEW5eZu+sVAZcRtnfrCFjGisUl7DzdYpMo+FetCL6kigAEc/vFR/07L7i1GPcljDE
         hqqRiZHzAh7WP1WrA5+cJsBbonUmN9ORD836NV6s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191010025617.GE26530@ZenIV.linux.org.uk>
References: <20191010025617.GE26530@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191010025617.GE26530@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount3
X-PR-Tracked-Commit-Id: 6fcf0c72e4b9360768cf5ef543c4f14c34800ee8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 015c21ba59fcbc522d7a9d1e0ab0f0e6c0895ff0
Message-Id: <157072230322.27255.4192822748794935492.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Oct 2019 15:45:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 10 Oct 2019 03:56:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/015c21ba59fcbc522d7a9d1e0ab0f0e6c0895ff0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
