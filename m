Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D40FE410
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 18:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfKORfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 12:35:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfKORfD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:35:03 -0500
Subject: Re: [git pull] vfs.git fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573839302;
        bh=28yCGJm7K2QrKsaqav66AwsC9JzHEcSbO4Fva6Qspnc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2gEuLvZMrZP3rtYGfLNeonPgSMGhFV3bHG/WyJY8ZDn+XJeszWCwUZ6B1UiT6UIqp
         nWhNmvHabq6c1oJQaQQxuZ/wPunL97RzlOUtwyPlWFYtFyFek3+6ZkNe56xX8v9JTm
         bJg9Y07RoZ3n4kZsFjpDMYEBtkghFwmsz9vPAdUU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191115005012.GM26530@ZenIV.linux.org.uk>
References: <20191115005012.GM26530@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191115005012.GM26530@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 762c69685ff7ad5ad7fee0656671e20a0c9c864d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4c0800e4285f96900b7aa4a13ae724fc1205f65
Message-Id: <157383930241.31249.10472600575449293477.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Nov 2019 17:35:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 15 Nov 2019 00:50:12 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4c0800e4285f96900b7aa4a13ae724fc1205f65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
