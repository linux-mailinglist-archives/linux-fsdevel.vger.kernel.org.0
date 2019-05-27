Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71FC42B22E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 12:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfE0KcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 06:32:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:52432 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbfE0KcO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 06:32:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4502AAE27;
        Mon, 27 May 2019 10:32:12 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mm@kvack.org
Cc:     Juergen Gross <jgross@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 0/3] remove tmem and code depending on it
Date:   Mon, 27 May 2019 12:32:04 +0200
Message-Id: <20190527103207.13287-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tmem has been an experimental Xen feature which has been dropped
recently due to security problems and lack of maintainership.

So it is time now to drop it in Linux kernel, too.

Juergen Gross (3):
  xen: remove tmem driver
  mm: remove cleancache.c
  mm: remove tmem specifics from frontswap

 Documentation/admin-guide/kernel-parameters.txt |  21 -
 Documentation/vm/cleancache.rst                 | 296 ------------
 Documentation/vm/frontswap.rst                  |  27 +-
 Documentation/vm/index.rst                      |   1 -
 MAINTAINERS                                     |   7 -
 drivers/staging/erofs/data.c                    |   6 -
 drivers/staging/erofs/internal.h                |   1 -
 drivers/xen/Kconfig                             |  23 -
 drivers/xen/Makefile                            |   2 -
 drivers/xen/tmem.c                              | 419 -----------------
 drivers/xen/xen-balloon.c                       |   2 -
 drivers/xen/xen-selfballoon.c                   | 579 ------------------------
 fs/block_dev.c                                  |   5 -
 fs/btrfs/extent_io.c                            |   9 -
 fs/btrfs/super.c                                |   2 -
 fs/ext4/readpage.c                              |   6 -
 fs/ext4/super.c                                 |   2 -
 fs/f2fs/data.c                                  |   3 +-
 fs/mpage.c                                      |   7 -
 fs/ocfs2/super.c                                |   2 -
 fs/super.c                                      |   3 -
 include/linux/cleancache.h                      | 124 -----
 include/linux/frontswap.h                       |   5 -
 include/linux/fs.h                              |   5 -
 include/xen/balloon.h                           |   8 -
 include/xen/tmem.h                              |  18 -
 mm/Kconfig                                      |  38 +-
 mm/Makefile                                     |   1 -
 mm/cleancache.c                                 | 317 -------------
 mm/filemap.c                                    |  11 -
 mm/frontswap.c                                  | 156 +------
 mm/truncate.c                                   |  15 +-
 32 files changed, 17 insertions(+), 2104 deletions(-)
 delete mode 100644 Documentation/vm/cleancache.rst
 delete mode 100644 drivers/xen/tmem.c
 delete mode 100644 drivers/xen/xen-selfballoon.c
 delete mode 100644 include/linux/cleancache.h
 delete mode 100644 include/xen/tmem.h
 delete mode 100644 mm/cleancache.c

-- 
2.16.4

