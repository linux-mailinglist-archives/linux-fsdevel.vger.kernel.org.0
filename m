Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41864115815
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 21:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLFUBC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 15:01:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfLFUBC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 15:01:02 -0500
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DDDF2245C;
        Fri,  6 Dec 2019 19:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575661903;
        bh=79RvXak1dP5bCbsaEmGOMsdl02gOD69RYh+qUaJSG0E=;
        h=Date:From:To:Cc:Subject:From;
        b=X/cgc1ZvXOhYRyVK3HYtCz3uTC+DCt8OUyz1130hFD7loo0n/81SfY6qJnvvMhh25
         VUPHjlK4WOn6EzAdIwAmtcYkMDddghKzHNVG5h0/IC5napYD2Rm2e9E61fUi1yduEt
         +KqGUNV3H/SmK3gvQz+sIUtcl9VGinrEKDxlDJM4=
Date:   Fri, 6 Dec 2019 11:51:42 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for 5.5-rc1
Message-ID: <20191206195142.GA9464@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull these bug fixes for 5.5-rc1, which fix a couple of resource
management errors and a hang.

The branch has survived a couple of days of xfstests runs and merges
cleanly with this morning's master.  Please let me know if anything
strange happens.

--D

The following changes since commit 8feb4732ff9f2732354b44c4418569974e2f949c:

  xfs: allow parent directory scans to be interrupted with fatal signals (2019-11-27 08:23:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.5-merge-17

for you to fetch changes up to 798a9cada4694ca8d970259f216cec47e675bfd5:

  xfs: fix mount failure crash on invalid iclog memory access (2019-12-03 14:53:07 -0800)

----------------------------------------------------------------
Fixes for 5.5-rc1:
- Fix a crash in the log setup code when log mounting fails
- Fix a hang when allocating space on the realtime device
- Fix a block leak when freeing space on the realtime device

----------------------------------------------------------------
Brian Foster (1):
      xfs: fix mount failure crash on invalid iclog memory access

Omar Sandoval (2):
      xfs: fix realtime file data space leak
      xfs: don't check for AG deadlock for realtime files in bunmapi

 fs/xfs/libxfs/xfs_bmap.c | 27 +++++++++++++++------------
 fs/xfs/xfs_log.c         |  2 ++
 2 files changed, 17 insertions(+), 12 deletions(-)
