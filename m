Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF7E31A2E96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 06:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDIEzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 00:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgDIEzE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 00:55:04 -0400
Subject: Re: [GIT PULL v2] 9p update for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586408104;
        bh=hdpZkEo40TxKGxrgo2q/EeO6h/GBJrP5hu6h21WMR0A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LM6XI5h5yH8+ErTQDsmCJXtKTUDOo49mr+jsvpqojWB1pgxtjusMZvFRbNwu6OZuJ
         xlNrZdBHmRHs+vhQiajF75tTyc/7rnc0P0u4BDtPrSLmcgSuUhBMTtpVXdVOeDPDyv
         BDI5wQnGCOHyqvR6Gojrntw4Y8fEDc0jeypKHiqo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200408151214.GA30977@nautica>
References: <20200408151214.GA30977@nautica>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200408151214.GA30977@nautica>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-5.7-2
X-PR-Tracked-Commit-Id: c6f141412d24c8d8a9d98ef45303c0235829044b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d30bcacd91af6874481129797af364a53cd9b46
Message-Id: <158640810475.3202.11767820306106270043.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Apr 2020 04:55:04 +0000
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 8 Apr 2020 17:12:14 +0200:

> https://github.com/martinetd/linux tags/9p-for-5.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d30bcacd91af6874481129797af364a53cd9b46

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
