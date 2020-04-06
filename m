Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 002EE19FAB3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 18:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgDFQpG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 12:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729585AbgDFQpG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:45:06 -0400
Subject: Re: [git pull] regression fix in namei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586191505;
        bh=F5rbtAgLz7aWxFyy6wZ06WPf1ke7rlPIHyMIwworjRs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j5u20lfU7EBHn2uFcW9/BfmD8Qil1c/O1RDIjT4ZibzyK+LG0l9Z8a9QlYFiskCYU
         MfaugbTTi/RdxvuNmdRZ3tGUIjXeOhdYLD2MgktcAxz85KRr+tf3M/Nvd6z6TYbvxU
         1hdlulgmwCXRT3FEysmLoziT2Kd5FBzM/hzbxQnE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200406144032.GU23230@ZenIV.linux.org.uk>
References: <20200406144032.GU23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200406144032.GU23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 5bd73286d50fc242bbff1aaddb0e97c4527c9d78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77a73eecd47c2c290cf4ecba2c5b9d26d5d812be
Message-Id: <158619150570.17891.11267573536641110718.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Apr 2020 16:45:05 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 6 Apr 2020 15:40:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77a73eecd47c2c290cf4ecba2c5b9d26d5d812be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
