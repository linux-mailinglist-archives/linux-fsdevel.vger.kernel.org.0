Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A844BD325
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 21:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbfIXTzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 15:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfIXTzF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:55:05 -0400
Subject: Re: [git pull] several more mount API conversions
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569354904;
        bh=QW2Rmj9CCWUJLI9ndOOvHlno49Nv5t95cAIM8jOYnFk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fk/XBamy36BnAE9/JMQZwKAttXQ4ZjFYkP1QPYgOFoT1xVFXnoH58n6RhJqwpcVOf
         n0hzJW2y9lEHN3aIK+ciKs+oHpRceGjYLipEBGZRf2OuqkSbqz7rAHAMdRZVEM+jKo
         lDJUWx9zld54OlCVMJUAiOqU7Fc/3muPVgY6rdTc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190923192147.GC26530@ZenIV.linux.org.uk>
References: <20190923192147.GC26530@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190923192147.GC26530@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount3
X-PR-Tracked-Commit-Id: 1f52aa08d12f8d359e71b4bfd73ca9d5d668e4da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b36c9eed232760fbf51921818f48b3699f1f1ca
Message-Id: <156935490485.15821.5107111785127549319.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Sep 2019 19:55:04 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 23 Sep 2019 20:21:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b36c9eed232760fbf51921818f48b3699f1f1ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
