Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 219B05C44C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 22:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfGAU0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 16:26:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfGAU0s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:26:48 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E65EA20B7C;
        Mon,  1 Jul 2019 20:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562012808;
        bh=bHXVVLIgc6WfqlmFZzYaV90ylrhq4JfZ8EnmuXsM1vM=;
        h=From:To:Cc:Subject:Date:From;
        b=OSpbrUwWPr0XVE/7R0/wA16gYkmjSek15Tqav6ajumHVktyFYoEoorUuZQF+gflA4
         84F055Vx3NQftnhPrev4FSE19+whHobVMOFxeN4CJyKBcQqhWVncSNbipYtNqAprpc
         VnbcSOFO5cSX4XOoH65e53wf4vd8lDttaWBoyZXQ=
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] f2fs: use generic helpers for FS_IOC_{SETFLAGS,FSSETXATTR}
Date:   Mon,  1 Jul 2019 13:26:27 -0700
Message-Id: <20190701202630.43776-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series converts f2fs to use the new VFS helper functions that check
the parameters of the FS_IOC_SETFLAGS and FS_IOC_FSSETXATTR ioctls.

This applies to the merge of the f2fs/dev and xfs/vfs-for-next branches:

	https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev
	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/log/?h=vfs-for-next

i.e., this series will apply to mainline after these two branches get
merged into it for 5.3.  Don't apply it to the f2fs tree by itself yet.

See: https://lore.kernel.org/lkml/20190701110603.5abcbb2c@canb.auug.org.au/T/#u

Eric Biggers (3):
  f2fs: use generic checking and prep function for FS_IOC_SETFLAGS
  f2fs: use generic checking function for FS_IOC_FSSETXATTR
  f2fs: remove redundant check from f2fs_setflags_common()

 fs/f2fs/file.c | 63 ++++++++++++++++++--------------------------------
 1 file changed, 23 insertions(+), 40 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

