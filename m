Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8213F1EED35
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 23:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgFDVPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 17:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgFDVPD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:15:03 -0400
Subject: Re: [GIT PULL] zonefs changes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591305302;
        bh=frNXH24Zn/gPh4VbstsxTb1ziUqwVdtibMNpZCuMg1g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QU1TExwHROgMCCI5Ywkx0NDfbMOJ0j+sA1K+b4R/LOvwN1ZkxElXIQ3NvNuBdvlN9
         n+9bUlCKkgx3/7REnujswSeS3eLgtOtyZovVY6zwLN1sPilBmMoyzw/nWJdV85bvHZ
         nwxBlnRdyPMnqreGFsRtUeX0lIOcVedD5TFbpxS4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200603235449.26207-1-damien.lemoal@wdc.com>
References: <20200603235449.26207-1-damien.lemoal@wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200603235449.26207-1-damien.lemoal@wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/
 tags/zonefs-5.8-rc1
X-PR-Tracked-Commit-Id: 568776f992c4cb5e1b5715dc4ab62e6ae906b80d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d77d1dbba95500d1b38cab98bf608ad46dce8374
Message-Id: <159130530268.6506.3988588058392313399.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 21:15:02 +0000
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu,  4 Jun 2020 08:54:49 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d77d1dbba95500d1b38cab98bf608ad46dce8374

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
