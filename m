Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B02E19C6DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 18:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389729AbgDBQQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 12:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389294AbgDBQQC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:16:02 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A046206F6;
        Thu,  2 Apr 2020 16:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585844161;
        bh=5sJ1neYRlFfnjmBdPQnALhSYTIW7R6idfr1HV3eUbLU=;
        h=Date:From:To:Cc:Subject:From;
        b=YuhxEisGg+czlF11Le0CA11rrUCK7T8ASCuF1CFQHyBEUJrvTq/rCB1UujzNyDe1X
         VjK4w+H39cMykLfIt/aFcG9POPQyRHDTTx/mRNNjdzufzincHrkhof11UNEtV2F9Om
         HASncbRRl6laAeF0bd5jKvhXhvlj30rEOQLT8gBM=
Date:   Thu, 2 Apr 2020 09:16:00 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, domenico.andreoli@linux.com
Subject: [GIT PULL] vfs: bug fix for 5.7
Message-ID: <20200402161600.GI80283@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this single vfs bug fix into 5.7 to fix a regression in
userspace hibernation now that the vfs doesn't really allow userspace to
write to active swap devices anymore.

--D

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.7-merge-1

for you to fetch changes up to 56939e014a6c212b317414faa307029e2e80c3b9:

  hibernate: Allow uswsusp to write to swap (2020-03-23 08:22:15 -0700)

----------------------------------------------------------------
New code for 5.7:
 - Fix a regression where we broke the userspace hibernation driver by
   disallowing writes to the swap device.

----------------------------------------------------------------
Domenico Andreoli (1):
      hibernate: Allow uswsusp to write to swap

 fs/block_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
