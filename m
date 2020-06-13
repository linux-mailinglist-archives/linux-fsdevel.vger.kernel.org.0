Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86C81F8127
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 07:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFMFog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 01:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgFMFof (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 01:44:35 -0400
Received: from localhost (unknown [148.87.23.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C59D20739;
        Sat, 13 Jun 2020 05:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592027075;
        bh=XmdgFCb8PhQn6m2lb86DZFY1Nriu85HXZE4h27AQOYk=;
        h=Date:From:To:Cc:Subject:From;
        b=WR45C6kohNi2Z4R07y9g/4IsViEcofHefMVQ94boLbU+V1HmI/GymAxGAsJt9Wkfq
         KqNATLCKmodI/m/q0/TI9/2nFsDaq+QquG4Y0Inwh2qxgB29hq22NymBHqe1TeJQrz
         p70NrgbYdH6ueobyOFMG+OxSL26AIy7i/qIqqVWU=
Date:   Fri, 12 Jun 2020 22:44:31 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, riteshh@linux.ibm.com
Subject: [GIT PULL] iomap: bug fix for 5.8-rc1
Message-ID: <20200613054431.GL11245@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this single iomap bug fix for 5.8-rc1 that fixes a variable
type mistake on 32-bit architectures.  The branch merged cleanly with
upstream head as of a few minutes ago.

--D

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.8-merge-1

for you to fetch changes up to d4ff3b2ef901cd451fb8a9ff4623d060a79502cd:

  iomap: Fix unsharing of an extent >2GB on a 32-bit machine (2020-06-08 20:58:29 -0700)

----------------------------------------------------------------
New code for 5.8:
- Fix an integer overflow problem in the unshare actor.

----------------------------------------------------------------
Matthew Wilcox (Oracle) (1):
      iomap: Fix unsharing of an extent >2GB on a 32-bit machine

 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
