Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7C61E4CDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 20:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbgE0SKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 14:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388404AbgE0SKC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 14:10:02 -0400
Subject: Re: [GIT PULL] Fanotify revert for 5.7-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590603001;
        bh=xzloDWPeXavqdqN0ro3wIZGvQK6FHsHpjAREX+ukFeI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Eor54n8oVaf7jljv/xRdEOsdkM/eCj7a8mmEPLh6ndIaoTQ7T2PNFXwZE38Pm0G06
         pLMuNZ6wh7N2z3NluqE+kQatX8AuWbJ5OijWI50rpQHHeNd0qFbblFdoCtLgiZPw2x
         mmX5FQZR9996FTf4Skr4nEA6O0Y99dwoCgmCg9dc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200527172143.GB14550@quack2.suse.cz>
References: <20200527172143.GB14550@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200527172143.GB14550@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
 fsnotify_for_v5.7-rc8
X-PR-Tracked-Commit-Id: f17936993af054b16725d0c54baa58115f9e052a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0c3ba31be3e45a130e13b278cf3b90f69bda6f6
Message-Id: <159060300167.13466.17618649274467096726.pr-tracker-bot@kernel.org>
Date:   Wed, 27 May 2020 18:10:01 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 27 May 2020 19:21:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.7-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0c3ba31be3e45a130e13b278cf3b90f69bda6f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
