Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E6C23A003
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 09:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgHCHHd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 03:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbgHCHHc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 03:07:32 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EFF3206D7;
        Mon,  3 Aug 2020 07:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596438451;
        bh=aStiuzKTnTOpXn5Co7qVE8vcvrnMgBKSnzbqQOzxF20=;
        h=Date:From:To:Cc:Subject:From;
        b=BcCsL8zea7GPg2m/ieqZwlovtsHdky30BYHF1wuu7BqV4ZLnuN4Y6xM4zgUDhKE9m
         zuomvzHyJEr0qY7zJIYNH3OXXfF9GfCSC8/wPWAcNNDKZBmx9V1Mzki1ejys2l52/t
         j5CBsAf22nHPs7w0TDYpAHMQttavHk+Fy3DViY5g=
Date:   Mon, 3 Aug 2020 00:07:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fsverity updates for 5.9
Message-ID: <20200803070730.GB24480@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit ba47d845d715a010f7b51f6f89bae32845e6acb7:

  Linux 5.8-rc6 (2020-07-19 15:41:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

for you to fetch changes up to f3db0bed458314a835ccef5ccb130270c5b2cf04:

  fs-verity: use smp_load_acquire() for ->i_verity_info (2020-07-21 16:02:41 -0700)

----------------------------------------------------------------

One fix for fs/verity/ to strengthen a memory barrier which might be too
weak.  This mirrors a similar fix in fs/crypto/.

----------------------------------------------------------------
Eric Biggers (1):
      fs-verity: use smp_load_acquire() for ->i_verity_info

 fs/verity/open.c         | 15 ++++++++++++---
 include/linux/fsverity.h |  9 +++++++--
 2 files changed, 19 insertions(+), 5 deletions(-)
