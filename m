Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CF224236A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 02:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHLAfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 20:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgHLAfG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 20:35:06 -0400
Subject: Re: [GIT PULL] zonefs changes for X.Y-rcZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597192505;
        bh=y+s6CLZ1zNO7lPWsLhCHuCZOPc1/s0kIZu9YzylJ+w4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Zwa4a3Sk2Z0HhVeoyYHIh9NTciKdkavF/k3h43Ur1CuRBWd9ifUvdK1x1uUaWX5Zp
         Q1EZwDJuIHEDbD9QbNAM4iEatRgOPBICzvrWPT4GVHiw2QiLFlJyjL7NZ11mZWcZDS
         kM+sLYLBFFpVoiYdPH1ioHHwLjrO0fLxlSPirMgI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200811084531.677853-1-damien.lemoal@wdc.com>
References: <20200811084531.677853-1-damien.lemoal@wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200811084531.677853-1-damien.lemoal@wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.9-rc1
X-PR-Tracked-Commit-Id: 4c96870e58f8bce1c7eba5f92ec69089ae6798f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57d528bfe7d7279d7e91a9bd9803837835c09b5c
Message-Id: <159719250574.21709.4597902111965668707.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Aug 2020 00:35:05 +0000
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 11 Aug 2020 17:45:31 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57d528bfe7d7279d7e91a9bd9803837835c09b5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
