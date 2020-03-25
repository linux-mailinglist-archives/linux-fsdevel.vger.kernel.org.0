Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4260192FD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 18:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgCYRuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 13:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbgCYRuD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:50:03 -0400
Subject: Re: [GIT PULL] zonefs fixes for 5.6-final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585158602;
        bh=C0zHAKzkh0VKtMXZqSlevYip3VFOdrGtU+5bn8H0TbY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=diWZvHOeBhAn+fbbCWxWZxO4jnf6yIWzu+DN6/R5DaCYd4fFIikXfLXSq3NbQP9ok
         tP2kf0IzpOSvQkIMO+sbev87LFi0PrZ10qIm93XJ/tbVYmSHLA0sG5PUygflj++t7S
         vClZyaRzVPcT09qzgVzSSWnOZM8YSx5zplF5p4pI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200325031146.289311-1-damien.lemoal@wdc.com>
References: <20200325031146.289311-1-damien.lemoal@wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200325031146.289311-1-damien.lemoal@wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/
 tags/zonefs-5.6-rc7
X-PR-Tracked-Commit-Id: ccf4ad7da0d9c30a962a116cb55bcd7d8c44b0fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2cf67f6689a218b4d8e606e90a12491a9cfa366
Message-Id: <158515860263.2648.7681923612410676472.pr-tracker-bot@kernel.org>
Date:   Wed, 25 Mar 2020 17:50:02 +0000
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 25 Mar 2020 12:11:46 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2cf67f6689a218b4d8e606e90a12491a9cfa366

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
