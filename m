Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFEB6D30DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 20:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfJJSuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 14:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfJJSuD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:50:03 -0400
Subject: Re: [GIT PULL] xfs: fixes for 5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570733402;
        bh=s3uIL/Z1b3UQKalI9NtPRMT+y12PpiywCPgPBwN6HDM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JNou5fwVAdO2KkavzuArqeNOvd705ycNTBdtpvbmGajtWbE7LsuVSTg98zLRM7TP6
         b4G9YJfNDiGdmAYBOmWOAs6/cZnqU5FPndvdWvbyLCUdtTWpN9zqMPMq6vDNoSGxj6
         sy+1XWbeblSdJOgZMicKrYtEDbxHegOwrh/4VfxY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191010165314.GP1473994@magnolia>
References: <20191010165314.GP1473994@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191010165314.GP1473994@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.4-fixes-3
X-PR-Tracked-Commit-Id: aeea4b75f045294e1c026acc380466daa43afc65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e208aa06c2109b45eec6be049a8e47034748c20
Message-Id: <157073340283.27451.569926685853295034.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Oct 2019 18:50:02 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 10 Oct 2019 09:53:14 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.4-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e208aa06c2109b45eec6be049a8e47034748c20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
